SHELL:=/bin/bash
NXF_VER:=0.29.0

all: people plots

run: all

plots: install
	./nextflow run plots.nf

people: install
	./nextflow run people.nf

install: ./nextflow

./nextflow:
	export NXF_VER="$(NXF_VER)" && \
	curl -fsSL get.nextflow.io | bash

clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
	rm -rf output
