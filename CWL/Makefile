SHELL:=/bin/bash
UNAME:=$(shell uname)
MACHINE:=$(shell uname -m)
PATH:=$(CURDIR)/conda/bin:$(PATH)
export NXF_VER:=20.01.0
export NXF_ANSI_LOG=false
unexport PYTHONPATH
unexport PYTHONHOME
export CONDA_PREFIX:=$(CURDIR)/conda
export JAVA_HOME=$(CONDA_PREFIX)

ifeq ($(UNAME), Darwin)
CONDASH:=Miniconda3-4.5.4-MacOSX-x86_64.sh
export JAVA_LD_LIBRARY_PATH=$(JAVA_HOME)/jre/lib/server
endif

ifeq ($(UNAME), Linux)
CONDASH:=Miniconda3-4.5.4-Linux-x86_64.sh

ifeq ($(MACHINE), x86_64)
export JAVA_LD_LIBRARY_PATH=$(JAVA_HOME)/jre/lib/amd64/server
else
export JAVA_LD_LIBRARY_PATH=$(JAVA_HOME)/jre/lib/i386/server
endif

endif

CONDAURL:=https://repo.continuum.io/miniconda/$(CONDASH)

conda:
	@echo ">>> Setting up conda..."
	@wget "$(CONDAURL)" && \
	bash "$(CONDASH)" -b -p conda && \
	rm -f "$(CONDASH)"

install: conda
	conda install -y \
	bioconda::nextflow=20.01.0 \
	jq=1.5 \
	anaconda::graphviz
	pip install cwltool==2.0.20200126090152 cwlref-runner==1.0

export TYPE=zip
run:
	nextflow run main.nf --archive_type "$(TYPE)" \
	-with-report nextflow.html \
	-with-timeline timeline.html \
	-with-trace trace.txt \
	-with-dag dag.png

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
