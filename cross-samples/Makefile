SHELL:=/bin/bash

run: install
	./nextflow run main.nf

install: ./nextflow

./nextflow:
	curl -fsSL get.nextflow.io | bash

clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
