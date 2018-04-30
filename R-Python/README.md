# Using R, Python, and other languages

This demonstration shows methods for using languages other than the default `bash` shell for executing code inside your Nextflow pipeline.

Methods shown:

- usage of scripts in the `bin` directory

- usage of other languages inline for your Nextflow process (R & Python shown)

- importation of custom modules and libraries from the `bin` directory in your inline R and Python scripts

- passing CLI arguments to your Python code chunk

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
- the executable file `nextflow` has been created in the folder: /Users/kellys04/projects/nextflow-demos/R-Python
- you may complete the installation by moving it to a directory in your $PATH

./nextflow run main.nf
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [tender_shockley] - revision: c9a6230f4f
[warm up] executor > local
[39/85b142] Submitted process > R_inline (Sample1)
[1a/55e374] Submitted process > Python_inline (Sample1)
[85/e180dc] Submitted process > test_R (Sample1)
[a4/03fbe3] Submitted process > Python_args
[0a/5fa24c] Submitted process > test_Python (Sample1)
The tools.py script has been loaded
[Python_inline] the sample is: Sample1
[Python_args] ['-', '[Sample1]']
[test_Python] The test.py script has been loaded
The tools.py script has been loaded
[1] "The tools.R file has been loaded"
[1] "[R_inline] the sample is: Sample1"
[test_R] [1] "the test.R script has been loaded"
[1] "The tools.R file has been loaded"
[1] "bar"
R version 3.3.0 (2016-05-03)
Platform: x86_64-apple-darwin13.4.0 (64-bit)
Running under: OS X 10.11.6 (El Capitan)

locale:
[1] C

attached base packages:
[1] stats     graphics  grDevices utils     datasets  base
```
