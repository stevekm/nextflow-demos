# Collect File Paths

A basic demonstration of methods for passing file paths, instead of files themselves, between Nextflow processes.

Some files will be created, then their paths will be aggregated into a file list and passed to a Nextflow process for usage. 

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

The terminal output should look like this:

```
$ make run
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [pensive_tesla] - revision: 24772f26bc
[warm up] executor > local
[87/cba388] Submitted process > make_file (Sample1.txt)
[0e/aef43b] Submitted process > make_file (Sample4.txt)
[65/27a578] Submitted process > make_file (Sample2.txt)
[db/54143a] Submitted process > make_file (Sample3.txt)
[4b/57cbea] Submitted process > print_file (1)
[print_file]:
/Users/kellys04/projects/nextflow-demos/collect-file-paths/work/65/27a578c8bb7eb137af32e7c18ef565/Sample2.txt
/Users/kellys04/projects/nextflow-demos/collect-file-paths/work/87/cba388c67295954fdb48ee84a4f81a/Sample1.txt
/Users/kellys04/projects/nextflow-demos/collect-file-paths/work/db/54143a3e58b616a32dc0b65a348d4c/Sample3.txt
/Users/kellys04/projects/nextflow-demos/collect-file-paths/work/0e/aef43b323119d31c5ffd51e7d420f2/Sample4.txt

```
