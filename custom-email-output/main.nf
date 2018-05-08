username = System.getProperty("user.name")
params.email_host = "nyumc.org"
params.email_from = "${username}@${params.email_host}"
params.email_to = "${username}@${params.email_host}"

Channel.from( ['Sample1','Sample2','Sample3','Sample4'] )
        .set { samples }

// send mail anywhere in the pipeline
sendMail {
  from "${params.email_to}"
  to "${params.email_from}"
  subject '[sendMail]'
  '''
  hello
  '''
}

process make_file {
    publishDir "output/email/attachments", mode: "copy"
    tag "${sampleID}"

    input:
    val(sampleID) from samples

    output:
    file("${sampleID}.txt") into (sample_files, sample_files2, sample_files3)

    script:
    """
    echo "[print_sample] ${sampleID}" > "${sampleID}.txt"
    """
}

// send mail from a process
process send_file {
  input:
  val mail from sample_files2.collect()

  exec:
  sendMail {
    from "${params.email_to}"
    to "${params.email_from}"
    subject '[send_file]'
    attach mail
    '''
    Check the attachment
    '''
  }
}

// send mail from a channel
sample_files3.collect()
            .subscribe { attachments_list ->
                sendMail {
                  from "${params.email_to}"
                  to "${params.email_from}"
                  subject '[sample_files3]'
                  attach attachments_list
                  '''
                  Check the attachment
                  '''
                }
            }

// send mail upon workflow completion
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

    def subject = "[custom_email_output] ${status}"

    // save a copy of the email message and subject line
    def email_body = new File("output/email/body.txt")
    email_body.write "${msg}".stripIndent()
    def email_subject = new File("output/email/subject.txt")
    email_subject.write "${subject}"

    sendMail {
        to "${params.email_to}"
        from "${params.email_from}"
        attach attachments
        subject
        body
        """
        ${msg}
        """
        .stripIndent()
    }
}
