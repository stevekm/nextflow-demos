# Topic Channels + collectFile

Demo of usage of Nextflow topic channels to gather up a list of the samples that passed each step of the pipeline, and make a simple table out of it that can be used later in a custom reporting step

- https://nextflow.io/docs/latest/reference/channel.html#topic

- https://www.nextflow.io/docs/latest/reference/operator.html#collectfile

```bash
 N E X T F L O W   ~  version 25.04.6

Launching `main.nf` [angry_bohr] DSL2 - revision: dee9984d25

executor >  local (13)
[f4/3d05e2] DO_THING (4)     [100%] 4 of 4, ignored: 1 ✔
[18/dc12be] DO_THING2 (4)    [100%] 4 of 4, ignored: 1 ✔
[35/40ed8c] DO_THING3 (2)    [100%] 4 of 4, ignored: 1 ✔
[10/5e541c] FAKE_MULTIQC (1) [100%] 1 of 1 ✔
put your multiqc with the table here
here is your table:
Sample1	[INPUT, DO_THING3, DO_THING2]
Sample3	[INPUT, DO_THING, DO_THING2]
Sample2	[INPUT, DO_THING, DO_THING3]
Sample4	[INPUT, DO_THING2, DO_THING, DO_THING3]

[39/7268ee] NOTE: Process `DO_THING (1)` terminated with an error exit status (1) -- Error is ignored
[fe/e4349a] NOTE: Process `DO_THING3 (3)` terminated with an error exit status (1) -- Error is ignored
[4e/9a0831] NOTE: Process `DO_THING2 (2)` terminated with an error exit status (1) -- Error is ignored
```