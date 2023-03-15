# Asynchronous Task Execution

This demonstration shows how Nextflow executes processes independently in parallel.

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

The terminal output should look like this:

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
- the executable file `nextflow` has been created in the folder: /Users/kellys04/projects/nextflow-demos/async
- you may complete the installation by moving it to a directory in your $PATH

./nextflow run main.nf
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [peaceful_baekeland] - revision: da96d1de03
[warm up] executor > local
[5d/667abb] Submitted process > make_file (Sample2)
[14/263ef6] Submitted process > print_sample (Sample3)
[61/0cf231] Submitted process > print_sample (Sample2)
[6b/0553e9] Submitted process > make_file (Sample1)
[34/3ec3ee] Submitted process > make_file (Sample3)
[f6/53db90] Submitted process > print_sample (Sample1)
[make_file] Sample2
[print_sample] sample is: Sample3
[print_sample] sample is: Sample2
[make_file] Sample1
[make_file] Sample3
[print_sample] sample is: Sample1
[8b/e89ff4] Submitted process > gather_files
[gather_files] gathering all files...
```

Note that all of the `make_file` and `print_sample` processes were submitted for execution independently of each other, and ran in parallel. Their execution does not follow any particular order, and may vary each time the pipeline is run. On the other hand, the `gather_files` process depends on the completion of all `make_file` processes for its input, so it does not execute until all `make_file` processes have completed. 
