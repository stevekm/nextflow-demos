SHELL:=/bin/bash
EP:=-profile singularity
run: install alpine.3.8.simg
	./nextflow run main.nf $(EP)

install: ./nextflow

./nextflow:
	curl -fsSL get.nextflow.io | bash

alpine.3.8.simg:
	wget https://raw.githubusercontent.com/stevekm/nextflow-demos/alpine.3.8.simg/Singularity/alpine.3.8.simg

clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
