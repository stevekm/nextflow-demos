#!/bin/bash
set -euxo pipefail

rm -rfv .nextflow*
rm -rfv .pytest_cache
rm -fv *.log*
rm -rfv work
rm -rfv output