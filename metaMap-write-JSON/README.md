Demonstration to show multiple advanced Nextflow techniques;

- using a metaMap object to store and pass around sample metadata
- using a Nextflow `exec` process scope to do file IO in native Groovy code, inside a Nextflow process which will implicitly run in parallel as needed
- reading and writing JSON to/from file using native Groovy code

The included pipeline will accomplish these by using the following steps;

- creating a "meta map" Groovy map object from an input (a .csv format samplesheet)
- write the meta map to a JSON file from within a Nextflow process using native Groovy code execution
- read the contents of the JSON file back into the workflow via a Nextflow process using native Groovy
- additionally, write the JSON string to a file using the standard `script` Nextflow process scope

By using these techniques, our workflows will be able more efficiently pass around metadata objects and keep them associated with sample files, store and read these meta objects to disk (and any other type of object), perform basic file IO processing using Groovy native methods instead of an external script in a different language, and interact with JSON format files more effectively.

( Note that if you want to produce a JSON file from within a `script` block you may also consider using a tool such as [`jq`](https://stedolan.github.io/jq/) )

execution of the workflow should look like this;

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
>>> READ_JSON inputJsonPath: /Users/me/projects/nextflow-demos/metaMap-write-JSON/work/bf/4af999fd8b6b89e143b11274621c2e/meta.json
>>> READ_JSON contents: {
    "sampleID": "Sample1",
    "sampleType": "fooType"
}
>>> READ_JSON metaMap: [sampleID:Sample1, sampleType:fooType]
output channel meta: [sampleID:Sample1, sampleType:fooType]
```

Some important notes;

- when using the `exec` scope in a Nextflow process, a work dir will be created, however, input files will NOT be staged
- you can access the workdir inside the `exec` scope using the `task.workDir` object; this is a requirement if you wish to write a file since the Groovy code execution will not have implicit knowledge to write to the workdir in the same manner that `script` scopes do
- if you wish to read from an input file in the `exec` scope, you should pass the `input` file in as a `val`, not a `path`. An input of `val(myfile)` will resolve `myfile` to the full path to the source file, in the previous task's workdir. As such, make sure NOT to write to this filepath, only read from it.
- be careful with the usage of `def` when creating variables in the `exec` scope, it may break things, usually you will want to not use `def` or other object class labels under `exec` especially if you need to use the same variable as an `output` item ; this may sometimes make it slightly tricky to adapt Groovy code you find online to work properly inside the `exec` scope
- as of this writing, `exec` writing to `task.workDir` does not appear to work when running the pipeline with `-resume`
- as of this writing, `exec` writing to `task.workDir` does not appear to work when running with `-work-dir` inside an AWS S3 bucket, as is the case when using the AWS Batch executor
- as of this writing, `exec` can only run in the `local` executor
- due to the current limitations of the `exec` scope in Nextflow, you may consider using the `script` scope instead


## Resources

- "Workflow safety and immutable objects" https://www.youtube.com/watch?v=A357C-ux6Dw
