# Topic Channels + collectFile

Demo of usage of Nextflow topic channels to gather up a list of the samples that passed each step of the pipeline, and make a simple table out of it that can be used in MultiQC to create a custom samples table that lists all the Nextflow tasks that each sample made it through.

- https://nextflow.io/docs/latest/reference/channel.html#topic

- https://www.nextflow.io/docs/latest/reference/operator.html#collectfile

```bash
 $ nextflow run main.nf

 N E X T F L O W   ~  version 25.04.7

Launching `main.nf` [compassionate_venter] DSL2 - revision: eba002a39b

executor >  local (13)
[d4/b7f04c] DO_THING (4)  [100%] 4 of 4, ignored: 1 ✔
[0b/9fe80a] DO_THING2 (1) [100%] 4 of 4, ignored: 1 ✔
[8d/63f056] DO_THING3 (1) [100%] 4 of 4, ignored: 1 ✔
[6d/15f082] MULTIQC (1)   [100%] 1 of 1 ✔
[c2/523065] NOTE: Process `DO_THING2 (2)` terminated with an error exit status (1) -- Error is ignored
[9f/cafa0d] NOTE: Process `DO_THING (1)` terminated with an error exit status (1) -- Error is ignored
[d2/5019c7] NOTE: Process `DO_THING3 (3)` terminated with an error exit status (1) -- Error is ignored
```

The final table will look like this in MultiQC

<img width="700" height="298" alt="Image" src="https://github.com/user-attachments/assets/31cd5ef4-2a12-4dcf-bfbe-bc480356d98a" />
