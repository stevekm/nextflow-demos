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

run: install
	./nextflow run main.nf -with-dag flowchart.dot


flowchart:
	[ -f flowchart.dot ] && dot flowchart.dot -Tpng -o flowchart.png || echo "file flowchart.dot not present"
