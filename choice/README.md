# Choice

A demonstration of separating items into different channels based on criteria. Also shows how to collect log messages based on the contents.

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
N E X T F L O W  ~  version 0.29.0
Launching `main.nf` [sharp_dalembert] - revision: fd71b6a4ba
[warm up] executor > local
[first_inputs] demo1 /Users/kellys04/projects/nextflow-demos/choice/demo1.tsv 1 1
[second_inputs] demo4 /Users/kellys04/projects/nextflow-demos/choice/demo4.tsv 1 1
[first_inputs] demo2 /Users/kellys04/projects/nextflow-demos/choice/demo2.tsv 2 0
[first_inputs] demo3 /Users/kellys04/projects/nextflow-demos/choice/demo3.tsv 1 1
[second_inputs] demo5 /Users/kellys04/projects/nextflow-demos/choice/demo5.tsv 2 0
[8b/06ee35] Submitted process > start_bad (1)
[00/bd6203] Submitted process > start_good (1)
```
Output files created:
```
$ cat all_good_inputs.txt
File has enough lines	demo5	/Users/kellys04/projects/nextflow-demos/choice/demo5.tsv
File has enough lines	demo2	/Users/kellys04/projects/nextflow-demos/choice/demo2.tsv

$ cat all_bad_inputs.txt
Not enough lines in file	demo4	/Users/kellys04/projects/nextflow-demos/choice/demo4.tsv
Not enough lines in file	demo3	/Users/kellys04/projects/nextflow-demos/choice/demo3.tsv
Not enough lines in file	demo1	/Users/kellys04/projects/nextflow-demos/choice/demo1.tsv
```
