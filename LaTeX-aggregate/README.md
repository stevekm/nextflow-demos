# LaTeX Aggregate

A demonstration of aggregating multiple PDFs into a single report with LaTeX.

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
N E X T F L O W  ~  version 0.31.0
Launching `main.nf` [ridiculous_heisenberg] - revision: 7fd5e859de
[warm up] executor > local
[36/6ed873] Submitted process > print_word (baz)
[8e/fefce1] Submitted process > print_word (foo)
[b0/fb5b5d] Submitted process > print_word (bar)
[79/5f4277] Submitted process > make_report (1)
```
