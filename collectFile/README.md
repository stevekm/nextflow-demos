# `collectFile`

This demonstration shows how to use the `collectFile` to concatenate output from multiple processes and then pass it to another process for processing. 

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

The terminal output should look like this:

```
$ make run
./nextflow run main.nf
N E X T F L O W  ~  version 19.01.0
Launching `main.nf` [drunk_lavoisier] - revision: 4abc0baf16
[warm up] executor > local
[38/dfdec1] Submitted process > make_file (Sample1)
[aa/fe3de2] Submitted process > make_file (Sample3)
[14/84aa2e] Submitted process > make_file (Sample2)
[make_file] Sample1
[make_file] Sample3
[make_file] Sample2
[2c/0a41b1] Submitted process > print_collected_file (1)
[print_collected_file (sample_files.txt)]: [make_file] Sample2
[print_collected_file (sample_files.txt)]: [make_file] Sample3
[print_collected_file (sample_files.txt)]: [make_file] Sample1
```
