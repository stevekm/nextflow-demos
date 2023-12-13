# email notification

Usage of the default email notification, and custom notification email, using templates, and the workflow completion handler.

- https://www.nextflow.io/docs/latest/config.html#scope-notification
- https://www.nextflow.io/docs/latest/mail.html
- https://github.com/nextflow-io/nextflow/blob/master/modules/nextflow/src/main/resources/nextflow/mail/notification.txt
  - https://github.com/nextflow-io/nextflow/blob/master/modules/nextflow/src/main/resources/nextflow/mail/notification.html

Run with

```
nextflow run main.nf --emailTo ...
```

Use custom notification template

```
nextflow -c custom-notification.config run main.nf --emailTo ...
```
- NOTE: this does not yet work but will soon with updated versions of Nextflow