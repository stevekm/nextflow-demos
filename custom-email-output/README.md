# Custom Email Output

This demonstration shows simple methods for sending a custom email upon the completion of the Nextflow pipeline, and including email file attachments based on pipeline output.

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

The terminal output should look like this:

```
$ make run
export NXF_VER="0.28.0" && \
	curl -fsSL get.nextflow.io | bash

      N E X T F L O W
      version 0.28.0 build 4779
      last modified 10-03-2018 12:13 UTC (07:13 EDT)
      cite doi:10.1038/nbt.3820
      http://nextflow.io


Nextflow installation completed. Please note:
- the executable file `nextflow` has been created in the folder: /Users/kellys04/projects/nextflow-demos/custom-email-output
- you may complete the installation by moving it to a directory in your $PATH

./nextflow run main.nf
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [voluptuous_wiles] - revision: 1df6993c45
[warm up] executor > local
[d8/ff0371] Submitted process > make_file (Sample1)
[5f/154dc4] Submitted process > make_file (Sample3)
[97/891364] Submitted process > make_file (Sample2)
[cf/ebe7df] Submitted process > make_file (Sample4)
```

the email output should include file attachments, and look like this:

```
From: "kellys04@nyumc.org" <kellys04@nyumc.org>
Date: Friday, April 6, 2018 at 7:35 PM
To: Stephen <Stephen.Kelly@nyumc.org>
Subject: [custom_email_output] SUCCESS                        

Pipeline execution summary
---------------------------
Success           : true
exit status       : 0
Launch time       : 06-Apr-2018 19:35:28
Ending time       : 06-Apr-2018 19:35:28 (duration: 761ms)
Launch directory  : /Users/kellys04/projects/nextflow-demos/custom-email-output
Work directory    : /Users/kellys04/projects/nextflow-demos/custom-email-output/work
Project directory : /Users/kellys04/projects/nextflow-demos/custom-email-output
Script name       : main.nf
Script ID         : 1df6993c45b52cdb25e98b38f89820ec
Workflow session  : f1b281e0-27b0-498d-bcd5-fb2bc7dd1019
Workflow repo     : -
Workflow revision : -
Workflow profile  : standard
Workflow container: -
container engine  : -
Nextflow run name : voluptuous_wiles
Nextflow version  : 0.28.0, build 4779 (10-03-2018 12:13 UTC)
The command used to launch the workflow was as follows:
nextflow run main.nf
--
This email was sent by Nextflow
cite doi:10.1038/nbt.3820
```

Note that Nextflow uses the host system's built-in email client to send mail, which may be subject to its own configuration and troubleshooting if issues arise.

Also note the inclusion of the following lines in `main.nf`:

```
username = System.getProperty("user.name") # 1
params.email_host = "nyumc.org" # 2
```
1. Groovy code is used in the pipeline to obtain the username of the current user

2. A default email hostname is provided, but can be changed using command line parameters;

```
$ ./nextflow run main.nf --email_host "someplace.edu"
```

Will result in an email address of `<username>@someplace.edu`.
