params.output_dir = "output/people"
params.report_file = "report/people.Rmd"

Channel.from([
    ["Helena", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Helena_scan.jpg/383px-Helena_scan.jpg"],
    ["Albert", "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Prince_Albert_of_Saxe-Coburg-Gotha_by_Franz_Xaver_Winterhalter.jpg/390px-Prince_Albert_of_Saxe-Coburg-Gotha_by_Franz_Xaver_Winterhalter.jpg"],
    ["Victoria", "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Queen_Victoria_by_Bassano.jpg/340px-Queen_Victoria_by_Bassano.jpg"]
    ])
    .tap { people_links }
    .map { name, url ->
        return(name)
    }
    .set { people_names }

Channel.fromPath(params.report_file).set { report_file }


process download_pics {
    tag "${name}"
    publishDir "${params.output_dir}/${name}", overwrite: true

    input:
    set val(name), val(url) from people_links

    output:
    set val(name), val(url), file("${output}") into people_pics

    script:
    output = "${name}.jpg"
    """
    # download image
    wget "${url}" -O "${output}"
    """
}

process create_db {
    tag "${name}"

    input:
    val(name) from people_names

    output:
    set val(name), file("${output_db}") into people_dbs

    script:
    output_db = "${name}.sqlite"
    """
    # create a new database
    sqlite3 "${output_db}" "CREATE TABLE TBL1(NAME TEXT, URL TEXT, FILENAME TEXT, PIC BLOB);"
    """
}

people_pics.combine(people_dbs, by: 0).set { people_db_files }

process update_dbs {
    tag "${name}"
    publishDir "${params.output_dir}/${name}", overwrite: true

    input:
    set val(name), val(url), file(pic), file(db) from people_db_files

    output:
    file("${db}") into people_updated_dbs

    script:
    """
    #!/usr/bin/env python
    import sqlite3
    conn = sqlite3.connect("${db}")

    # insert the image file into the database, with metadata
    with open("${pic}", 'rb') as input_file:
            blob = input_file.read()
            sql = '''
            INSERT INTO TBL1 (NAME, URL, FILENAME, PIC) VALUES(?, ?, ?, ?);
            '''
            conn.execute(sql,["${name}", "${url}", "${pic}", sqlite3.Binary(blob)])
            conn.commit()
    conn.close()
    """
}

process concat_dbs {
    publishDir "${params.output_dir}", overwrite: true

    input:
    file(all_dbs: "db?") from people_updated_dbs.collect()

    output:
    file("${output_sqlite}") into people_db

    script:
    output_sqlite = "people.sqlite"
    """
    python - ${all_dbs} <<E0F
import sys
import sqlite3

dbs = sys.argv[1:]

# setup new output db
output_db = "${output_sqlite}"
conn = sqlite3.connect(output_db)
conn.execute("CREATE TABLE TBL1(NAME TEXT, URL TEXT, FILENAME TEXT, PIC BLOB)")

# add each input db to the output db
for db in dbs:
    conn.execute('''ATTACH '{0}' as dba'''.format(db))
    conn.execute("BEGIN")
    for row in conn.execute('''SELECT * FROM dba.sqlite_master WHERE type="table"'''):
        combine_sql = "INSERT INTO "+ row[1] + " SELECT * FROM dba." + row[1]
        conn.execute(combine_sql)
    conn.commit()
    conn.execute("detach database dba")
E0F
    """
}

process report {
    publishDir "${params.output_dir}", overwrite: true, mode: "move"

    input:
    set file(db), file(report) from people_db.combine(report_file)

    output:
    file("${html_output}")

    script:
    html_output = "people.html"
    """
    # convert report file symlinks to copies of original files, because knitr wants Rmd to be in pwd
    for item in *.Rmd; do
        if [ -L "\${item}" ]; then
            sourcepath="\$(python -c "import os; print(os.path.realpath('\${item}'))")"
            echo ">>> resolving source file: \${sourcepath}"
            rsync -va "\${sourcepath}" "\${item}"
        fi
    done

    # compile the report
    Rscript -e 'rmarkdown::render(input = "${report}", params = list(db = "${db}"), output_format = "html_document", output_file = "${html_output}")'
    """
}
