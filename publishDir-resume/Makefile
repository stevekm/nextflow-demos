SHELL:=/bin/bash

install: ./nextflow

./nextflow:
	curl -fsSL get.nextflow.io | bash

clean:
	rm -f .nextflow.log*
	rm -rf .nextflow*
	rm -rf work
	rm -rf output

run: install
	./nextflow run main.nf
	ls -l output
	cat output/output3.txt
	cat output/output4.txt
	sleep 60
	./nextflow run -resume main.nf
	ls -l output
	cat output/output3.txt
	cat output/output4.txt
	sleep 60
	rm -f output/output1.txt
	ls -l output
	./nextflow run -resume main.nf
	ls -l output
