# Parse Samplesheet

This demo shows how to parse a samplesheet as input for a Nextflow pipeline.

This demo uses a samplesheet designed for a tumor / normal analysis starting with paired-end fastq files, but can be easily adapted for other purposes using the techniques shown.

## Samplesheet format

The samplesheet format used is in the following format:

```
$ cat samples.analysis.tsv
Sample	Tumor	Normal	R1	R2
HapMap-B17-1267	HapMap-B17-1267	NA	input/fastq/HapMap-B17-1267_S8_L001_R1_001.fastq.gz,input/fastq/HapMap-B17-1267_S8_L002_R1_001.fastq.gz,input/fastq/HapMap-B17-1267_S8_L003_R1_001.fastq.gz,input/fastq/HapMap-B17-1267_S8_L004_R1_001.fastq.gz	input/fastq/HapMap-B17-1267_S8_L001_R2_001.fastq.gz,input/fastq/HapMap-B17-1267_S8_L002_R2_001.fastq.gz,input/fastq/HapMap-B17-1267_S8_L003_R2_001.fastq.gz,input/fastq/HapMap-B17-1267_S8_L004_R2_001.fastq.gz
SeraCare-1to1-Positive	SeraCare-1to1-Positive	NA	input/fastq/SeraCare-1to1-Positive_S2_L001_R1_001.fastq.gz,input/fastq/SeraCare-1to1-Positive_S2_L002_R1_001.fastq.gz,input/fastq/SeraCare-1to1-Positive_S2_L003_R1_001.fastq.gz,input/fastq/SeraCare-1to1-Positive_S2_L004_R1_001.fastq.gz	input/fastq/SeraCare-1to1-Positive_S2_L001_R2_001.fastq.gz,input/fastq/SeraCare-1to1-Positive_S2_L002_R2_001.fastq.gz,input/fastq/SeraCare-1to1-Positive_S2_L003_R2_001.fastq.gz,input/fastq/SeraCare-1to1-Positive_S2_L004_R2_001.fastq.gz
```

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

Check the `main.nf` pipeline file to see how each of the pipeline outputs corresponds to different mapping and grouping techniques used in the pipeline. This demo pipeline outputs:

- The sample ID with the set of all R1 and R2 fastq input files (`samples_R1_R2`)

- each input fastq file individually (`samples_each_fastq`)

- example Nextflow processes that accept these as task inputs


Output will look like this:

```
$ make run
./nextflow run main.nf
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [reverent_fermat] - revision: f3ce45a948
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L001_R1_001.fastq.gz

[samples_R1_R2] [HapMap-B17-1267, [/Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L001_R1_001.fastq.gz, /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L002_R1_001.fastq.gz, /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L003_R1_001.fastq.gz, /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L004_R1_001.fastq.gz], [/Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L001_R2_001.fastq.gz, /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L002_R2_001.fastq.gz, /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L003_R2_001.fastq.gz, /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L004_R2_001.fastq.gz]]

[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L002_R1_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L003_R1_001.fastq.gz

[samples_R1_R2] [SeraCare-1to1-Positive, [/Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L001_R1_001.fastq.gz, /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L002_R1_001.fastq.gz, /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L003_R1_001.fastq.gz, /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L004_R1_001.fastq.gz], [/Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L001_R2_001.fastq.gz, /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L002_R2_001.fastq.gz, /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L003_R2_001.fastq.gz, /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L004_R2_001.fastq.gz]]

[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L004_R1_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L001_R2_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L002_R2_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L003_R2_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/HapMap-B17-1267_S8_L004_R2_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L001_R1_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L002_R1_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L003_R1_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L004_R1_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L001_R2_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L002_R2_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L003_R2_001.fastq.gz
[samples_each_fastq] /Users/kellys04/projects/nextflow-demos/parse-samplesheet/input/fastq/SeraCare-1to1-Positive_S2_L004_R2_001.fastq.gz
[warm up] executor > local
[08/b39837] Submitted process > each_fastq (HapMap-B17-1267_S8_L003_R1_001.fastq.gz)
[9a/7b7123] Submitted process > fastq_pairs (HapMap-B17-1267)
[4d/886323] Submitted process > each_fastq (HapMap-B17-1267_S8_L001_R2_001.fastq.gz)
[ca/b72fd1] Submitted process > each_fastq (HapMap-B17-1267_S8_L004_R1_001.fastq.gz)
[f4/3cbd3f] Submitted process > each_fastq (HapMap-B17-1267_S8_L004_R2_001.fastq.gz)
[18/e92bde] Submitted process > each_fastq (HapMap-B17-1267_S8_L001_R1_001.fastq.gz)
[b6/530d3e] Submitted process > each_fastq (HapMap-B17-1267_S8_L003_R2_001.fastq.gz)
[b4/0e3851] Submitted process > fastq_pairs (SeraCare-1to1-Positive)
[e9/727f8a] Submitted process > each_fastq (HapMap-B17-1267_S8_L002_R1_001.fastq.gz)
[each_fastq] got file: HapMap-B17-1267_S8_L003_R1_001.fastq.gz
[9b/c88c98] Submitted process > each_fastq (HapMap-B17-1267_S8_L002_R2_001.fastq.gz)
[each_fastq] got file: HapMap-B17-1267_S8_L001_R2_001.fastq.gz
[each_fastq] got file: HapMap-B17-1267_S8_L004_R1_001.fastq.gz
[0a/1cfb48] Submitted process > each_fastq (SeraCare-1to1-Positive_S2_L002_R1_001.fastq.gz)
[each_fastq] got file: HapMap-B17-1267_S8_L004_R2_001.fastq.gz
[b7/9f19c7] Submitted process > each_fastq (SeraCare-1to1-Positive_S2_L001_R1_001.fastq.gz)
[a4/4427c6] Submitted process > each_fastq (SeraCare-1to1-Positive_S2_L003_R1_001.fastq.gz)
[each_fastq] got file: HapMap-B17-1267_S8_L001_R1_001.fastq.gz
[8f/aa5ff4] Submitted process > each_fastq (SeraCare-1to1-Positive_S2_L004_R1_001.fastq.gz)
[each_fastq] got file: HapMap-B17-1267_S8_L003_R2_001.fastq.gz
[fastq_pairs] sample HapMap-B17-1267
R1: HapMap-B17-1267_S8_L001_R1_001.fastq.gz HapMap-B17-1267_S8_L002_R1_001.fastq.gz HapMap-B17-1267_S8_L003_R1_001.fastq.gz HapMap-B17-1267_S8_L004_R1_001.fastq.gz
R2: HapMap-B17-1267_S8_L001_R2_001.fastq.gz HapMap-B17-1267_S8_L002_R2_001.fastq.gz HapMap-B17-1267_S8_L003_R2_001.fastq.gz HapMap-B17-1267_S8_L004_R2_001.fastq.gz
[9b/f49bad] Submitted process > each_fastq (SeraCare-1to1-Positive_S2_L001_R2_001.fastq.gz)
[each_fastq] got file: SeraCare-1to1-Positive_S2_L003_R1_001.fastq.gz
[e4/c975fb] Submitted process > each_fastq (SeraCare-1to1-Positive_S2_L002_R2_001.fastq.gz)
[each_fastq] got file: SeraCare-1to1-Positive_S2_L004_R1_001.fastq.gz
[71/ab0b1b] Submitted process > each_fastq (SeraCare-1to1-Positive_S2_L004_R2_001.fastq.gz)
[each_fastq] got file: SeraCare-1to1-Positive_S2_L001_R2_001.fastq.gz
[33/147d35] Submitted process > each_fastq (SeraCare-1to1-Positive_S2_L003_R2_001.fastq.gz)
[each_fastq] got file: HapMap-B17-1267_S8_L002_R1_001.fastq.gz
[each_fastq] got file: HapMap-B17-1267_S8_L002_R2_001.fastq.gz
[each_fastq] got file: SeraCare-1to1-Positive_S2_L001_R1_001.fastq.gz
[each_fastq] got file: SeraCare-1to1-Positive_S2_L002_R1_001.fastq.gz
[each_fastq] got file: SeraCare-1to1-Positive_S2_L002_R2_001.fastq.gz
[each_fastq] got file: SeraCare-1to1-Positive_S2_L003_R2_001.fastq.gz
[fastq_pairs] sample SeraCare-1to1-Positive
R1: SeraCare-1to1-Positive_S2_L001_R1_001.fastq.gz SeraCare-1to1-Positive_S2_L002_R1_001.fastq.gz SeraCare-1to1-Positive_S2_L003_R1_001.fastq.gz SeraCare-1to1-Positive_S2_L004_R1_001.fastq.gz
R2: SeraCare-1to1-Positive_S2_L001_R2_001.fastq.gz SeraCare-1to1-Positive_S2_L002_R2_001.fastq.gz SeraCare-1to1-Positive_S2_L003_R2_001.fastq.gz SeraCare-1to1-Positive_S2_L004_R2_001.fastq.gz
[each_fastq] got file: SeraCare-1to1-Positive_S2_L004_R2_001.fastq.gz
```
