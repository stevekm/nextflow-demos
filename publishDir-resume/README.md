# publishDir resume

A basic demonstration that shows the behavior of the Nextflow `publishDir` when a workflow is run with `-resume` with different `overwrite` values and 'resume' states when using `mode: 'copy'`.

On `-resume`:

- a cached process output will not be re-copied to publishDir by default (`gather_files1` ; `publishDir "${params.output_dir}", mode: 'copy'`)

- a cached process output will be re-copied to publishDir if `overwrite: true` is specified (`gather_files2`; `publishDir "${params.output_dir}", mode: 'copy', overwrite: true`)

- an uncached process output will be re-copied to publishDir if `overwrite: true` is not specified (`gather_files3`; `publishDir "${params.output_dir}", mode: 'copy'`)

- an uncached process output will be re-copied to publishDir if `overwrite: true` is specified (`gather_files4`; `publishDir "${params.output_dir}", mode: 'copy', overwrite: true`)

- a file removed from the `publishDir` will be re-copied with the latest available version regardless of the process's cached/uncached status

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
Launching `main.nf` [naughty_gautier] - revision: 8a4644003d
~~~~~~~~~~~~~~~~~~~~~
42af0f7f-8e42-4560-bab6-db8d77ffc5d1 naughty_gautier
[warm up] executor > local
[b4/fead77] Submitted process > make_file (2)
[61/5b5657] Submitted process > make_file (1)
[86/cec677] Submitted process > make_file (4)
[19/e92001] Submitted process > make_file (3)
[c2/b1000f] Submitted process > gather_files1
[2a/39f7c1] Submitted process > gather_files2
[2b/a89310] Submitted process > gather_files3
[81/87f35e] Submitted process > gather_files4
ls -l output
total 64
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample1.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample2.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample3.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample4.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   80 Mar  4 16:16 output1.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   80 Mar  4 16:16 output2.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users  133 Mar  4 16:16 output3.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users  133 Mar  4 16:16 output4.txt
cat output/output3.txt
[make_file] Sample1
[make_file] Sample2
[make_file] Sample3
[make_file] Sample4
42af0f7f-8e42-4560-bab6-db8d77ffc5d1 naughty_gautier
cat output/output4.txt
[make_file] Sample1
[make_file] Sample2
[make_file] Sample3
[make_file] Sample4
42af0f7f-8e42-4560-bab6-db8d77ffc5d1 naughty_gautier
sleep 60
./nextflow run -resume main.nf
N E X T F L O W  ~  version 19.01.0
Launching `main.nf` [sharp_bhabha] - revision: 8a4644003d
~~~~~~~~~~~~~~~~~~~~~
42af0f7f-8e42-4560-bab6-db8d77ffc5d1 sharp_bhabha
[warm up] executor > local
[b4/fead77] Cached process > make_file (2)
[86/cec677] Cached process > make_file (4)
[61/5b5657] Cached process > make_file (1)
[19/e92001] Cached process > make_file (3)
[c2/b1000f] Cached process > gather_files1
[2a/39f7c1] Cached process > gather_files2
[8c/588599] Submitted process > gather_files3
[04/1deb4c] Submitted process > gather_files4
ls -l output
total 64
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample1.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample2.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample3.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample4.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   80 Mar  4 16:16 output1.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   80 Mar  4 16:17 output2.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users  130 Mar  4 16:17 output3.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users  130 Mar  4 16:17 output4.txt
cat output/output3.txt
[make_file] Sample1
[make_file] Sample2
[make_file] Sample3
[make_file] Sample4
42af0f7f-8e42-4560-bab6-db8d77ffc5d1 sharp_bhabha
cat output/output4.txt
[make_file] Sample1
[make_file] Sample2
[make_file] Sample3
[make_file] Sample4
42af0f7f-8e42-4560-bab6-db8d77ffc5d1 sharp_bhabha
sleep 60
rm -f output/output1.txt
ls -l output
total 56
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample1.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample2.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample3.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample4.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   80 Mar  4 16:17 output2.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users  130 Mar  4 16:17 output3.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users  130 Mar  4 16:17 output4.txt
./nextflow run -resume main.nf
N E X T F L O W  ~  version 19.01.0
Launching `main.nf` [pensive_torvalds] - revision: 8a4644003d
~~~~~~~~~~~~~~~~~~~~~
42af0f7f-8e42-4560-bab6-db8d77ffc5d1 pensive_torvalds
[warm up] executor > local
[b4/fead77] Cached process > make_file (2)
[19/e92001] Cached process > make_file (3)
[61/5b5657] Cached process > make_file (1)
[86/cec677] Cached process > make_file (4)
[2a/39f7c1] Cached process > gather_files2
[c2/b1000f] Cached process > gather_files1
[68/23d115] Submitted process > gather_files4
[d3/5494c1] Submitted process > gather_files3
ls -l output
total 64
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample1.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample2.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample3.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   20 Mar  4 16:16 Sample4.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   80 Mar  4 16:18 output1.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users   80 Mar  4 16:18 output2.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users  134 Mar  4 16:18 output3.txt
-rw-r--r--  1 kellys04  NYUMC\Domain Users  134 Mar  4 16:18 output4.txt
```
