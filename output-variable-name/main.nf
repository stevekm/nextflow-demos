// character strings in place of files for demonstration
Channel.from(["Sample1.fastq.gz", "Sample2.fastq.gz"]).set { samples_fastqs }
params.output_dir = "output"

process make_files {
    tag "${fastq}"
    publishDir "${params.output_dir}/make_files", mode: 'copy', overwrite: true

    input:
    val(fastq) from samples_fastqs

    output:
    set val(fastq), file(output_html), file(output_zip) into sample_files

    script:
    // variable output file names set from Groovy variables inside the process
    output_html = "${fastq}".replaceFirst(/.fastq.gz$/, "_fastqc.html")
    output_zip = "${fastq}".replaceFirst(/.fastq.gz$/, "_fastqc.zip")
    """
    touch "${output_html}"
    touch "${output_zip}"
    """
}

process get_files {
    tag "${fastq}"
    echo true

    input:
    set val(fastq), file(html), file(zip) from sample_files

    script:
    """
    echo "[get_files] recieved files: ${html} ${zip}"
    """
}
