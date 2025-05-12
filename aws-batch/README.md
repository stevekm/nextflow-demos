# AWS Batch Execution

Configuring your pipeline to run with AWS Batch is too complex for a simple demo, so these notes are retained for reference.

- https://www.nextflow.io/docs/latest/awscloud.html
- https://t-neumann.github.io/pipelines/AWS-pipeline/
- https://web.archive.org/web/20220419130401/https://apeltzer.github.io/post/01-aws-nfcore/
- https://seqera.io/blog/nextflow-and-aws-batch-inside-the-integration-part-2-of-3/
- https://www.udemy.com/course/aws-certified-cloud-practitioner-training-course/

## Setup

- make an account with AWS https://aws.amazon.com/ and log in to the web dashboard
  - make sure to configure an IAM user, and configure MFA for both root and IAM user accounts
  - add a local cli key with `aws configure` using the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- create IAM User Group with the following Roles and add the IAM User to the Group
  - AmazonS3FullAccess
  - ... (insert list of roles here...)
- Create AMI by first starting an EC2 instance
  - EC2 > Launch Instance > Browse More AMI's
    - AWS Marketplace AMIs > search for "Amazon ECS-Optimized Linux AMI"
    - scroll down until you find this one https://aws.amazon.com/marketplace/pp/prodview-2l3oufmhdyhrg?sr=0-2&ref_=beagle&applicationId=AWS-EC2-Console
      - amzn-ami-2018.03.20240319-amazon-ecs-optimized ; ami-093d9f343e2236e99
  - choose an t2.small EC2 instance type with 2GB memory to avoid low-memory issues
  - select a key pair (create one if you dont have it already)
    - make sure to store the .pem key file in a safe place such as `~/.ssh` with proper `chmod 600` permissions
  - include 30GB free tier EBS storage (total between root volume 8GB and EBS volume 22GB)
  - most of the rest of the settings can be left at default
  - launch instance
  - navigate to the instance page and copy the Public IPv4 DNS (`ec2-xx-yy-zz-qq.compute-1.amazonaws.com`)
  - `ssh` into your instance
    - `ssh -i ~/.ssh/my-aws-key.pem ec2-user@ec2-xx-yy-zz-qq.compute-1.amazonaws.com`
  - install required dependencies

```bash
sudo yum install -y bzip2 wget
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -f -p $HOME/miniconda
# this might break if you have less than 2GB memory; if so see the "add swap" instructions below
$HOME/miniconda/bin/conda install -c conda-forge -y awscli
./miniconda/bin/aws --version
# aws-cli/1.32.70 Python/3.12.2 Linux/4.14.336-180.566.amzn1.x86_64 botocore/1.34.70

# make sure Docker is pre-installed
which docker
# /usr/bin/docker
```
  - save the AMI in the EC2 dashboard from the running EC2 instance
  - you can now terminate the EC2

- Create Compute Environment
  - AWS Batch > Compute Environments > Create Compute Environment > EC2
    - service role: AWSBatchServiceRole
    - instance role: ecsInstanceRole
    - min CPUs 0; desired CPUs 0; maximum CPUs 10; optimal instance types
    - add EC2 key pair
    - **add the AMI from the previous step to the AMI ID Override**

- Create Job Queue
  - AWS Batch > Job Queues > Create Job Queue
  - add Connected Compute Environment

If you have issues, check some of these

- AWS Batch > Permissions > "Grant AWS Batch permission to interface with Elastic Container Service (ECS) clusters settings"

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