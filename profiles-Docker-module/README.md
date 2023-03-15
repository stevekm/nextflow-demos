# Profiles with Docker and modules

This demonstration shows how the same pipeline script (`main.nf`) can be run on different systems using the 'profile' feature to modulate system configurations.

The file `nextflow.config` contains the following 'profiles', wich can be specified for execution from the command line:

```
profiles {
    docker {
        docker.enabled = true
        process.$fastqc.container = "stevekm/ngs580-nf:fastqc-0.11.7"
    }
    phoenix {
        process.$fastqc.module = "fastqc/0.11.7"
        process.executor = "sge"
    }
}
```

- `docker`: A profile that enables the usage of Docker and supplies a Docker container to use when executing the `fastqc` script

- `phoenix`: A profile that enables pipeline task submission to the SGE job scheduler (used on NYU's phoenix HPC cluster), along with the usage of the `fastqc/0.11.7` module for the `fastqc` process

## Usage

Running the pipeline with the Docker profile on the local host system:

```
$ make run-docker
export NXF_VER="0.28.0" && \
	curl -fsSL get.nextflow.io | bash

      N E X T F L O W
      version 0.28.0 build 4779
      last modified 10-03-2018 12:13 UTC (07:13 EDT)
      cite doi:10.1038/nbt.3820
      http://nextflow.io


Nextflow installation completed. Please note:
- the executable file `nextflow` has been created in the folder: /Users/kellys04/projects/nextflow-demos/profiles-Docker-module
- you may complete the installation by moving it to a directory in your $PATH

docker --version > /dev/null 2>&1 || { echo "ERROR: 'docker' not found" && exit 1 ; }
./nextflow run main.nf -with-dag flowchart.dot -profile docker
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [trusting_nobel] - revision: 1ba488c33d
[warm up] executor > local
[98/605ea9] Submitted process > fastqc (SeraCare-1to1-Positive_S2_L001_R1_001.fastq.gz)
[fb/be2de5] Submitted process > fastqc (HapMap-B17-1267_S8_L001_R2_001.fastq.gz)
[eb/8f8a5f] Submitted process > fastqc (SeraCare-1to1-Positive_S2_L001_R2_001.fastq.gz)
[eb/4dd680] Submitted process > fastqc (HapMap-B17-1267_S8_L001_R1_001.fastq.gz)
/opt/FastQC/fastqc
Analysis complete for SeraCare-1to1-Positive_S2_L001_R2_001.fastq.gz
/opt/FastQC/fastqc
Analysis complete for SeraCare-1to1-Positive_S2_L001_R1_001.fastq.gz
/opt/FastQC/fastqc
Analysis complete for HapMap-B17-1267_S8_L001_R2_001.fastq.gz
/opt/FastQC/fastqc
Analysis complete for HapMap-B17-1267_S8_L001_R1_001.fastq.gz
```
Notes:

- `-profile docker` option passed to `nextflow run` to specify which profile to use

- `/opt/FastQC/fastqc` is the location of FastQC inside the Docker container

- using the 'local' executor

Running with the `phoenix` profile:

```
$ make run-phoenix
export NXF_VER="0.28.0" && \
	curl -fsSL get.nextflow.io | bash

      N E X T F L O W
      version 0.28.0 build 4779
      last modified 10-03-2018 12:13 UTC (07:13 EDT)
      cite doi:10.1038/nbt.3820
      http://nextflow.io


Nextflow installation completed. Please note:
- the executable file `nextflow` has been created in the folder: /ifs/home/kellys04/projects/nextflow-demos/profiles-Docker-module
- you may complete the installation by moving it to a directory in your $PATH

module > /dev/null 2>&1 || { echo "ERROR: 'module' not found" && exit 1 ; }
./nextflow run main.nf -with-dag flowchart.dot -profile phoenix
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [big_minsky] - revision: 1ba488c33d
[warm up] executor > sge
[5b/184150] Submitted process > fastqc (HapMap-B17-1267_S8_L001_R1_001.fastq.gz)
[19/20550b] Submitted process > fastqc (SeraCare-1to1-Positive_S2_L001_R1_001.fastq.gz)
[bc/1c9678] Submitted process > fastqc (HapMap-B17-1267_S8_L001_R2_001.fastq.gz)
/local/apps/fastqc/0.11.7/fastqc
Analysis complete for HapMap-B17-1267_S8_L001_R2_001.fastq.gz
[25/f0f9e6] Submitted process > fastqc (SeraCare-1to1-Positive_S2_L001_R2_001.fastq.gz)
/local/apps/fastqc/0.11.7/fastqc
Analysis complete for SeraCare-1to1-Positive_S2_L001_R1_001.fastq.gz
/local/apps/fastqc/0.11.7/fastqc
Analysis complete for SeraCare-1to1-Positive_S2_L001_R2_001.fastq.gz
/local/apps/fastqc/0.11.7/fastqc
Analysis complete for HapMap-B17-1267_S8_L001_R1_001.fastq.gz
```

Notes:

- using `sge` executor

- `/local/apps/fastqc/0.11.7/fastqc` is the location for FastQC inside the `fastqc/0.11.7` module
