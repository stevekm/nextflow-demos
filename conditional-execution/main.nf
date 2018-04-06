Channel.fromPath( 'input/fastq/*.fastq.gz' ).set { input_fastqs }
params.output_dir = "output"

process fastqc {
    tag { "${fastq}" }
    publishDir "${params.output_dir}/fastqc", mode: 'copy', overwrite: true
    echo true

    input:
    file(fastq) from input_fastqs

    output:
    file(output_html)
    file(output_zip)

    script:
    output_html = "${fastq}".replaceFirst(/.fastq.gz$/, "_fastqc.html")
    output_zip = "${fastq}".replaceFirst(/.fastq.gz$/, "_fastqc.zip")
    """
    which fastqc
    fastqc -o . "${fastq}"
    """
}
