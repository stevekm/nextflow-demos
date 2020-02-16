# Running CWL in Nextflow

This directory contains a demonstration of a method for running CWL pipelines with Nextflow.

Many people have pre-established pipelines written in CWL, but may desired to use some of the features of Nextflow. This demo will show how to use your currently existing CWL while making use of some convenient Nextflow features such as:

- pre-filtering of task inputs to prevent 'bad' samples from getting through

- allowing one or more samples in the pipeline to fail and still continue execution with the remaining samples

- dynamically changing the tasks to be executed based on input parameters

- automatic HTML report generation and workflow graph visualization

This simple pipeline will process four "samples", create a custom text file for each one containing a message, then create an archive for each message. At the end, all of the archives that pass all pipeline steps will be gathered for batch processing.

The pipeline has two modes of operation: 'zip' mode and 'tar' mode, corresponding to the archive format to be used.

We will be using the CWL pipelines contained in the `cwl` directory: `echo.cwl`, `zip.cwl`, and `tar.cwl`.

## Installation

We need a handful of dependencies for this demonstration, so first run:

```
make install
```

in order to install the required software. We will use:

- CWL reference runner (cwltool)

- Nextflow

- `jq`

- Graphviz (for DAG plot)

These items will be installed in the current directory. The included Makefile will make it easier to use them. When you execute commands with the Makefile, the environment will be pre-populated to make these installed dependencies available. A command `make bash` has been included for convenience to drop you into an interactive bash session with the populated environment if you want to experiment yourself.

## Usage

The pipeline can be run easily with the included `make run` command:

```
$ make run
nextflow run main.nf --archive_type "zip" \
	-with-report nextflow.html \
	-with-timeline timeline.html \
	-with-trace trace.txt \
	-with-dag dag.png
N E X T F L O W  ~  version 20.01.0
Launching `main.nf` [fabulous_davinci] - revision: d4abb2c6f2
WARN: Task runtime metrics are not reported when using macOS without a container engine
[e0/e3e9bd] Submitted process > create_message (Sample3)
[f2/38e6cc] Submitted process > create_message (Sample2)
[a2/23c8f1] Submitted process > create_message (Sample1)
[0a/998b23] Submitted process > create_message (Sample4)
[1a/70bd87] Submitted process > print_message (Sample1)
[3c/491c5a] Submitted process > print_message (Sample4)
[20/d29772] Submitted process > print_message (Sample3)
[4c/17f557] Submitted process > print_message (Sample2)
Got message for sample Sample1 from file message.txt: hello this is Sample1
[d9/fc52b1] Submitted process > zip_message (Sample1)
Got message for sample Sample3 from file message.txt: hello this is Sample3
[a4/cd6d3e] Submitted process > zip_message (Sample3)
Got message for sample Sample2 from file message.txt: hello this is Sample2
[4a/6def52] Submitted process > zip_message (Sample2)
Got message for sample Sample4 from file message.txt: hello this is Sample4
WARNING: bad sample was filtered out: Sample4
[35/a7329d] Submitted process > please_dont_break (Sample1)
[f9/141d00] Submitted process > please_dont_break (Sample2)
[f9/52510a] Submitted process > please_dont_break (Sample3)
[f9/141d00] NOTE: Process `please_dont_break (Sample2)` terminated with an error exit status (1) -- Error is ignored
[81/934e7e] Submitted process > gather_files (1)
Got these files of type zip:
Sample1.message.zip Sample3.message.zip
```

We can see that there were 4 samples input in the pipeline. However, 'Sample4' was detected as being "bad" and was removed from the pipeline before it could break anything. On the other hand, 'Sample2' was also bad and managed to break a pipeline step, however the pipeline was able to continue to completion despite the failure. Ultimately, only two samples passed all pipeline steps and made it to the end for processing.

You will notice the command line argument `--archive_type "zip"`, which tells the pipeline to output .zip items via the `zip_message` workflow task. We can change this to 'tar' to get the output in a .tar.gz file instead. For convenience, the Makefile has been set up to allow you to pass this through.

```
$ make run TYPE=tar
nextflow run main.nf --archive_type "tar" \
	-with-report nextflow.html \
	-with-timeline timeline.html \
	-with-trace trace.txt \
	-with-dag dag.png
N E X T F L O W  ~  version 20.01.0
Launching `main.nf` [cheesy_cajal] - revision: 4f2aadde6f
WARN: Task runtime metrics are not reported when using macOS without a container engine
[b3/cb2636] Submitted process > create_message (Sample4)
[02/244a33] Submitted process > create_message (Sample3)
[8d/46923c] Submitted process > create_message (Sample2)
[0e/c16d9a] Submitted process > create_message (Sample1)
[1d/fc9e2c] Submitted process > print_message (Sample1)
[54/305899] Submitted process > print_message (Sample4)
[5c/a2e684] Submitted process > print_message (Sample2)
[f6/b099ca] Submitted process > print_message (Sample3)
Got message for sample Sample1 from file message.txt: hello this is Sample1
[d5/18dd54] Submitted process > tar_message (Sample1)
Got message for sample Sample4 from file message.txt: hello this is Sample4
WARNING: bad sample was filtered out: Sample4
Got message for sample Sample2 from file message.txt: hello this is Sample2
Got message for sample Sample3 from file message.txt: hello this is Sample3
[8c/bdda32] Submitted process > tar_message (Sample2)
[0b/d23025] Submitted process > tar_message (Sample3)
[4a/52b3c9] Submitted process > please_dont_break (Sample1)
[b8/ae2d6a] Submitted process > please_dont_break (Sample2)
[c7/27beb0] Submitted process > please_dont_break (Sample3)
[b8/ae2d6a] NOTE: Process `please_dont_break (Sample2)` terminated with an error exit status (1) -- Error is ignored
[7e/2c3675] Submitted process > gather_files (1)
Got these files of type tar:
Sample1.message.tar.gz Sample3.message.tar.gz
```

This time, we got files for the same set of samples, but they were passed through the `tar_message` which produced .tar.gz files.

You will also notice some extra items output in the current directory; `trace.txt`, `nextflow.html`, `timeline.html`, and `dag.png`. These are logs, reports, and visualizations of the workflow that was executed.
