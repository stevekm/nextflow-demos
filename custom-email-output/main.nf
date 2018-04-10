username = System.getProperty("user.name")
params.email_host = "nyumc.org"
params.email_from = "${username}@${params.email_host}"
params.email_to = "${username}@${params.email_host}"

Channel.from( ['Sample1','Sample2','Sample3','Sample4'] )
        .set { samples }

process make_file {
    tag "${sampleID}"

    input:
    val(sampleID) from samples

    output:
    file("${sampleID}.txt") into sample_files

    script:
    """
    echo "[print_sample] ${sampleID}" > "${sampleID}.txt"
    """
}

def attachments = sample_files.toList().getVal()

workflow.onComplete {
    def status = "NA"
    if(workflow.success) {
        status = "SUCCESS"
    } else {
        status = "FAILED"
    }
    def msg = """
        Pipeline execution summary
        ---------------------------
        Success           : ${workflow.success}
        exit status       : ${workflow.exitStatus}
        Launch time       : ${workflow.start.format('dd-MMM-yyyy HH:mm:ss')}
        Ending time       : ${workflow.complete.format('dd-MMM-yyyy HH:mm:ss')} (duration: ${workflow.duration})
        Launch directory  : ${workflow.launchDir}
        Work directory    : ${workflow.workDir.toUriString()}
        Project directory : ${workflow.projectDir}
        Script name       : ${workflow.scriptName ?: '-'}
        Script ID         : ${workflow.scriptId ?: '-'}
        Workflow session  : ${workflow.sessionId}
        Workflow repo     : ${workflow.repository ?: '-' }
        Workflow revision : ${workflow.repository ? "$workflow.revision ($workflow.commitId)" : '-'}
        Workflow profile  : ${workflow.profile ?: '-'}
        Workflow container: ${workflow.container ?: '-'}
        container engine  : ${workflow.containerEngine?:'-'}
        Nextflow run name : ${workflow.runName}
        Nextflow version  : ${workflow.nextflow.version}, build ${workflow.nextflow.build} (${workflow.nextflow.timestamp})
        The command used to launch the workflow was as follows:
        ${workflow.commandLine}
        --
        This email was sent by Nextflow
        cite doi:10.1038/nbt.3820
        http://nextflow.io
        """
        .stripIndent()

    sendMail {
        to "${params.email_to}"
        from "${params.email_from}"
        attach attachments
        subject "[custom_email_output] ${status}"
        body
        """
        ${msg}
        """
        .stripIndent()
    }
}
