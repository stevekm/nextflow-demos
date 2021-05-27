SHELL:=/bin/bash
export NXF_VER:=21.04.1
export PATH:=$(CURDIR):$(PATH)

install: ./nextflow

./nextflow:
	curl -fsSL get.nextflow.io | bash

run:
	nextflow run main.nf

clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
