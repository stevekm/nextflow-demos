# `get_outputfile`

Get a custom output filename suffix for each Nextflow task from a custom `get_outputfile` function.

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

Output should look like this:

```
N E X T F L O W  ~  version 18.10.1
Launching `main.nf` [fervent_wescoff] - revision: e0035156d5
[warm up] executor > local
[16/509c0e] Submitted process > task2 (a)
[42/c6735e] Submitted process > task2 (c)
[22/145899] Submitted process > task1 (c)
[23/d2244c] Submitted process > task1 (b)
[6a/7d57fa] Submitted process > task1 (a)
[58/be3597] Submitted process > task2 (b)
[task2] c.baz.txt, tmp
[task1] c.bar.txt
[task1] b.bar.txt
[task1] a.bar.txt
[task2] b.baz.txt, tmp
[task2] a.baz.txt, tmp
```
