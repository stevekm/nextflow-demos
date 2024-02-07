# email notification

Usage of the default email notification, and custom notification email, using templates, and the workflow completion handler.

- https://www.nextflow.io/docs/latest/config.html#scope-notification
- https://www.nextflow.io/docs/latest/mail.html
- https://github.com/nextflow-io/nextflow/blob/master/modules/nextflow/src/main/resources/nextflow/mail/notification.txt
  - https://github.com/nextflow-io/nextflow/blob/master/modules/nextflow/src/main/resources/nextflow/mail/notification.html

#### Default Notification

```bash
$ nextflow run main.nf --emailTo ... --emailFrom ... --smtpHost ... --smtpPort ... --smtpUser ... --smtpPassword ... --smtpProtocols ...
```

#### Custom Notifications

Use custom notification template

```bash
$ nextflow -c custom-notification.config run main.nf ...
```
- NOTE: requires Nextflow version 23.10.1 or later

Use custom `workflow.onComplete` handler

```bash
$ nextflow -c custom-onComplete.config run main.nf ...
```

Use custom embedded template that is saved as a template string in the config file

```bash
$ nextflow -c custom-embedded-template.config run main.nf ...
```