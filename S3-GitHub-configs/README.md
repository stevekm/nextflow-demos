# Remote S3 and git repository hosted config files

You can use the `includeConfig` directive to add Nextflow configuration files from an S3 bucket or a git repository such as GitHub

(without S3 config, with remote Github config)

```bash
$ nextflow run main.nf
nextflow run main.nf
N E X T F L O W  ~  version 23.04.1
Launching `main.nf` [jolly_heisenberg] DSL2 - revision: 7328e41365
hello world
params.local_val = foo1
params.remote_val = bar1
params.remote_s3_val = null
```