Channel.from( ['Sample1','Sample2','Sample3','Sample4'] )
        .set { samples }

process make_file {
    tag "${output_file}"

    input:
    val(sampleID) from samples

    output:
    file("${output_file}") into sample_files

    script:
    output_file = "${sampleID}.txt"
    """
    echo "[print_sample] ${sampleID}" > "${output_file}"
    """
}

sample_files.map { item ->
    return(new File("${item}").getCanonicalPath())
}
.collectFile(name: "files.txt", newLine: true).set { file_list }

process print_file {
    echo true

    input:
    file(list) from file_list

    script:
    """
    printf "[print_file]:\\n%s" "\$(cat "${list}")"
    """
}
