#!/bin/bash

# finds the variants in the demo input dir
# outputs a file with the paths and metadata for use in pipeline
printf '' > all-variants.tsv
for item in $(find input/ -mindepth 2 -name "variants.tsv" | grep -v -f unwanted_samples.txt); do
    caller="$(basename $(dirname "${item}"))"
    sampleID="$(basename $(dirname $(dirname "${item}")))"

    printf "${caller}\t${sampleID}\t${item}\n" >> all-variants.tsv
done
