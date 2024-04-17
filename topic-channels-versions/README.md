# Usage of Nextflow `topic` Channels to collect Process Versions

This demo shows how to collect all task process versions using the new (at the time of writing) Nextflow feature for "topic" channels. Also uses the new `eval` feature

- https://www.nextflow.io/docs/master/channel.html#topic

- https://www.nextflow.io/docs/master/process.html#output-type-eval

NOTE: This demo also uses Docker so make sure your system has that available to run

```bash
$ NXF_VER=24.03.0-edge nextflow run main.nf

 N E X T F L O W   ~  version 24.03.0-edge

Launching `main.nf` [sharp_ekeblad] DSL2 - revision: 9f9d7869a0

executor >  local (12)
[f6/3f511d] process > FOO (Sample1)                         [100%] 3 of 3 ✔
[4b/47f32f] process > MULTIQC_SUBWORKFLOW:MULTIQC (Sample1) [100%] 3 of 3 ✔
executor >  local (12)
[f6/3f511d] process > FOO (Sample1)                         [100%] 3 of 3 ✔
[4b/47f32f] process > MULTIQC_SUBWORKFLOW:MULTIQC (Sample1) [100%] 3 of 3 ✔
[f6/cd0afc] process > MULTIQC_SUBWORKFLOW:BAZ (Sample3)     [100%] 3 of 3 ✔
[eb/b61806] process > MULTIQC_SUBWORKFLOW:FASTQC (Sample2)  [100%] 3 of 3 ✔


# this is legacy YAML style output
FOO:
    software: foo_program
    version: v1.1
    container: ubuntu:latest
    id: FOO


BAZ:
    software: baz1_program
    version: 4.3.1
    container: ubuntu:latest
    id: MULTIQC_SUBWORKFLOW:BAZ


BAZ:
    software: baz2_program
    version: 5.6
    container: ubuntu:latest
    id: MULTIQC_SUBWORKFLOW:BAZ


FASTQC:
    software: fastqc
    version: 0.11.9
    container: quay.io/biocontainers/fastqc:0.11.9--0
    id: MULTIQC_SUBWORKFLOW:FASTQC


MULTIQC:
    software: multiqc
    version: 1.14
    container: quay.io/biocontainers/multiqc:1.14--pyhdfd78af_0
    id: MULTIQC_SUBWORKFLOW:MULTIQC

# this is a better way to output that can be parsed downstream easier
[['process':'FOO', 'container':'ubuntu:latest', 'software':'foo_program', 'version':'v1.1'], ['process':'MULTIQC_SUBWORKFLOW:BAZ', 'container':'ubuntu:latest', 'software':'baz1_program', 'version':'4.3.1'], ['process':'MULTIQC_SUBWORKFLOW:BAZ', 'container':'ubuntu:latest', 'software':'baz2_program', 'version':'5.6'], ['process':'MULTIQC_SUBWORKFLOW:FASTQC', 'container':'quay.io/biocontainers/fastqc:0.11.9--0', 'software':'fastqc', 'version':'0.11.9'], ['process':'MULTIQC_SUBWORKFLOW:MULTIQC', 'container':'quay.io/biocontainers/multiqc:1.14--pyhdfd78af_0', 'software':'multiqc', 'version':'1.14']]

```