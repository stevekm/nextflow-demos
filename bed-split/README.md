# bed-split

A basic demonstration on how to use Nextflow to split a .bed file based on per-chromosome, per-line, and per-file number criteria, and then conditionally use the resulting files in a pipeline. 

This pipeline will first split a provided .bed file into new files per-chromosome, and into subset files based on a limit of number of lines per file, and also split based on a limit of number of desired files output. 

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

This will run the pipeline with the default config performing all splits, then using the per-chromosome split files in the final process. 

The pipeline can also be run like this to use the per-line split files;

```
./nextflow run main.nf --splitBy lines
```

and also like this to instead use the per-file limit split files;

```
./nextflow run main.nf --splitBy files
```

## Output

The terminal output should look like this:

```
$ make run
./nextflow run main.nf
N E X T F L O W  ~  version 19.01.0
Launching `main.nf` [ridiculous_joliot] - revision: 6e1c8b015b
bedFile:   targets.bed
outputDir: output
numLines:  75
numFiles:  9
[warm up] executor > local
[eb/8ced13] Submitted process > file_chunk (1)
[2b/7e3db3] Submitted process > chrom_chunk (1)
[a2/62a12b] Submitted process > line_chunk (1)
[file_chunk] targets.bed.1 -> 1
[file_chunk] targets.bed.2 -> 2
[file_chunk] targets.bed.3 -> 3
[file_chunk] targets.bed.4 -> 4
[file_chunk] targets.bed.5 -> 5
[file_chunk] targets.bed.6 -> 6
[file_chunk] targets.bed.7 -> 7
[file_chunk] targets.bed.8 -> 8
[file_chunk] targets.bed.9 -> 9
[chrom_chunk] targets.bed.chr1 -> chr1
[chrom_chunk] targets.bed.chr10 -> chr10
[chrom_chunk] targets.bed.chr11 -> chr11
[chrom_chunk] targets.bed.chr12 -> chr12
[chrom_chunk] targets.bed.chr13 -> chr13
[chrom_chunk] targets.bed.chr14 -> chr14
[chrom_chunk] targets.bed.chr15 -> chr15
[chrom_chunk] targets.bed.chr16 -> chr16
[chrom_chunk] targets.bed.chr17 -> chr17
[chrom_chunk] targets.bed.chr18 -> chr18
[chrom_chunk] targets.bed.chr19 -> chr19
[chrom_chunk] targets.bed.chr2 -> chr2
[chrom_chunk] targets.bed.chr20 -> chr20
[chrom_chunk] targets.bed.chr21 -> chr21
[chrom_chunk] targets.bed.chr22 -> chr22
[chrom_chunk] targets.bed.chr3 -> chr3
[chrom_chunk] targets.bed.chr4 -> chr4
[chrom_chunk] targets.bed.chr5 -> chr5
[chrom_chunk] targets.bed.chr6 -> chr6
[chrom_chunk] targets.bed.chr7 -> chr7
[chrom_chunk] targets.bed.chr8 -> chr8
[chrom_chunk] targets.bed.chr9 -> chr9
[chrom_chunk] targets.bed.chrX -> chrX
[f3/c57102] Submitted process > use_chrom_chunks (2)
[34/15c4d9] Submitted process > use_chrom_chunks (3)
[16/59f5bc] Submitted process > use_chrom_chunks (1)
[93/ebd2ab] Submitted process > use_chrom_chunks (5)
[line_chunk] targets.bed.1 -> 1
[line_chunk] targets.bed.2 -> 2
[line_chunk] targets.bed.3 -> 3
[line_chunk] targets.bed.4 -> 4
[line_chunk] targets.bed.5 -> 5
[line_chunk] targets.bed.6 -> 6
[b6/7323bc] Submitted process > use_chrom_chunks (7)
[07/12b6fe] Submitted process > use_chrom_chunks (8)
[39/a41ce1] Submitted process > use_chrom_chunks (12)
[00/d90495] Submitted process > use_chrom_chunks (11)
[57/8846d5] Submitted process > use_chrom_chunks (10)
[29/6e6dd5] Submitted process > use_chrom_chunks (4)
[8d/69f165] Submitted process > use_chrom_chunks (9)
[b7/0b1b52] Submitted process > use_chrom_chunks (6)
[e9/35aa85] Submitted process > use_chrom_chunks (13)
[f0/8cec9f] Submitted process > use_chrom_chunks (18)
[cb/d72d9a] Submitted process > use_chrom_chunks (15)
[c5/ed4169] Submitted process > use_chrom_chunks (19)
[27/6587fc] Submitted process > use_chrom_chunks (16)
[1a/4fc07d] Submitted process > use_chrom_chunks (17)
[78/e23ccb] Submitted process > use_chrom_chunks (14)
[cf/ffffef] Submitted process > use_chrom_chunks (20)
[06/558b8c] Submitted process > use_chrom_chunks (21)
[60/1e8cf4] Submitted process > use_chrom_chunks (22)
[d1/6bfb0e] Submitted process > use_chrom_chunks (23)
[e0/8a0efd] Submitted process > use_all_results
chrom.chr1
chrom.chr10
chrom.chr11
chrom.chr12
chrom.chr13
chrom.chr14
chrom.chr15
chrom.chr16
chrom.chr17
chrom.chr18
chrom.chr19
chrom.chr2
chrom.chr20
chrom.chr21
chrom.chr22
chrom.chr3
chrom.chr4
chrom.chr5
chrom.chr6
chrom.chr7
chrom.chr8
chrom.chr9
chrom.chrX
```
