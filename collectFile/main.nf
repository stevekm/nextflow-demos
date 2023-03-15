Channel.from( ['Sample1','Sample2','Sample3'] ).into { samples; samples2 }

params.output_dir = "output"

process make_file {
    tag { "${sampleID}" }
    echo true
    publishDir "${params.output_dir}/make_file", mode: 'copy', overwrite: true

    input:
    val(sampleID) from samples

    output:
    file("${sampleID}.txt") into (sample_files, sample_files2)

    script:
    """
    echo "[make_file] ${sampleID}"
    echo "[make_file] ${sampleID}" > "${sampleID}.txt"
    """
}
sample_files.collectFile(name: 'sample_files.txt').set { collected_file } // 'name' is required

process print_collected_file {
    echo true

    input:
    file(txt) from collected_file

    script:
    """
    cat "${txt}" | sed -e 's|^|[print_collected_file (${txt})]: |'
    """
}
