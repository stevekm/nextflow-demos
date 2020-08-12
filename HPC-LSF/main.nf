Channel.fromPath("data/*.txt").set { input_ch }

process use_file {
    publishDir "output", mode: 'copy'
    echo true

    input:
    file(txt_file) from input_ch

    output:
    file("${output_file}")

    script:
    output_file = "${txt_file}".replaceFirst(/.txt$/, ".out.txt")
    """
    echo "doing a thing with file ${txt_file} on system \$(hostname)"
    touch "${output_file}"
    """
}
