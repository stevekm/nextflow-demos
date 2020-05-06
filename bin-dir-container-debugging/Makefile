SHELL:=/bin/bash
export NXF_VER:=20.01.0
# export NXF_ANSI_LOG=false

./nextflow:
	export NXF_VER="$(NXF_VER)" && \
	curl -fsSL get.nextflow.io | bash

install: ./nextflow


bash:
	bash

clean:
	rm -rf output
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
	rm -f *.html*
	rm -f trace.txt*
	rm -f dag.*
