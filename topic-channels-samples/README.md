# Topic Channels + collectFile

Demo of usage of Nextflow topic channels to gather up a list of the samples that passed each step of the pipeline, and make a simple table out of it that can be used later in a custom reporting step

- https://nextflow.io/docs/latest/reference/channel.html#topic

- https://www.nextflow.io/docs/latest/reference/operator.html#collectfile

```bash
$ nextflow run main.nf
 N E X T F L O W   ~  version 25.04.6

Launching `main.nf` [serene_becquerel] DSL2 - revision: b75a748b98

hello
executor >  local (9)
[fc/a1552a] DO_THING (4)     [100%] 4 of 4, ignored: 1 ✔
[7b/0a4d4a] DO_THING2 (4)    [100%] 4 of 4, ignored: 1 ✔
[d5/66c602] FAKE_MULTIQC (1) [100%] 1 of 1 ✔
got Sample2

got Sample3

got Sample3

got Sample1

got Sample4

got Sample4

['DO_THING2 - Sample3', 'DO_THING - Sample2', 'DO_THING2 - Sample1', 'DO_THING - Sample3', 'DO_THING2 - Sample4', 'DO_THING - Sample4']
put your multiqc with the table here
here is your table:
DO_THING2 - Sample3
DO_THING - Sample2
DO_THING - Sample4
DO_THING2 - Sample4
DO_THING2 - Sample1
DO_THING - Sample3

[be/8a2fae] NOTE: Process `DO_THING2 (2)` terminated with an error exit status (1) -- Error is ignored
[1f/86dd11] NOTE: Process `DO_THING (1)` terminated with an error exit status (1) -- Error is ignored

```