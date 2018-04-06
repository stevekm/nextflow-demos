# Output Files

A basic demonstration that creates files based on a list of sample ID's, then passes them to another process which prints the file contents to the terminal. Copies of pipeline output are saved in the `publishDir` defined in the Nextflow processes. Data is also collected by using the `collectFile` Channel operator, to concatenate/append data to a single file.

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
- the executable file `nextflow` has been created in the folder: /Users/kellys04/projects/nextflow-demos/output-files
- you may complete the installation by moving it to a directory in your $PATH

./nextflow run main.nf
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [crazy_colden] - revision: abeb42b8c5
[warm up] executor > local
[9b/81e842] Submitted process > make_file (Sample3)
[de/ec448b] Submitted process > make_file (Sample2)
[bd/e4f9cf] Submitted process > make_file (Sample4)
[de/f993a5] Submitted process > make_file (Sample1)
[2e/8b68f8] Submitted process > gather_files
```

Note the `work` directory which has been automatically generated and is used by Nextflow to hold data used by processes:

```
$ tree work/
work/
|-- 2e
|   `-- 8b68f81f730f5be2558c04c24975e8
|       |-- Sample1.txt -> /Users/kellys04/projects/nextflow-demos/output-files/work/de/f993a5a75d310d6c217bb1a5bf1ba7/Sample1.txt
|       |-- Sample2.txt -> /Users/kellys04/projects/nextflow-demos/output-files/work/de/ec448ba3c6c8b1409613f5fe3b33ec/Sample2.txt
|       |-- Sample3.txt -> /Users/kellys04/projects/nextflow-demos/output-files/work/9b/81e842ef4882812452338157038214/Sample3.txt
|       |-- Sample4.txt -> /Users/kellys04/projects/nextflow-demos/output-files/work/bd/e4f9cfe5e07325b5cdb52a70133b72/Sample4.txt
|       `-- output.txt
|-- 9b
|   `-- 81e842ef4882812452338157038214
|       `-- Sample3.txt
|-- bd
|   `-- e4f9cfe5e07325b5cdb52a70133b72
|       `-- Sample4.txt
`-- de
    |-- ec448ba3c6c8b1409613f5fe3b33ec
    |   `-- Sample2.txt
    `-- f993a5a75d310d6c217bb1a5bf1ba7
        `-- Sample1.txt

9 directories, 9 files
```

For end-user convenience, copies of the `output` files from the processes have been placed in the defined `publishDir`:

```
$ tree output
output
|-- gather_files
|   `-- output.txt
|-- make_file
|   |-- Sample1.txt
|   |-- Sample2.txt
|   |-- Sample3.txt
|   `-- Sample4.txt
`-- sample_files.txt

2 directories, 6 files
```

In particular, the `collectFile` operator allows for data to be collected into a single file during pipeline execution:

```
$ cat output/sample_files.txt
[make_file] Sample3
[make_file] Sample1
[make_file] Sample4
[make_file] Sample2
```
