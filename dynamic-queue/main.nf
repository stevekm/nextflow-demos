Channel.from(1..100).set { input_ch }

process run {
    tag "${x}"

    input:
    val(x) from input_ch

    output:
    file("${output_file}") into output_files

    script:
    output_file = "${x}.txt"
    """
    # print all the job values to a file
    for item in ${params.job_vars}; do
        printf "\${item}: \${!item:-none}\t" >> "${output_file}"
    done
    printf '\n' >> "${output_file}"
    """
}
output_files.collectFile(name: "output.txt", storeDir: ".")
