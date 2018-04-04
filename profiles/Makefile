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
	rm -f timeline-report.html.*
	rm -f trace.txt.*
	rm -f nextflow-report.html.*
	rm -rf flowchart.dot.*

clean-all: clean
	rm -f flowchart.dot
	rm -f nextflow-report.html
	rm -f timeline-report.html
	rm -f trace.txt

check-fastq:
	fastqc --version > /dev/null 2>&1 || { echo "ERROR: 'fastqc' not found" && exit 1 ; }

check-docker:
	docker --version > /dev/null 2>&1 || { echo "ERROR: 'docker' not found" && exit 1 ; }

check-module:
	module > /dev/null 2>&1 || { echo "ERROR: 'module' not found" && exit 1 ; }

run: install check-fastq
	./nextflow run main.nf -with-dag flowchart.dot

run-docker: install check-docker
	./nextflow run main.nf -with-dag flowchart.dot -profile docker

run-phoenix: install check-module
	./nextflow run main.nf -with-dag flowchart.dot -profile phoenix

flowchart:
	[ -f flowchart.dot ] && dot flowchart.dot -Tpng -o flowchart.png || echo "file flowchart.dot not present"
