Demonstration for

- creating a "meta map" Groovy map object from an input (a .csv format samplesheet)
- write the meta map to a JSON file from within a Nextflow process using native Groovy code execution
- read the contents of the JSON file back into the workflow via a Nextflow process using native Groovy

```
$ nextflow run main.nf
N E X T F L O W  ~  version 22.10.6
Launching `main.nf` [clever_fermi] DSL2 - revision: 541ad427c2
executor >  local (2)
[bf/4af999] process > WRITE_JSON (1) [100%] 1 of 1 ✔
[d3/04e71a] process > READ_JSON (1)  [100%] 1 of 1 ✔
>>> WRITE_JSON meta: [sampleID:Sample1, sampleType:fooType]
>>> WRITE_JSON json_str: {"sampleID":"Sample1","sampleType":"fooType"}
>>> WRITE_JSON json_indented: {
    "sampleID": "Sample1",
    "sampleType": "fooType"
}
>>> READ_JSON inputJsonPath: /Users/skelly/projects/nextflow-demos/metaMap-write-JSON/work/bf/4af999fd8b6b89e143b11274621c2e/meta.json
>>> READ_JSON contents: {
    "sampleID": "Sample1",
    "sampleType": "fooType"
}
>>> READ_JSON metaMap: [sampleID:Sample1, sampleType:fooType]
output channel meta: [sampleID:Sample1, sampleType:fooType]
```