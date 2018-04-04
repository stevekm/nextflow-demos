Channel.from( ['Sample1','Sample2','Sample3'] ).into { samples; samples2 }

params.output_dir = "output"

process print_sample {
    tag { "${sampleID}" }
    echo true

    input:
    val(sampleID) from samples

    script:
    """
    echo "[print_sample] sample is: ${sampleID}"
    """
}

process make_file {
    tag { "${sampleID}" }
    echo true
    publishDir "${params.output_dir}/make_file", mode: 'copy', overwrite: true

    input:
    val(sampleID) from samples2

    output:
    file("${sampleID}.txt") into (sample_files, sample_files2)

    script:
    """
    echo "[make_file] ${sampleID}"
    echo "[make_file] ${sampleID}" > "${sampleID}.txt"
    """
}
sample_files2.collectFile(name: 'sample_files.txt', storeDir: "${params.output_dir}")

process gather_files {
    echo true
    publishDir "${params.output_dir}/gather_files", mode: 'copy', overwrite: true

    input:
    file("*") from sample_files.collect()

    output:
    file("output.txt")

    script:
    """
    echo "[gather_files] gathering all files..."
    cat * > output.txt
    """
}
