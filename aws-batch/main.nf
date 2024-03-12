nextflow.enable.dsl=2

params.outdir = "output"

process ECHO {
    tag "${x}"
    publishDir "${params.outdir}"

    container "ubuntu:latest"

    input:
    val(x)

    output:
    tuple val(x), path(output_file)

    script:
    output_file = "${x}.output.txt"
    """
    echo "${x}" > "${output_file}"
    """
}

workflow {
    input_ch = Channel.from(["foo", "bar", "baz"])
    ECHO(input_ch)
}