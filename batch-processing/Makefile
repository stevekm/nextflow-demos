SHELL:=/bin/bash
NXF_VER:=0.29.0
.PHONY: all-variants.tsv

run: install all-variants.tsv
	./nextflow run main.nf

install: ./nextflow

./nextflow:
	export NXF_VER="$(NXF_VER)" && \
	curl -fsSL get.nextflow.io | bash

all-variants.tsv:
	./find-variants.sh

clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
	[ -d output ] && mv output outputold && rm -rf outputold
