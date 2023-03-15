#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Split a bed file into separate files per chromosome
"""
import sys
args = sys.argv[1:]
inputFile = args[0] # "targets.bed"

with open(inputFile) as f:
    for line in f:
        chrom = line.split('\t')[0]
        # make sure its not an empty string
        if len(chrom.strip()) > 0:
            output_file = "{0}.{1}".format(inputFile, chrom)
            with open(output_file, "a") as fout:
                fout.write(line)
