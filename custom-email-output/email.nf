// follow-up email to use after pipeline completes, if the inline emails do not work for some reason
username = System.getProperty("user.name")
params.email_host = "nyumc.org"
params.email_from = "${username}@${params.email_host}"
params.email_to = "${username}@${params.email_host}"

Channel.fromPath("output/email/attachments/*").set { email_attachments_channel }

String subject_line = new File("output/email/subject.txt").text
def body = new File("output/email/body.txt").text
def attachments = email_attachments_channel.toList().getVal()

// pause a moment before sending the email; 3s
sleep(3000)

sendMail {
  from "${params.email_to}"
  to "${params.email_from}"
  attach attachments
  subject subject_line
  """
  ${body}
  """.stripIndent()
}
