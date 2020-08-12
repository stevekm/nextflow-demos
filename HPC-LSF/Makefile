SHELL:=/bin/bash
.ONESHELL:
export NXF_VER:=20.07.1


# NOTE: on the HPC, need to load the Java module
./nextflow:
	if module avail java/jdk1.8.0_202 1&>/dev/null; then module load java/jdk1.8.0_202; fi
	curl -fsSL get.nextflow.io | bash

install: ./nextflow

run-local: install
	if module avail java/jdk1.8.0_202 1&>/dev/null; then module load java/jdk1.8.0_202; fi
	./nextflow run main.nf -profile standard

run-lsf:
	if module avail java/jdk1.8.0_202 1&>/dev/null; then module load java/jdk1.8.0_202; fi
	./nextflow run main.nf -profile lsf

clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
	[ -d output ] && mv output outputold && rm -rf outputold

clean-all: clean
	rm -f nextflow
	rm -rf .nextflow
