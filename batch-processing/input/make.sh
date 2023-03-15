#!/bin/bash
# sets up the demo input dir
for i in Sample1 Sample2 Sample3 Sample4 Sample5 Sample6 Sample7 Sample8 Sample9 Sample10; do
    for q in HaplotypeCaller LoFreq MuTect2; do
        mkdir -p "${i}/${q}"
        sourcepath="$(python -c "import os; print(os.path.realpath('variants.tsv'))")"
        (
        cd "${i}/${q}"
        ln -fs "${sourcepath}"
        )
    done
done
