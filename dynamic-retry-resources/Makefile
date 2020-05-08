SHELL:=/bin/bash
export NXF_VER:=19.10.0

install: ./nextflow

./nextflow:
	curl -fsSL get.nextflow.io | bash

cmd:
	@echo './nextflow run main.nf --memory 1.2MB --time 2m10s --maxRetries 2'
	@echo './nextflow run main.nf --memory 3GB --time 1h13m --maxRetries 3'


clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
