nextflow.enable.dsl=2

params.outdir = "output"

process ECHO {
    tag "${x}"
    publishDir "${params.outdir}"

    // make sure to use Ubuntu or Debian based containers for best Nextflow compatibility
    container "ubuntu:latest"

    input:
    val(x)

    output:
    tuple val(x), path(output_file)

    script:
    output_file = "${x}.output.txt"
    """
    echo "${x}" > "${output_file}"

    # so that we can have time to see the job running in the AWS console
    sleep 15
    """
}

workflow {
    input_ch = Channel.from(["foo", "bar", "baz"])
    ECHO(input_ch)
}