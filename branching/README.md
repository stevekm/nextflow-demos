# Branch Execution

A method for evaluation of multiple sets of parameters for each process, resulting in a branch tree dependency graph execution.

This example simulates a mock bioinformatics pipeline, where each step in analysis (alignment, deduplication, peak calling) may be performed with a number of different criteria, resulting in a combinatorial execution of all combinations of all paramter sets.

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

Output should look like this:

```
$ make run
./nextflow run main.nf
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [big_thompson] - revision: e11927200e
[warm up] executor > local
[b2/18eb24] Submitted process > align (demo2 - align.bar)
[99/8a500b] Submitted process > align (demo1 - align.foo)
[a3/9a289a] Submitted process > align (demo1 - align.bar)
[05/364510] Submitted process > align (demo2 - align.foo)
[72/47e427] Submitted process > align (demo3 - align.foo)
[10/d7afc7] Submitted process > align (demo3 - align.bar)
[68/d42cb9] Submitted process > dedup (demo1 - dedup.buz/align.foo)
[bd/813313] Submitted process > dedup (demo1 - dedup.baz/align.foo)
[6f/a647e0] Submitted process > dedup (demo1 - dedup.baz/align.bar)
[94/7aab47] Submitted process > dedup (demo1 - dedup.buz/align.bar)
[0f/417e3c] Submitted process > dedup (demo2 - dedup.baz/align.foo)
[11/86ee5a] Submitted process > dedup (demo2 - dedup.buz/align.foo)
[85/f0c42a] Submitted process > dedup (demo3 - dedup.baz/align.foo)
[35/db800d] Submitted process > dedup (demo3 - dedup.buz/align.foo)
[58/cd9362] Submitted process > dedup (demo3 - dedup.baz/align.bar)
[4a/12927d] Submitted process > dedup (demo3 - dedup.buz/align.bar)
[f7/dcdd5f] Submitted process > peak_calling (demo1 - peaks.bb/dedup.buz/align.foo)
[bb/3727c5] Submitted process > peak_calling (demo1 - peaks.aa/dedup.buz/align.foo)
[12/73717c] Submitted process > peak_calling (demo1 - peaks.aa/dedup.baz/align.foo)
[f3/27f05d] Submitted process > peak_calling (demo1 - peaks.bb/dedup.baz/align.foo)
[4a/5f8013] Submitted process > dedup (demo2 - dedup.buz/align.bar)
[65/d5e672] Submitted process > dedup (demo2 - dedup.baz/align.bar)
[9a/55de48] Submitted process > peak_calling (demo1 - peaks.aa/dedup.baz/align.bar)
[f0/ddb82d] Submitted process > peak_calling (demo1 - peaks.bb/dedup.baz/align.bar)
[7b/662582] Submitted process > peak_calling (demo1 - peaks.aa/dedup.buz/align.bar)
[87/dc5b09] Submitted process > peak_calling (demo1 - peaks.bb/dedup.buz/align.bar)
[46/f6f56c] Submitted process > peak_calling (demo2 - peaks.aa/dedup.baz/align.foo)
[d8/37007a] Submitted process > peak_calling (demo2 - peaks.bb/dedup.baz/align.foo)
[25/dabdca] Submitted process > peak_calling (demo3 - peaks.bb/dedup.baz/align.foo)
[b6/615c3a] Submitted process > peak_calling (demo3 - peaks.aa/dedup.baz/align.foo)
[b9/eb9502] Submitted process > peak_calling (demo3 - peaks.aa/dedup.buz/align.foo)
[b6/c18e7b] Submitted process > peak_calling (demo3 - peaks.bb/dedup.buz/align.foo)
[84/5d21d8] Submitted process > peak_calling (demo3 - peaks.bb/dedup.baz/align.bar)
[b7/8fa6c5] Submitted process > peak_calling (demo3 - peaks.aa/dedup.baz/align.bar)
[43/a18694] Submitted process > peak_calling (demo3 - peaks.bb/dedup.buz/align.bar)
[4a/45dbc9] Submitted process > peak_calling (demo3 - peaks.aa/dedup.buz/align.bar)
[8f/9e6606] Submitted process > peak_calling (demo2 - peaks.bb/dedup.buz/align.bar)
[04/4ffaab] Submitted process > peak_calling (demo2 - peaks.aa/dedup.buz/align.bar)
[41/72bfed] Submitted process > peak_calling (demo2 - peaks.bb/dedup.baz/align.bar)
[00/03a6b8] Submitted process > peak_calling (demo2 - peaks.aa/dedup.baz/align.bar)
[5f/630b3f] Submitted process > peak_calling (demo2 - peaks.aa/dedup.buz/align.foo)
[77/0e14ce] Submitted process > peak_calling (demo2 - peaks.bb/dedup.buz/align.foo)
```

And the output directory will look like this:

```
output/
|-- align.bar
|   |-- demo1.align.txt
|   |-- demo2.align.txt
|   `-- demo3.align.txt
|-- align.foo
|   |-- demo1.align.txt
|   |-- demo2.align.txt
|   `-- demo3.align.txt
|-- dedup.baz
|   |-- align.bar
|   |   |-- demo1.dedup.txt
|   |   |-- demo2.dedup.txt
|   |   `-- demo3.dedup.txt
|   `-- align.foo
|       |-- demo1.dedup.txt
|       |-- demo2.dedup.txt
|       `-- demo3.dedup.txt
|-- dedup.buz
|   |-- align.bar
|   |   |-- demo1.dedup.txt
|   |   |-- demo2.dedup.txt
|   |   `-- demo3.dedup.txt
|   `-- align.foo
|       |-- demo1.dedup.txt
|       |-- demo2.dedup.txt
|       `-- demo3.dedup.txt
|-- peaks.aa
|   |-- dedup.baz
|   |   |-- align.bar
|   |   |   |-- demo1.peaks.txt
|   |   |   |-- demo2.peaks.txt
|   |   |   `-- demo3.peaks.txt
|   |   `-- align.foo
|   |       |-- demo1.peaks.txt
|   |       |-- demo2.peaks.txt
|   |       `-- demo3.peaks.txt
|   `-- dedup.buz
|       |-- align.bar
|       |   |-- demo1.peaks.txt
|       |   |-- demo2.peaks.txt
|       |   `-- demo3.peaks.txt
|       `-- align.foo
|           |-- demo1.peaks.txt
|           |-- demo2.peaks.txt
|           `-- demo3.peaks.txt
`-- peaks.bb
    |-- dedup.baz
    |   |-- align.bar
    |   |   |-- demo1.peaks.txt
    |   |   |-- demo2.peaks.txt
    |   |   `-- demo3.peaks.txt
    |   `-- align.foo
    |       |-- demo1.peaks.txt
    |       |-- demo2.peaks.txt
    |       `-- demo3.peaks.txt
    `-- dedup.buz
        |-- align.bar
        |   |-- demo1.peaks.txt
        |   |-- demo2.peaks.txt
        |   `-- demo3.peaks.txt
        `-- align.foo
            |-- demo1.peaks.txt
            |-- demo2.peaks.txt
            `-- demo3.peaks.txt

22 directories, 42 files
```
