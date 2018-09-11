# Parse JSON

A demonstration of using Singularity containers in a Nextflow pipeline

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

To run on NYU's Big Purple HPC cluster, adjust the `EP` argument, or run `module load singularity/2.5.2` first:

```
make run EP='-profile singularity,bigpurple,slurm'
```
