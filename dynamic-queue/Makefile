SHELL:=/bin/bash

install: ./nextflow

./nextflow:
	curl -fsSL get.nextflow.io | bash

run: install
	./nextflow run main.nf

clean:
	rm -f .nextflow.log* output.txt queue.log
	rm -rf .nextflow*
	rm -rf work
