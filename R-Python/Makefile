SHELL:=/bin/bash
NXF_VER:=0.28.0

install: ./nextflow

./nextflow:
	export NXF_VER="$(NXF_VER)" && \
	curl -fsSL get.nextflow.io | bash

clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
	rm -rf output

run: install
	./nextflow run main.nf
