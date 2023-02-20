SHELL:=/bin/bash

install: ./nextflow

./nextflow:
	curl -fsSL get.nextflow.io | bash

clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
	[ -d output ] && mv output outputold && rm -rf outputold

clean-all: clean
	rm -f nextflow
	rm -rf .nextflow

run: install
	./nextflow run main.nf
