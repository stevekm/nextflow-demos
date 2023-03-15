#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Concatenates supplied input table files, filling in missing columns between files

Notes
-----
All tables should have the same delimiter. No single table should have duplicated column names (e.g. file1.tsv and file2.tsv can share column names, but each column in file1.tsv should have a unique header, etc.)

Examples
--------
Example usage::

    ./concat-tables.py -o concat.tsv NC-HAPMAP.HaplotypeCaller.annotations.tsv NC-HAPMAP.LoFreq.annotations.tsv

"""
import csv
import sys
from collections import OrderedDict
import argparse

from signal import signal, SIGPIPE, SIG_DFL
signal(SIGPIPE,SIG_DFL)
"""
https://stackoverflow.com/questions/14207708/ioerror-errno-32-broken-pipe-python
"""

def get_all_fieldnames(files, delimiter):
    """
    Retrieves all the column names from all files in the list

    Paramters
    ---------
    files: list
        a list of paths to input files
    delimiter: str
        the delimiter to use for the input files

    Returns
    -------
    list
        a list of column names amongst all the files

    Notes
    -----
    The column names will be returned in the following order: all columns from the first file, then each missing column from all subsequent files.
    """
    fieldnames = OrderedDict()
    for f in files:
        with open(f) as fin:
            reader = csv.DictReader(fin, delimiter = delimiter)
            for name in reader.fieldnames:
                fieldnames[name] = ''
    return(fieldnames.keys())

def update_dict(d, keys, default_val):
    """
    Checks that all provided fieldnames exist as keys in the dict, and if they are missing creates them with the default value

    Parameters
    ----------
    d: dict
        a dictionary to be updated
    keys: list
        a list of keys to check in the dict
    default_val: str
        a default value to initialize the missing keys to

    Returns
    -------
    dict
        a dictionary with the updated keys
    """
    for key in keys:
        if not d.get(key, None):
            d[key] = default_val
    return(d)

def main(**kwargs):
    """
    Main control function for the script
    """
    input_files = kwargs.pop('input_files')
    output_file = kwargs.pop('output_file', None)
    delimiter = kwargs.pop('delimiter', '\t')
    na_str = kwargs.pop('na_str', '.')

    output_fieldnames = get_all_fieldnames(files = input_files, delimiter = delimiter)

    if output_file:
        fout = open(output_file, "w")
    else:
        fout = sys.stdout

    writer = csv.DictWriter(fout, delimiter = delimiter, fieldnames = output_fieldnames)
    writer.writeheader()
    for input_file in input_files:
        with open(input_file) as fin:
            reader = csv.DictReader(fin, delimiter = delimiter)
            for row in reader:
                row = update_dict(d = row, keys = output_fieldnames, default_val = na_str)
                writer.writerow(row)

    fout.close()



def parse():
    """
    Parses script args
    """
    parser = argparse.ArgumentParser(description='Concatenates tables')
    parser.add_argument('input_files', nargs='*', help="Input files")
    parser.add_argument("-o", default = None, dest = 'output_file', help="Output file")
    parser.add_argument("-d", default = '\t', dest = 'delimiter', help="Delimiter")
    parser.add_argument("-n", default = '.', dest = 'na_str', help="NA string; character to insert for missing fields in table")
    args = parser.parse_args()

    main(**vars(args))

if __name__ == '__main__':
    parse()
