# AWS Batch Execution

Configuring your pipeline to run with AWS Batch is too complex for a simple demo, so these notes are retained for reference.

- https://www.nextflow.io/docs/latest/awscloud.html
- https://t-neumann.github.io/pipelines/AWS-pipeline/
- https://apeltzer.github.io/post/01-aws-nfcore/
- https://seqera.io/blog/nextflow-and-aws-batch-inside-the-integration-part-2-of-3/
- https://www.udemy.com/course/aws-certified-cloud-practitioner-training-course/

## Setup

- make an account with AWS https://aws.amazon.com/ and log in to the web dashboard
  - make sure to configure an IAM user, and configure MFA for both root and IAM user accounts
  - add a local cli key with `aws configure` using the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## Demo Pipeline

Step 1: Update the included pipeline's `conf/awsbatch.config` file to match your AWS account's Batch settings

Step 2: Run pipeline with a command like this

```bash
nextflow run main.nf -profile awsbatch
```

for convenience, you can also pass in the required configs from `params` like this

```bash
nextflow run main.nf -profile awsbatch --workDir s3://foo-bar-nf-work --queue
my-job-queue
```

## Add Swap to your EC2 instance

If you chose a micro sized EC2 instance with only 1GB of memory, you may run out of memory when trying ot install Miniconda

```bash
$ $HOME/miniconda/bin/conda install -c conda-forge -y awscli

Channels:
 - conda-forge
 - defaults
Platform: linux-64
Collecting package metadata (repodata.json): done
Solving environment: \ Out of memory allocating 427819008 bytes!
Aborted
```

One solution is to add a 1GB Swap file and enable it for use in the instance

- https://www.howtogeek.com/455981/how-to-create-a-swap-file-on-linux/

```bash
# we have 8GB of space on the local attached EBS
$ df -H
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        502M   82k  502M   1% /dev
tmpfs           511M     0  511M   0% /dev/shm
/dev/xvda1      8.5G  4.1G  4.4G  48% /

# prepare a file for Swap
$ sudo dd if=/dev/zero of=/swapfile bs=1024 count=1048576

$ sudo mkswap /swapfile

$ sudo chmod 600 /swapfile

$ sudo swapon /swapfile

# optional: add to /etc/fstab
# /swapfile none swap sw 0 0

# check swap
$ swapon --show
NAME      TYPE  SIZE  USED PRIO
/swapfile file 1024M 33.3M   -2
```

Now we should have enough memory to install Miniconda and `awscli`