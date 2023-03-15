SHELL:=/bin/bash
NXF_VER:=0.29.0

run: install
	./nextflow run main.nf

install: ./nextflow

data:
	printf 'foo' > demo1.tsv; printf 'foo\nbar' > demo2.tsv; printf 'foo' > demo3.tsv; printf 'foo' > demo4.tsv; printf 'foo\nbar' > demo5.tsv

./nextflow:
	export NXF_VER="$(NXF_VER)" && \
	curl -fsSL get.nextflow.io | bash

clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
	rm -f all_good_inputs.txt
	rm -f all_bad_inputs.txt
