# Print Samples

A basic demonstration that prints sample ID's from a list to the terminal

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

Output should look like this:

```
$ make run
export NXF_VER="0.28.0" && \
	curl -fsSL get.nextflow.io | bash

      N E X T F L O W
      version 0.28.0 build 4779
      last modified 10-03-2018 12:13 UTC (07:13 EDT)
      cite doi:10.1038/nbt.3820
      http://nextflow.io


Nextflow installation completed. Please note:
- the executable file `nextflow` has been created in the folder: /Users/kellys04/projects/nextflow-demos/print-samples
- you may complete the installation by moving it to a directory in your $PATH

./nextflow run main.nf
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [cranky_marconi] - revision: f7c60f5d39
[samples] Sample1
[samples] Sample2
[samples] Sample3
[samples] Sample4
[warm up] executor > local
[2f/a2013d] Submitted process > with_tags (Sample4)
[f5/9caa63] Submitted process > with_tags (Sample1)
[9f/be1bb6] Submitted process > with_echo (Sample1)
[bc/55a990] Submitted process > print_sample (1)
[0a/e029d5] Submitted process > print_sample (4)
[5d/9b58d8] Submitted process > with_echo (Sample3)
[85/f837f4] Submitted process > with_tags (Sample3)
[cb/aa4377] Submitted process > print_sample (3)
[d5/2ca1e0] Submitted process > with_echo (Sample2)
[c9/6c71f0] Submitted process > with_tags (Sample2)
[3a/cc9f81] Submitted process > with_echo (Sample4)
[with_echo] Sample1
[2e/46d77c] Submitted process > print_sample (2)
[with_echo] Sample3
[with_echo] Sample2
[with_echo] Sample4
```
