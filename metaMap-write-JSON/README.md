Demonstration for

- creating a "meta map" Groovy map object from an input (a .csv format samplesheet)
- write the meta map to a JSON file from within a Nextflow process using native Groovy code execution
- read the contents of the JSON file back into the workflow via a Channel

```
$ nextflow run main.nf
N E X T F L O W  ~  version 22.10.6
Launching `main.nf` [nauseous_pare] DSL2 - revision: 663a518587
executor >  local (1)
[b4/f91518] process > WRITE_JSON (1) [100%] 1 of 1 ✔
>>> WRITE_JSON meta: [sampleID:Sample1, sampleType:fooType]
>>> WRITE_JSON json_str: {"sampleID":"Sample1","sampleType":"fooType"}
>>> WRITE_JSON json_indented: {
    "sampleID": "Sample1",
    "sampleType": "fooType"
}
read data back in from JSON file: [sampleID:Sample1, sampleType:fooType]

```