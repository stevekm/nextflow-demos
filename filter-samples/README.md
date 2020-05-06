# Filter Samples Workflow

This directory contains a demonstration of filtering out "bad" samples from a workflow. It also includes conditional workflow task resolution.

The workflow will start four samples; `Sample1`, `Sample2`, `Sample3`, `Sample4`.

The workflow will have two modes of execution using the `archiveType` of `zip` (default) or `tar`.

The samples will be passed through the workflow tasks, where a custom message will be generated for each one. Samples that are determined to be "bad" will be removed during workflow execution. If the execution mode of `zip` is used, messages will be archived in .zip files, while if message type of `tar` is chosen, messages will be archived in .tar.gz files.

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
- the executable file `nextflow` has been created in the folder: /Users/kellys5/projects/nextflow-demos/filter-samples
- you may complete the installation by moving it to a directory in your $PATH

./nextflow run main.nf \
	--archiveType "zip" \
	-with-report nextflow.html \
	-with-timeline timeline.html \
	-with-trace trace.txt
N E X T F L O W  ~  version 20.01.0
Launching `main.nf` [gigantic_ampere] - revision: 3d72244b61
executor >  local (15)
[a1/32d80f] process > create_message    [100%] 4 of 4 ✔
[7b/17e7da] process > print_message     [100%] 4 of 4 ✔
[46/2805e3] process > create_archive    [100%] 3 of 3 ✔
[a9/ac1ec2] process > please_dont_break [100%] 3 of 3, failed: 1 ✔
[71/07f18a] process > gather_files      [100%] 1 of 1 ✔
Got message for Sample2: Sample2 says: Hello World

Got message for Sample1: Sample1 says: Hello World

Got message for Sample4: Sample4 says: Hello World

Got message for Sample3: Sample3 says: Hello World

WARNING: bad sample was filtered out from downstream processing: Sample4


Last step in the workflow! Got these zip files:
Sample1.message.zip Sample3.message.zip

WARN: Task runtime metrics are not reported when using macOS without a container engine
[a9/ac1ec2] NOTE: Process `please_dont_break (Sample2)` terminated with an error exit status (1) -- Error is ignored
```

Files of type .zip were created and passed through the pipeline.

Also included in this command is output of the Nextflow HTML report (`nextflow.html`) and task execution timeline reports (`timeline.html`), along with task trace file (`trace.txt`).

To run the workflow in `tar` mode you can run the command with the alternate `archiveType` value:

```
$ ./nextflow run main.nf --archiveType tar
N E X T F L O W  ~  version 20.01.0
Launching `main.nf` [distracted_bartik] - revision: 3d72244b61
executor >  local (15)
[b5/c3f9a2] process > create_message    [100%] 4 of 4 ✔
[b6/2fd289] process > print_message     [100%] 4 of 4 ✔
[c9/50a050] process > create_archive    [100%] 3 of 3 ✔
[85/730985] process > please_dont_break [100%] 3 of 3, failed: 1 ✔
[8a/d7dee3] process > gather_files      [100%] 1 of 1 ✔
Got message for Sample4: Sample4 says: Hello World

Got message for Sample2: Sample2 says: Hello World

WARNING: bad sample was filtered out from downstream processing: Sample4
Got message for Sample1: Sample1 says: Hello World

Got message for Sample3: Sample3 says: Hello World



Last step in the workflow! Got these tar files:
Sample1.message.tar.gz Sample3.message.tar.gz

[3a/efd271] NOTE: Process `please_dont_break (Sample2)` terminated with an error exit status (1) -- Error is ignored
```

In this case, files of type `.tar.gz` were created and passed through the pipeline.

In both cases, we can see that `Sample4` was detected as being "bad" and was removed from the workflow. On the other hand, `Sample2` broke during execution and it was ignored from execution of remaining tasks. Only `Sample1` and `Sample3` made it to the end of the workflow.
