# Cross Samples

A demonstration of joining channels of different files for different samples together

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

Output should look like this:

```
$ ./nextflow run main.nf
N E X T F L O W  ~  version 0.32.0
Launching `main.nf` [soggy_goodall] - revision: f735eb10ce
[Sample3, HaplotypeCaller, /samples/Sample3/Sample3.HaplotypeCaller.vcf, /samples/Sample3/Sample3.bam, /samples/Sample3/Sample3.bam.bai]
[Sample2, HaplotypeCaller, /samples/Sample2/Sample2.HaplotypeCaller.vcf, /samples/Sample2/Sample2.bam, /samples/Sample2/Sample2.bam.bai]
[Sample1, HaplotypeCaller, /samples/Sample1/Sample1.HaplotypeCaller.vcf, /samples/Sample1/Sample1.bam, /samples/Sample1/Sample1.bam.bai]
[Sample3, LoFreq, /samples/Sample3/Sample3.LoFreq.vcf, /samples/Sample3/Sample3.bam, /samples/Sample3/Sample3.bam.bai]
[Sample2, LoFreq, /samples/Sample2/Sample2.LoFreq.vcf, /samples/Sample2/Sample2.bam, /samples/Sample2/Sample2.bam.bai]
[Sample1, LoFreq, /samples/Sample1/Sample1.LoFreq.vcf, /samples/Sample1/Sample1.bam, /samples/Sample1/Sample1.bam.bai]
```
