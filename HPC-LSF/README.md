# LSF Example

Example of using a Nextflow script to run jobs on the HPC with LSF

# Usage

The included Makefile has recipes to demonstrate usages.

Install nextflow with a command like

```
curl -fsSL get.nextflow.io | bash
```

(the included `make install` recipe has been added for convenience)

The example workflow can be run locally with a command like

```
./nextflow run main.nf -profile standard
```

An LSF example profile has been provided and will submit the jobs to LSF instead

```
./nextflow run main.nf -profile lsf
``` 
