SHELL:=/bin/bash
export NXF_VER:=19.10.0

install: ./nextflow

./nextflow:
	curl -fsSL get.nextflow.io | bash

clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
