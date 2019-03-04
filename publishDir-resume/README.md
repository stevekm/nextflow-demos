# publishDir resume

A basic demonstration that shows the behavior of the Nextflow `publishDir` when a workflow is run with `-resume` with different `overwrite` values and 'resume' states when using `mode: 'copy'`.

On `-resume`:

- a cached process output will not be re-copied to publishDir by default (`gather_files1` ; `publishDir "${params.output_dir}", mode: 'copy'`)

- a cached process output will be re-copied to publishDir if `overwrite: true` is specified (`gather_files2`; `publishDir "${params.output_dir}", mode: 'copy', overwrite: true`)

- an uncached process output will be re-copied to publishDir if `overwrite: true` is not specified (`gather_files3`; `publishDir "${params.output_dir}", mode: 'copy'`)

- an uncached process output will be re-copied to publishDir if `overwrite: true` is specified (`gather_files4`; `publishDir "${params.output_dir}", mode: 'copy', overwrite: true`)


## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

The terminal output should look like this:

```
$ ./nextflow run main.nf
N E X T F L O W  ~  version 19.01.0
Launching `main.nf` [maniac_mccarthy] - revision: 5546e69de0
~~~~~~~~~~~~~~~~~~~~~
a17bf2df-fae4-42b8-9be4-1b260505113c maniac_mccarthy
[warm up] executor > local
[58/06786b] Submitted process > make_file (3)
[02/c6583d] Submitted process > make_file (1)
[90/234450] Submitted process > make_file (2)
[7c/402834] Submitted process > make_file (4)
[00/41701b] Submitted process > gather_files2
[73/31ecc0] Submitted process > gather_files1
[14/a68aa9] Submitted process > gather_files4
[be/7f613f] Submitted process > gather_files3
ls -l output
total 64
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 15:10 Sample1.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 15:10 Sample2.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 15:10 Sample3.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 15:10 Sample4.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   80 Mar  4 15:10 output1.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   80 Mar  4 15:10 output2.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users  133 Mar  4 15:10 output3.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users  133 Mar  4 15:10 output4.txt
cat output/output3.txt
[make_file] Sample1
[make_file] Sample2
[make_file] Sample3
[make_file] Sample4
a17bf2df-fae4-42b8-9be4-1b260505113c maniac_mccarthy
cat output/output4.txt
[make_file] Sample1
[make_file] Sample2
[make_file] Sample3
[make_file] Sample4
a17bf2df-fae4-42b8-9be4-1b260505113c maniac_mccarthy
sleep 60
./nextflow run -resume main.nf
N E X T F L O W  ~  version 19.01.0
Launching `main.nf` [chaotic_tuckerman] - revision: 5546e69de0
~~~~~~~~~~~~~~~~~~~~~
a17bf2df-fae4-42b8-9be4-1b260505113c chaotic_tuckerman
[warm up] executor > local
[58/06786b] Cached process > make_file (3)
[90/234450] Cached process > make_file (2)
[7c/402834] Cached process > make_file (4)
[02/c6583d] Cached process > make_file (1)
[00/41701b] Cached process > gather_files2
[73/31ecc0] Cached process > gather_files1
[63/a44fe0] Submitted process > gather_files4
[23/7a0617] Submitted process > gather_files3
ls -l output
total 64
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 15:10 Sample1.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 15:10 Sample2.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 15:10 Sample3.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 15:10 Sample4.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   80 Mar  4 15:10 output1.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   80 Mar  4 15:11 output2.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users  135 Mar  4 15:11 output3.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users  135 Mar  4 15:11 output4.txt
cat output/output3.txt
[make_file] Sample1
[make_file] Sample2
[make_file] Sample3
[make_file] Sample4
a17bf2df-fae4-42b8-9be4-1b260505113c chaotic_tuckerman
cat output/output4.txt
[make_file] Sample1
[make_file] Sample2
[make_file] Sample3
[make_file] Sample4
a17bf2df-fae4-42b8-9be4-1b260505113c chaotic_tuckerman
```
