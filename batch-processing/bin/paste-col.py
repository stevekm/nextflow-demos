#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Writes a single str as a new column in the file.

Basic use case; write a column with a sample ID to a table

Usage:

$ printf "a\tb\tc\nd\te\tf\n" > text.txt

$ cat text.txt
a	b	c
d	e	f

$ cat text.txt | ./paste-col.py -v foo
a	b	c	foo
d	e	f	foo

$ cat text.txt | ./paste-col.py -v foo --header bar
a	b	c	bar
d	e	f	foo

$ ./paste-col.py -i text.txt -o text2.txt -v baz -d ,

$ cat text2.txt
a	b	c,baz
d	e	f,baz

$ cat text.txt | ./paste-col.py -v buz | head -1
a	b	c	buz

$ cat sample.hg19_multianno.txt | ./paste-col.py --header Sample -v foo2 | head

"""
import os
import sys
import argparse

from signal import signal, SIGPIPE, SIG_DFL
signal(SIGPIPE,SIG_DFL)
"""
https://stackoverflow.com/questions/14207708/ioerror-errno-32-broken-pipe-python
"""

def main(**kwargs):
    """
    Paste the column on the file
    """
    input_file = kwargs.pop('input_file', None)
    output_file = kwargs.pop('output_file', None)
    delim = kwargs.pop('delim', '\t')
    header = kwargs.pop('header', None)
    value = kwargs.pop('value')

    if input_file:
        fin = open(input_file)
    else:
        fin = sys.stdin

    if output_file:
        fout = open(output_file, "w")
    else:
        fout = sys.stdout

    if header:
        old_header = next(fin).strip()
        new_header = old_header + delim + header + '\n'
        fout.write(new_header)

    for line in fin:
        new_line = line.strip() + delim + value + '\n'
        fout.write(new_line)

    fout.close()
    fin.close()

def parse():
    """
    Parses script args
    """
    parser = argparse.ArgumentParser(description='Append a column of text to a file')
    parser.add_argument("-i", default = None, dest = 'input_file', help="Input file")
    parser.add_argument("-o", default = None, dest = 'output_file', help="Output file")
    parser.add_argument("-d", default = '\t', dest = 'delim', help="Delimiter")
    parser.add_argument("--header", default = None, dest = 'header', help="Header for the new column")
    parser.add_argument("-v", "--value", required=True, dest = 'value', help="Value to write in the new column")
    args = parser.parse_args()

    main(**vars(args))

if __name__ == '__main__':
    parse()
