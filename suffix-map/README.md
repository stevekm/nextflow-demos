# Suffix Map

This demonstration shows how to use a map (aka a dictionary) in order to keep track and set the filename suffixes for various processes, which can be later passed to another process in order to know which file was produced from while pipeline step. This is useful for cases when you might have a dynamic number of input files from multiple tasks, and you need to pass the dynamic list of files as input while maintaining a mapping between files and processes. 

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
Launching `main.nf` [sad_ardinghelli] - revision: 07e5376edc
[warm up] executor > local
suffix_key: [file1:file1.txt, file2:file2.txt]
[1f/63f8ee] Submitted process > make_file2 (Sample2)
[82/c20b1b] Submitted process > make_file1 (Sample3)
[b1/3eb9d9] Submitted process > make_file1 (Sample4)
[cd/358319] Submitted process > make_file1 (Sample1)
[19/0f2a50] Submitted process > make_file2 (Sample1)
[99/0fa1d7] Submitted process > make_file2 (Sample3)
[6f/3c8830] Submitted process > make_file2 (Sample4)
[da/8f6d23] Submitted process > make_file1 (Sample2)
[Sample3, [/Users/kellys04/projects/nextflow-demos/suffix-map/work/82/c20b1b0ada574d1baec3cf4833ae71/Sample3.file1.txt, /Users/kellys04/projects/nextflow-demos/suffix-map/work/99/0fa1d761df6db1081db53c375ce045/Sample3.file2.txt]]
[Sample4, [/Users/kellys04/projects/nextflow-demos/suffix-map/work/b1/3eb9d9ad1321322e5d955f6b29a529/Sample4.file1.txt, /Users/kellys04/projects/nextflow-demos/suffix-map/work/6f/3c883079226863c8eff4cbf0d5fb27/Sample4.file2.txt]]
[Sample1, [/Users/kellys04/projects/nextflow-demos/suffix-map/work/cd/3583197b310efcfd3cd41339bf6a41/Sample1.file1.txt, /Users/kellys04/projects/nextflow-demos/suffix-map/work/19/0f2a5025dfd31d4359d4a6ac04e141/Sample1.file2.txt]]
[Sample2, [/Users/kellys04/projects/nextflow-demos/suffix-map/work/da/8f6d2394c658ecfa0c6b2817af3d24/Sample2.file1.txt, /Users/kellys04/projects/nextflow-demos/suffix-map/work/1f/63f8eed5af5d0af697f71a73d08d89/Sample2.file2.txt]]
[5d/f3323c] Submitted process > collect_all_files (4)
[5e/044e10] Submitted process > collect_all_files (2)
[3a/9471db] Submitted process > collect_all_files (3)
[61/620e5a] Submitted process > collect_all_files (1)

[collect_all_files] Sample4:  Sample4.file1.txt Sample4.file2.txt

file1 suffix: file1.txt, file2 suffix: file2.txt

[collect_all_files] Sample2:  Sample2.file1.txt Sample2.file2.txt

file1 suffix: file1.txt, file2 suffix: file2.txt

[collect_all_files] Sample1:  Sample1.file1.txt Sample1.file2.txt

file1 suffix: file1.txt, file2 suffix: file2.txt

[collect_all_files] Sample3:  Sample3.file1.txt Sample3.file2.txt

file1 suffix: file1.txt, file2 suffix: file2.txt
```
