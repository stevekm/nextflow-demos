# Variable Input Files

This demonstration shows how to collect a variable number of output files per-sample from Nextflow processes and then pass them to a final process for per-sample handling of all files passed.

The key to this method is to start with a channel containing each sample and a placeholder file, which may be removed or ignored later, then concatenate this with the output from all desired processes then utilize `groupTuple` to aggregate all per-sample items into a single list of files.

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

Terminal output should look like this:

```
$ ./nextflow run main.nf
N E X T F L O W  ~  version 19.01.0
Launching `main.nf` [amazing_roentgen] - revision: 7b375b0142
[warm up] executor > local
[95/b72844] Submitted process > make_file1 (Sample4)
[bf/de1d41] Submitted process > make_file2 (Sample2)
[24/d2f972] Submitted process > make_file1 (Sample2)
[99/28a31a] Submitted process > make_file1 (Sample3)
[3d/efa0e4] Submitted process > make_file2 (Sample3)
[09/bcf525] Submitted process > make_file2 (Sample4)
[10/86795e] Submitted process > make_file2 (Sample1)
[77/fdceac] Submitted process > make_file1 (Sample1)
/Users/kellys04/projects/nextflow-demos/variable-input-files/.placeholder will be removed from the list
/Users/kellys04/projects/nextflow-demos/variable-input-files/.placeholder will be removed from the list
/Users/kellys04/projects/nextflow-demos/variable-input-files/.placeholder will be removed from the list
/Users/kellys04/projects/nextflow-demos/variable-input-files/.placeholder will be removed from the list
[bc/05da3d] Submitted process > collect_all_files (3)
[a9/a17c36] Submitted process > collect_all_files (2)
[3e/3854bd] Submitted process > collect_all_files (1)
[69/f48d8f] Submitted process > collect_all_files (4)
[collect_all_files] Sample3: got these files:
[collect_all_files] Sample4: got these files: Sample4.file2.txt
[collect_all_files] Sample1: got these files: Sample1.file1.txt Sample1.file2.txt
[collect_all_files] Sample2: got these files: Sample2.file1.txt Sample2.file2.txt
```
