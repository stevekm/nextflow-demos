# AWS Batch - Get EC2 Instance ID

Methods to retrieve the EC2 instance ID for a running AWS Batch job in Nextflow.

Because while a Nextflow pipeline is running in AWS Batch, its extremely helpful to be able to debug by inspecting and introspecting the EC2 that the Batch Job is running on. However its currently very difficult to fish out the EC2 ID of the EC2 that the Job is running on, while the Job is running.

Note:

The method detailed here involves writing the EC2 ID to file on the local disk in the running EC2 ; however unless your Nextflow Work Dir is using Seqera Fusion this may or may not show up in the S3 work dir location in real time. If your AWS Batch is using local EBS volumes then the S3 locations often dont get populated until the task finishes.

Todo:

- move the methods to the `process.beforeScript` so that they could be run automatically before every Nextflow task
- move the methods into the Nextflow job Launch Template so that they could be run on the host EC2 prior to the Docker container of the Nextflow task starting ; this way you would not require a specific Docker conatiner for your task in order for it to work
- find some way for Nextflow to do this itself and record this information and expose it so that you can do debugging more easily