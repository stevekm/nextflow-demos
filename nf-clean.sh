#!/bin/bash
set -euxo pipefail

rm -rfv .nextflow*
rm -rfv .pytest_cache
rm -frv __pycache__
rm -fv *.log*
rm -rfv work
rm -rfv output
