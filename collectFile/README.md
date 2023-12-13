# `collectFile`

This demonstration shows how to use the `collectFile` to concatenate output from multiple processes and then pass it to another process for processing.

This demo will use various methods to collect data from Nextflow Channels and concatenate data based on samples with various output directory schemes.

- https://nextflow.io/docs/latest/operator.html#collectfile

Run the script

```
$ nextflow run main.nf
N E X T F L O W  ~  version 23.04.1
Launching `main.nf` [high_stallman] DSL2 - revision: 26ecf4d000
executor >  local (4)
[02/8c2ee5] process > GET_VALUE (4) [100%] 4 of 4 ✔
```

Check the output

```
$ tree output
output
├── GET_VALUE
│   ├── Sample1.value.tsv
│   ├── Sample1.value.txt
│   ├── Sample2.value.tsv
│   ├── Sample2.value.txt
│   ├── Sample3.value.tsv
│   ├── Sample3.value.txt
│   ├── Sample4.value.tsv
│   └── Sample4.value.txt
├── GET_VALUE_collectFile
│   └── allSamples.allValues.tsv
├── meta_ch
│   └── allSamples.json
├── samples
│   ├── Sample1.json
│   ├── Sample2.json
│   ├── Sample3.json
│   └── Sample4.json
├── samples_ch
│   └── samples.collectFile.txt
└── subdirs
    ├── S1
    │   └── S1.txt
    └── S2
        └── S2.txt
```