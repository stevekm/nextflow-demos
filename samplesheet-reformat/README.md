# Reformat samplesheet

Simple demo of how to reformat the input samplesheet in a Nextflow pipeline and save a new version of the samplesheet inline in Nextflow

```
$ cat samplesheet.csv
sample,fastq_1,fastq_2,strandedness,condition
Sample1,input/file1-1.txt,input/file1-2.txt,auto,control
Sample2,input/file2-1.txt,input/file2-2.txt,auto,control
Sample3,input/file3-1.txt,input/file3-2.txt,auto,control

$ nextflow run main.nf

 N E X T F L O W   ~  version 25.04.7

Launching `main.nf` [focused_saha] DSL2 - revision: 36e7aa7c68

[sample:Sample1, fastq_1:input/file1-1.txt, fastq_2:input/file1-2.txt, strandedness:auto, condition:control]
[sample:Sample2, fastq_1:input/file2-1.txt, fastq_2:input/file2-2.txt, strandedness:auto, condition:control]
[sample:Sample3, fastq_1:input/file3-1.txt, fastq_2:input/file3-2.txt, strandedness:auto, condition:control]


$ cat output/new_samplesheet.csv
sample,condition
Sample2,control
Sample1,control
Sample3,control
```