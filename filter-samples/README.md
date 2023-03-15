# Filter Samples Workflow

This directory contains a demonstration of filtering out "bad" samples from a workflow. It also includes conditional workflow task resolution based on input parameters.

The workflow will start with four samples; `Sample1`, `Sample2`, `Sample3`, `Sample4`. Each sample starts with an associated value of 1, 2, 3, and 4, respectively.

The workflow will have two modes of execution using the `archiveType` of `zip` (default) or `tar`.

The samples will be passed through the workflow tasks, where a custom data file will be generated for each one. Samples with too few lines will be removed from the workflow. Samples that break at a failure-prone step in the workflow will be ignored.

If the execution mode of `zip` is used, messages will be archived in .zip files, while if message type of `tar` is chosen, messages will be archived in .tar.gz files.

The archives from all samples will be collected and printed to console at the final step of the pipeline.

# Usage

The included Makefile has the required command to install Nextflow and run the workflow wrapped up for convenience:

```
$ make run
export NXF_VER="20.01.0" && \
	curl -fsSL get.nextflow.io | bash

      N E X T F L O W
      version 20.01.0 build 5264
      created 12-02-2020 10:14 UTC (05:14 EDT)
      cite doi:10.1038/nbt.3820
      http://nextflow.io


Nextflow installation completed. Please note:
- the executable file `nextflow` has been created in the folder: /Users/steve/projects/nextflow-demos/filter-samples
- you may complete the installation by moving it to a directory in your $PATH

./nextflow run main.nf \
	--archiveType "zip" \
	-with-report nextflow.html \
	-with-timeline timeline.html \
	-with-trace trace.txt
N E X T F L O W  ~  version 20.01.0
Launching `main.nf` [infallible_almeida] - revision: dad5e33d8c
~~~~~ Starting Workflow ~~~~~
archiveType: zip
input_samples: [[Sample1, 1], [Sample2, 2], [Sample3, 3], [Sample4, 4]]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
executor >  local (11)
[4c/0dccd0] process > create_file       [100%] 4 of 4 ✔
[87/973b38] process > create_archive    [100%] 3 of 3 ✔
[1a/d42e04] process > please_dont_break [100%] 3 of 3, failed: 1 ✔
[a8/e06dfa] process > gather_files      [100%] 1 of 1 ✔
Got items: [Sample4, /Users/steve/projects/nextflow-demos/filter-samples/work/b2/ac370b708a55a08ae38d0c08f8e966/Sample4.data.txt]


Got items: [Sample3, /Users/steve/projects/nextflow-demos/filter-samples/work/6f/36485fa649e9b6f4ab09c0d45359b2/Sample3.data.txt]

Got items: [Sample1, /Users/steve/projects/nextflow-demos/filter-samples/work/69/8c0354588b7158757d0791c095046c/Sample1.data.txt]

Got items: [Sample2, /Users/steve/projects/nextflow-demos/filter-samples/work/4c/0dccd0135d3d0b92104d4ff7562887/Sample2.data.txt]


Last step in the workflow! Got these zip files:
Sample4.message.zip Sample3.message.zip

WARN: Task runtime metrics are not reported when using macOS without a container engine
WARN: File for Sample1 has too few lines and will be removed
[3d/a5b70a] NOTE: Process `please_dont_break (Sample2)` terminated with an error exit status (1) -- Error is ignored
```

Files of type .zip were created and passed through the pipeline. We can see that `Sample1` was removed from the workflow for having too few lines in its data file. On the other hand, `Sample2` broke during execution of the `please_dont_break` task, and was the error was ignored allowing the workflow to complete without it. Only `Sample3` and `Sample4` made it to the end of the workflow.

Also included in this command is output of the Nextflow HTML report (`nextflow.html`) and task execution timeline reports (`timeline.html`), along with task trace file (`trace.txt`).

To run the workflow in `tar` mode you can run the command with the alternate `archiveType` value:

```
$ ./nextflow run main.nf --archiveType tar
N E X T F L O W  ~  version 20.01.0
Launching `main.nf` [tender_wescoff] - revision: dad5e33d8c
~~~~~ Starting Workflow ~~~~~
archiveType: tar
input_samples: [[Sample1, 1], [Sample2, 2], [Sample3, 3], [Sample4, 4]]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
executor >  local (11)
[7a/202f55] process > create_file       [100%] 4 of 4 ✔
[a3/cd990c] process > create_archive    [100%] 3 of 3 ✔
[9d/704d06] process > please_dont_break [100%] 3 of 3, failed: 1 ✔
[6f/582eee] process > gather_files      [100%] 1 of 1 ✔
Got items: [Sample1, /Users/steve/projects/nextflow-demos/filter-samples/work/c6/034d82e1b2a3472713cb56e73f7b0e/Sample1.data.txt]


Got items: [Sample3, /Users/steve/projects/nextflow-demos/filter-samples/work/48/c947824de92acac1d1e4ba6e1211f3/Sample3.data.txt]

Got items: [Sample4, /Users/steve/projects/nextflow-demos/filter-samples/work/0b/283038a5802829770142f0c3c03b33/Sample4.data.txt]

Got items: [Sample2, /Users/steve/projects/nextflow-demos/filter-samples/work/7a/202f55b076d856ae72b1d851534a16/Sample2.data.txt]


Last step in the workflow! Got these tar files:
Sample4.message.tar.gz Sample3.message.tar.gz

WARN: File for Sample1 has too few lines and will be removed
[f3/bac272] NOTE: Process `please_dont_break (Sample2)` terminated with an error exit status (1) -- Error is ignored
```

In this case, files of type `.tar.gz` were created and passed through the pipeline.
