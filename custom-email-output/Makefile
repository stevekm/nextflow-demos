SHELL:=/bin/bash
NXF_VER:=0.29.0

run: install
	./nextflow run main.nf && \
	./nextflow run email.nf

install: ./nextflow

./nextflow:
	export NXF_VER="$(NXF_VER)" && \
	curl -fsSL get.nextflow.io | bash

clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
	rm -rf output
