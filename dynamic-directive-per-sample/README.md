# Dynamic Directive Per Sample

## Usage

Run the first time, and all samples are run with either default dynamic memory values based on the number of fastq reads, or using an override value input from the `Samplesheet.csv`

```
$ nextflow run main.nf
N E X T F L O W  ~  version 23.04.1
Launching `main.nf` [modest_miescher] DSL2 - revision: ebfe0a6481
executor >  local (4)
[59/115920] process > DO_SOMETHING (Sample3) [100%] 4 of 4 ✔
>>> Running Sample2; meta: [id:Sample2, reads:9, memOverride:true, memOverrideVal:42]; memory: 42 MB

>>> Running Sample1; meta: [id:Sample1, reads:1, memOverride:true, memOverrideVal:42]; memory: 42 MB

>>> Running Sample4; meta: [id:Sample4, reads:72, memOverride:false, memOverrideVal:0]; memory: 72 MB

>>> Running Sample3; meta: [id:Sample3, reads:36, memOverride:false, memOverrideVal:0]; memory: 36 MB
```

Run it again with `-resume` and all tasks are skipped because they are still cached

```
$ nextflow run main.nf -resume
N E X T F L O W  ~  version 23.04.1
Launching `main.nf` [special_kilby] DSL2 - revision: ebfe0a6481
[03/828ca6] process > DO_SOMETHING (Sample1) [100%] 4 of 4, cached: 4 ✔
...
...
```

Manually modify one of the `memMB` values in the samplesheet and re-run with resume; in this case we changed the `memMB` value for Sample2 to "50". We can see that

```
$ nextflow run main.nf -resume
N E X T F L O W  ~  version 23.04.1
Launching `main.nf` [adoring_feynman] DSL2 - revision: ebfe0a6481
executor >  local (1)
[f6/eb4f0a] process > DO_SOMETHING (Sample2) [100%] 4 of 4, cached: 3 ✔

...

>>> Running Sample2; meta: [id:Sample2, reads:9, memOverride:true, memOverrideVal:50]; memory: 50 MB
```

Change Sample2 back to its original value of 42, and add an override value of 86 for Sample3 which did not previously have an override value;

```
$ nextflow run main.nf -resume
N E X T F L O W  ~  version 23.04.1
Launching `main.nf` [desperate_gutenberg] DSL2 - revision: ebfe0a6481
executor >  local (1)
[ed/714bc9] process > DO_SOMETHING (Sample3) [100%] 4 of 4, cached: 3 ✔
>>> Running Sample4; meta: [id:Sample4, reads:72, memOverride:false, memOverrideVal:0]; memory: 72 MB

>>> Running Sample1; meta: [id:Sample1, reads:1, memOverride:true, memOverrideVal:42]; memory: 42 MB

>>> Running Sample2; meta: [id:Sample2, reads:9, memOverride:true, memOverrideVal:42]; memory: 42 MB

>>> Running Sample3; meta: [id:Sample3, reads:36, memOverride:true, memOverrideVal:86]; memory: 86 MB
```

Notice how the original result for Sample2 is now used instead, since its still in the work dir cache, and Sample3 gets re-run this time.