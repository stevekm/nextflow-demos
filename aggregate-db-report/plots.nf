params.output_dir = "output/plots"
params.report_file = "report/plots.Rmd"

Channel.from([
    ['Sample1', [1, 2, 50]],
    ['Sample2', [1, 2, 100]],
    ['Sample3', [1, 4, 500]],
    ['Sample4', [1, 6, 30]]
        ])
        .tap { samples_inputs }
        .map { sampleID, items ->
            return(sampleID)
        }
        .set { sampleIDs }

Channel.fromPath(params.report_file).set { report_file }

process make_plot_dbs {
    tag "${sampleID}"
    publishDir "${params.output_dir}/${sampleID}", overwrite: true

    input:
    set val(sampleID), val(args) from samples_inputs

    output:
    file("${output_db}") into sample_dbs

    script:
    x = args[0]
    y = args[1]
    a = args[2]
    output_db = "plots.sqlite"
    """
    #!/usr/bin/env Rscript
    library("ggplot2")
    library("RSQLite")

    sampleID <- "${sampleID}"
    x <- as.numeric("${x}")
    y <- as.numeric("${y}")
    a <- as.numeric("${a}")

    # create database
    con <- dbConnect(SQLite(), "${output_db}")

    # setup database
    dbGetQuery(con, 'create table tbl1 (sampleID text, x text, y text, a text, baseplot blob, ggplot blob)')

    # make R plot object with ggplot2
    g <- ggplot(data = data.frame(x = rnorm(a, 1, x), y = rnorm(a, 1, y)), aes(x = x, y = y)) +
        geom_point()

    # base R plots cant be saved as object, but can be captured and reused later with R 3.3.0+
    pdf("test.pdf") # need open graphics device to record plot
    dev.control(displaylist="enable")
    plot(data.frame(x = rnorm(50, 1, 6), y = rnorm(50, 1, 8)))
    p <- serialize(recordPlot(), NULL)
    dev.off()

    # bundle the data in a dataframe
    df <- data.frame(a = a,
                    x = x,
                    y = y,
                    sampleID = sampleID,
                    baseplot = I(list(serialize(p, NULL))),
                    ggplot = I(list(serialize(g, NULL)))
                    )

    # insert data into the db
    dbGetPreparedQuery(con, 'insert into tbl1 (sampleID, x, y, a, baseplot, ggplot) values (:sampleID, :a, :x, :y, :baseplot, :ggplot)',
                   bind.data=df)
    """
}

process concat_dbs {
    publishDir "${params.output_dir}", overwrite: true

    input:
    file(all_dbs: "db?") from sample_dbs.collect()

    output:
    file("${output_sqlite}") into plots_db

    script:
    output_sqlite = "plots.sqlite"
    """
    python - ${all_dbs} <<E0F
import sys
import sqlite3

dbs = sys.argv[1:]

# setup new output db
output_db = "${output_sqlite}"
conn = sqlite3.connect(output_db)
conn.execute("CREATE TABLE TBL1(sampleID text, x text, y text, a text, baseplot blob, ggplot blob)")

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
    set file(db), file(report) from plots_db.combine(report_file)

    output:
    file("${html_output}")

    script:
    html_output = "plots.html"
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
