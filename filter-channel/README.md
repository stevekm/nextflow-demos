# Filter Channel

A demonstration of filtering Channels based on various criteria. This demo shows how to:

- filter a channel by string matching

- filter a channel by the number of lines in a file (with and without loading the entire file into memory)

- filter a channel by using complex criteria to evaluate the number of entries in a file (e.g. the number of vairants in a .vcf)

- filter a channel by file existence

- choose between channels to send a file to

- collect messages based on items that passed through chosen channel

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
Launching `main.nf` [desperate_stonebraker] - revision: 3114797a14
[samples] good
[samples] bad
[demo_tsvs] [demo1, /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo1.tsv]
[demo_tsvs] [demo2, /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo2.tsv]
>>> WARNING: file /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo3.tsv does not have enough lines and will not be included
>>> Read 3 lines from file /Users/kellys04/projects/nextflow-demos/filter-channel/input/bad1.vcf and found 0 variants
>>> WARNING: File /Users/kellys04/projects/nextflow-demos/filter-channel/input/bad1.vcf does not have enough variants and will not be included
>>> Read 3 lines from file /Users/kellys04/projects/nextflow-demos/filter-channel/input/good1.vcf and found 1 variants
[demo_vcfs] [good1, /Users/kellys04/projects/nextflow-demos/filter-channel/input/good1.vcf]
>>> Read 3 lines from file /Users/kellys04/projects/nextflow-demos/filter-channel/input/good2.vcf and found 1 variants
[demo_vcfs] [good2, /Users/kellys04/projects/nextflow-demos/filter-channel/input/good2.vcf]
>>> WARNING: File /Users/kellys04/projects/nextflow-demos/filter-channel/input/foo.vcf does not exist and will not be included
[demo_exists] [bad1, /Users/kellys04/projects/nextflow-demos/filter-channel/input/bad1.vcf]
[demo_exists] [good1, /Users/kellys04/projects/nextflow-demos/filter-channel/input/good1.vcf]
/Users/kellys04/projects/nextflow-demos/filter-channel/input/bad1.vcf
/Users/kellys04/projects/nextflow-demos/filter-channel/input/demo1.tsv
/Users/kellys04/projects/nextflow-demos/filter-channel/input/demo2.tsv
[good_inputs] /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo1.tsv
/Users/kellys04/projects/nextflow-demos/filter-channel/input/demo3.tsv
/Users/kellys04/projects/nextflow-demos/filter-channel/input/good1.vcf
[good_inputs] /Users/kellys04/projects/nextflow-demos/filter-channel/input/good1.vcf
/Users/kellys04/projects/nextflow-demos/filter-channel/input/good2.vcf
[good_inputs] /Users/kellys04/projects/nextflow-demos/filter-channel/input/good2.vcf
[demo_tsvs2] [demo1, /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo1.tsv]
[demo_tsvs2] [demo2, /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo2.tsv]
>>> WARNING: file /Users/kellys04/projects/nextflow-demos/filter-channel/input/demo3.tsv does not have enough lines and will not be included
```
