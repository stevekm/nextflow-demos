Channel.from( ['Sample1','Sample2','Sample3','Sample4','Sample5','Sample6','Sample7'] ).set { samples }

params.output_dir = "output"

process make_file {
    tag { "${sampleID}" }
    publishDir "${params.output_dir}/make_file", mode: 'copy', overwrite: true

    input:
    val(sampleID) from samples

    output:
    file("${sampleID}.txt") into (sample_files, sample_files2)

    script:
    """
    sleep 5
    echo "[make_file] ${sampleID}" > "${sampleID}.txt"
    """
}
sample_files2.collectFile(name: 'sample_files.txt', storeDir: "${params.output_dir}")

process collect_files {
    publishDir "${params.output_dir}/collect_files", mode: 'copy', overwrite: true

    input:
    file(files:"*") from sample_files.collect()

    output:
    file(files)

    script:
    """
    """

}
