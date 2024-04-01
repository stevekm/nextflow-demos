# Usage of Nextflow `topic` Channels to collect Process Versions

This demo shows how to collect all task process versions using the new (at the time of writing) Nextflow feature for "topic" channels. Also uses the new `eval` feature

- https://www.nextflow.io/docs/master/channel.html#topic

- https://www.nextflow.io/docs/master/process.html#output-type-eval

NOTE: This demo also uses Docker so make sure your system has that available to run

```bash
$ NXF_VER=24.02.0-edge nextflow run main.nf

 N E X T F L O W   ~  version 24.02.0-edge

 ┃ Launching `main.nf` [wise_kalam] DSL2 - revision: d1f0a7b175

executor >  local (9)
[a0/3ea8c0] process > FOO (Sample3)                 [100%] 3 of 3 ✔
[bd/8929c3] process > _SUBWORKFLOW:BARBAR (Sample3) [100%] 3 of 3 ✔
[c9/ef0698] process > BAR_SUBWORKFLOW:BAZ (Sample3) [100%] 3 of 3 ✔

FOO:
    version: v1.1
    container: ubuntu:latest


BAZ:
    version: 4.3.1
    container: ubuntu:latest


BAR:
    version: 1.14
    container: quay.io/biocontainers/multiqc:1.14--pyhdfd78af_0

```

- NOTE: see issue here about `eval` pipe handling https://github.com/nextflow-io/nextflow/issues/4870