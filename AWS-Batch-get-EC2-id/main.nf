process AWS_BATCH_FIND_EC2 {
    debug true

    publishDir "${params.outdir}/aws-batch", mode: 'copy'

    // must use a container that has aws cli pre-installed
    // example https://gallery.ecr.aws/aws-cli/aws-cli
    container 'public.ecr.aws/aws-cli/aws-cli:2.27.12'

    output:
    path("batch.job.json"), optional: true
    path("ecs.meta.json"), optional: true
    path("account_id.txt"), optional: true
    path("stdout.txt")
    path("env.txt")

    script:
    """
    env > env.txt

    # check if we are running in AWS Batch
    if [ -n "\${AWS_BATCH_JOB_ID+1}" ]; then

        echo "Job ID:          \${AWS_BATCH_JOB_ID:-none}"
        echo "Queue:           \${AWS_BATCH_JOB_QUEUE:-\${AWS_BATCH_JQ_NAME:-none}}"
        echo "Compute Environment:           \${AWS_BATCH_CE_NAME:-none}"
        echo "Definition:      \${AWS_BATCH_JOB_DEFINITION:-none}"
        echo "Attempt:         \${AWS_BATCH_JOB_ATTEMPT:-none}"

        aws batch describe-jobs --jobs "\$AWS_BATCH_JOB_ID" --output json > "batch.job.json"

        # try to access the AWS EC2 IMDS ; does not work on Fargate instances
        EC2_ID="\$(curl -s http://169.254.169.254/latest/meta-data/instance-id)"
        echo "EC2 Instance:    \$EC2_ID"

        curl -s \${AWS_CONTAINER_METADATA_URI_V4:-\${ECS_CONTAINER_METADATA_URI_V4}} | jq . > ecs.meta.json

        aws sts get-caller-identity --query Account --output text > account_id.txt

    else
        echo "AWS_BATCH_JOB_ID is not set ; not running in AWS Batch"
    fi

    cp .command.out stdout.txt
    """
}

workflow {
    AWS_BATCH_FIND_EC2()
}