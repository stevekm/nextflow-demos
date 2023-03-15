Channel.from( ['Sample1','Sample2','Sample3','Sample4'] ).set { samples }

params.output_dir = "output"

log.info "~~~~~~~~~~~~~~~~~~~~~"
log.info "${workflow.sessionId} ${workflow.runName}"

process make_file {
    publishDir "${params.output_dir}", mode: 'copy'

    input:
    val(sampleID) from samples

    output:
    file("${sampleID}.txt") into (sample_files, sample_files2, sample_files3, sample_files4)

    script:
    """
    echo "[make_file] ${sampleID}" > "${sampleID}.txt"
    """
}

process gather_files1 {
    // on 'resume', output should be cached and should not be re-copied to publishDir
    publishDir "${params.output_dir}", mode: 'copy'

    input:
    file("*") from sample_files.collect()

    output:
    file("${output_file}")

    script:
    output_file = "output1.txt"
    """
    cat * > "${output_file}"
    """
}


process gather_files2 {
    // on 'resume', output should be cached but should be re-copied to publishDir
    publishDir "${params.output_dir}", mode: 'copy', overwrite: true

    input:
    file("*") from sample_files3.collect()

    output:
    file("${output_file}")

    script:
    output_file = "output2.txt"
    """
    cat * > "${output_file}"
    """
}

process gather_files3 {
    // on 'resume', process will be re-run and new output should be copied to publishDir
    publishDir "${params.output_dir}", mode: 'copy'

    input:
    file("*") from sample_files2.collect()

    output:
    file("${output_file}")

    script:
    output_file = "output3.txt"
    """
    cat * > "${output_file}"
    echo "${workflow.sessionId} ${workflow.runName}" >> "${output_file}"
    """
}


process gather_files4 {
    // on 'resume', process will be re-run and new output should be copied to publishDir
    publishDir "${params.output_dir}", mode: 'copy', overwrite: true

    input:
    file("*") from sample_files4.collect()

    output:
    file("${output_file}")

    script:
    output_file = "output4.txt"
    """
    cat * > "${output_file}"
    echo "${workflow.sessionId} ${workflow.runName}" >> "${output_file}"
    """
}
