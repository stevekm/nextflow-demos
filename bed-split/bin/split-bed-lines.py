#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Split a file into subsets based on the number of desired output lines

./split-bed-lines.py targets.bed 200

e.g. split 'targets.bed' into files with up to 200 lines
save the remainder to the last file
"""
import sys
args = sys.argv[1:]
inputFile = args[0] # "targets.bed"

# number of lines in each output file
num_chunk_lines = int(args[1]) # 5

# doesnt work with less than 1 line
if num_chunk_lines < 1:
    raise

def num_lines(fname):
    """
    Gets the total number of lines in the file
    """
    with open(fname) as f:
        for i, l in enumerate(f):
            pass
    return( i + 1 )

# total number of file lines
inputFile_numlines = num_lines(inputFile)
total_chunks = inputFile_numlines // num_chunk_lines

# read the input lines
with open(inputFile) as f:
    for i, line in enumerate(f):
        chunk_num = i // num_chunk_lines
        # filename label
        chunk_label = chunk_num + 1

        # put the remainder into the last file
        if chunk_label > total_chunks:
            chunk_label -= 1

        # write line to output file
        output_file = "{0}.{1}".format(inputFile, chunk_label)
        with open(output_file, "a") as fout:
            fout.write(line)
