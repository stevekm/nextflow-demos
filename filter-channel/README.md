# Filter Channel

A demonstration of filtering Channels based on various criteria. This demo shows how to filter by:

- string matching

- number of lines in a file (with and without loading the entire file into memory)

- using complex criteria to evaluate the number of entries in a file (e.g. the number of vairants in a .vcf)

- file existence

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

Output should look like this:

```
$ make run
./nextflow run main.nf
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [backstabbing_gates] - revision: 1a80c82695
[samples] good
[samples] bad
>>> WARNING: file /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo3.tsv does not have enough lines and will not be included
[demo_tsvs] [demo1, /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo1.tsv]
[demo_tsvs] [demo2, /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo2.tsv]
>>> Read 3 lines from file /Users/kellys04/projects/nextflow-demos/filter-channel/input/bad1.vcf and found 0 variants
>>> WARNING: File /Users/kellys04/projects/nextflow-demos/filter-channel/input/bad1.vcf does not have enough variants and will not be included
>>> Read 3 lines from file /Users/kellys04/projects/nextflow-demos/filter-channel/input/good1.vcf and found 1 variants
>>> WARNING: File /Users/kellys04/projects/nextflow-demos/filter-channel/input/foo.vcf does not exist and will not be included
[demo_vcfs] [good1, /Users/kellys04/projects/nextflow-demos/filter-channel/input/good1.vcf]
>>> Read 3 lines from file /Users/kellys04/projects/nextflow-demos/filter-channel/input/good2.vcf and found 1 variants
[demo_exists] [bad1, /Users/kellys04/projects/nextflow-demos/filter-channel/input/bad1.vcf]
[demo_exists] [good1, /Users/kellys04/projects/nextflow-demos/filter-channel/input/good1.vcf]
[demo_vcfs] [good2, /Users/kellys04/projects/nextflow-demos/filter-channel/input/good2.vcf]
[demo_tsvs2] [demo1, /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo1.tsv]
[demo_tsvs2] [demo2, /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo2.tsv]
>>> WARNING: file /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo3.tsv does not have enough lines and will not be included
```
