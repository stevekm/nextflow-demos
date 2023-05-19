# metaMap

Demonstration of using a Groovy `map` object to hold a collection of metadata which will be passed along through the Nextflow workflow's Channels and used inside of Processes.

Often, the metaMap object will be built from fields in another workflow input such as a .csv format sample sheet. 

Since the metaMap is a Groovy `map`, it can be manipulated and parsed using standard Groovy map methods. 

This demo will read in the contents of the included `samplesheet.csv`, create a metaMap object, then pass the map to a Nextflow process where the map fields can be accessed for use inside of `script` or `exec` scopes for usage during the handling of the associated file inputs.

**IMPORTANT NOTE**: Once the map object has been passed out of its originating Channel or Process, it should not be modified in-place. If you need to modify a map object during your workflow, you should always create a new map object instead.

```
$ nextflow run main.nf
N E X T F L O W  ~  version 22.10.6
Launching `main.nf` [distracted_noether] DSL2 - revision: 1956cacbd4
executor >  local (2)
[bd/f0fec3] process > PRINT_META (1) [100%] 2 of 2 ✔
>>> PRINT_META sample: Sample2, type: melanoma

>>> PRINT_META sample: Sample1, type: melanoma
```
