#!/bin/bash
set -euxo pipefail

# Example script for running a program inside of a singularity container without Nextflow

# $ singularity --version
# singularity-ce version 3.10.4

# $ singularity pull 'docker://quay.io/nextflow/rnaseq-nf:v1.0'
SIF="rnaseq-nf_v1.0.sif"


# how to verify that process is running inside container;
# uname -a
# bash -c "cat /etc/*release"


# check if pwd is mounted inside container
# singularity exec "${SIF}" bash -c "whoami; pwd; ls -l; ls -l /nfs/"


# NOTE: paths outside of the current working directory try might not be mounted inside the container by default!
# FASTA=/nfs/home/reference/hg19/sequence/genome.fa
# singularity exec \
# --bind $(dirname ${FASTA}):$(dirname ${FASTA}) \
# "${SIF}" ls -l "${FASTA}"


# NOTE: Singularity might mount user home dir by default;
# https://stackoverflow.com/questions/67377646/error-when-running-singularity-container-for-r-script
# for R consider including; unset R_LIBS; unset R_LIBS_USER
# or
# `singularity exec` args  `--contain` or  `--containall` or `--cleanenv`


# run command inside the container
singularity exec "${SIF}" salmon index -t transcriptome.fa -i index