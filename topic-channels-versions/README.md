# Usage of Nextflow `topic` Channels to collect Process Versions

This demo shows how to collect all task process versions using the new (at the time of writing) Nextflow feature for "topic" channels. Also uses the new `eval` feature

- https://www.nextflow.io/docs/master/channel.html#topic

- https://www.nextflow.io/docs/master/process.html#output-type-eval

NOTE: This demo also uses Docker so make sure your system has that available to run

```bash
$ NXF_VER=24.03.0-edge nextflow run main.nf

 N E X T F L O W   ~  version 24.03.0-edge

Launching `main.nf` [reverent_saha] DSL2 - revision: 3ab6f47aa0

executor >  local (12)
[9e/50d758] process > FOO (Sample1)                         [100%] 3 of 3 ✔
[6f/656052] process > MULTIQC_SUBWORKFLOW:MULTIQC (Sample1) [100%] 3 of 3 ✔
[ae/0de2dc] process > MULTIQC_SUBWORKFLOW:BAZ (Sample1)     [100%] 3 of 3 ✔
[c3/250942] process > MULTIQC_SUBWORKFLOW:FASTQC (Sample3)  [100%] 3 of 3 ✔

BAZ:
    software: baz_program
    version: 4.3.1
    container: ubuntu:latest
    id: MULTIQC_SUBWORKFLOW:BAZ


FOO:
    software: foo_program
    version: v1.1
    container: ubuntu:latest
    id: FOO


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
```