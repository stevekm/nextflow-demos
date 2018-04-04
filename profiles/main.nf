Channel.fromPath( 'input/fastq/*.fastq.gz' ).set { input_fastqs }
params.output_dir = "output"


// input_fastq.println()
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
// process make_file {
//     tag { "${sampleID}" }
//     publishDir "${params.output_dir}/make_file", mode: 'copy', overwrite: true
//
//     input:
//     val(sampleID) from samples
//
//     output:
//     file("${sampleID}.txt") into (sample_files, sample_files2)
//
//     script:
//     """
//     sleep 5
//     echo "[make_file] ${sampleID}" > "${sampleID}.txt"
//     """
// }
// sample_files2.collectFile(name: 'sample_files.txt', storeDir: "${params.output_dir}")
//
// process collect_files {
//     publishDir "${params.output_dir}/collect_files", mode: 'copy', overwrite: true
//
//     input:
//     file(files:"*") from sample_files.collect()
//
//     output:
//     file(files)
//
//     script:
//     """
//     """
//
// }
