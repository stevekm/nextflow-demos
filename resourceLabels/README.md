# Dynamic and user-supplied `resourceLabel`'s for AWS Batch Job Cost Tracking

This demo shows how you can use dynamically generated and user supplied resource labels for AWS Batch Job cost tracking.

- Nextflow resource label docs; https://www.nextflow.io/docs/latest/process.html#resourcelabels

This demo pipeline does not actually include any AWS configuration. The Nextflow `process.resourceLabel` configuration is used independently to demonstrate how this functionality could be used in combination with AWS configs that you would supply yourself.

## AWS Preparation

Make sure you have enabled user defined cost allocation tags

- https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/activating-tags.html

Also make sure that you also have AWS Batch Split Cost Allocation enabled and in use

- https://aws.amazon.com/blogs/aws-cloud-financial-management/la-improve-cost-visibility-of-containerized-applications-with-aws-split-cost-allocation-data-for-ecs-and-batch-jobs/

You may also need to use AWS Glue to do queries for these tags if they do not show up in your AWS Cost Explorer by default (historically AWS Batch Job tags did not show up in Cost Explorer properly)

- https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/create-detailed-cost-and-usage-reports-for-aws-glue-jobs-by-using-aws-cost-explorer.html

## Usage

You can pass the `submitter` arg from the cli params, and you can also supply a JSON string for supplemental resource labels. This depends on `params.submitter` and `params.resourceLabels` being defined in the `nextflow.config` file, and it uses the dynamic nature of the Nextflow config file resolution in order to evaluate the full set of resource labels for each task at the time of task execution. This allows for the resource labels to include task-specific, and workflow-specific internal metadata in the labels, which can be used for AWS Cost Explorer tracking.

The inclusion of a free-text JSON string for use with `params.resourceLabels` to append extra labels to `process.resourceLabels` enables the ability for an external program, system, or user to dynamimcally generate and supply resource labels for each pipeline at runtime. By including this in the `nextflow.config` file, we enable the possibility of saving this as an external, supplemental configuration that can be supplied to a pre-existing Nextflow pipeline, without the need to modifying the source code of the original pipeline. For example, this `nextflow.config` could be included with the `nextflow -c ...` syntax to append the config included here to another pipeline, and could also be used with the `tw launch --config ...` to submit the config file to Seqera Platform (Nextflow Tower) for inclusion in the pipeline run.

The cli usage for this demo looks as such;

```bash
nextflow run main.nf --submitter my-name-goes-here --resourceLabels '{"cliArg1":"foo", "cliArg2": "bar"}'

N E X T F L O W  ~  version 23.10.1
Launching `main.nf` [kickass_keller] DSL2 - revision: a983bc0961
executor >  local (1)
[70/ff176c] process > BAR (BAR.Sample1.tag) [100%] 1 of 1 ✔
--------- BAR start -----------
>>> BAR: Sample1
task.resourceLabels: [fooLabel:barValue, pipelineSubmitter:my-name-goes-here, pipelineProcess:BAR, pipelineTag:BAR.Sample1.tag, pipelineCPUs:1, pipelineUser:myrealusername, pipelineMemory:null, pipelineTaskAttempt:1, pipelineContainer:null, pipelineRunName:kickass_keller, pipelineSessionId:99ac7ea3-e3d0-493b-af16-86666ae7765b, pipelineResume:false, pipelineRevision:null, pipelineCommitId:null, pipelineRepository:null, pipelineName:resourceLabels-demo, cliArg1:foo, cliArg2:bar]
--------- BAR end -----------
```


- similar to methods used in https://github.com/stevekm/nextflow-demos/tree/master/workflow-introspection