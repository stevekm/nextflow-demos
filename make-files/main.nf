Channel.from( ['Sample1','Sample2','Sample3','Sample4'] )
        .set { samples }

process make_file {
    tag "${sampleID}"

    input:
    val(sampleID) from samples

    output:
    file("${sampleID}.txt") into sample_files

    script:
    """
    echo "[print_sample] ${sampleID}" > "${sampleID}.txt"
    """
}

process print_file {
    tag "${sample_file}"
    echo true

    input:
    file(sample_file) from sample_files

    script:
    """
    echo "[print_file] contents of ${sample_file}: \$(cat ${sample_file})"
    """
}
