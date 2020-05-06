# `bin` Directory  Usage with Containers & Debugging

This directory contains a simple demonstration of using custom scripts in the `bin` directory inside your Nextflow pipeline.

If a directory named `bin` is adjacent to your Nextflow script (e.g. `main.nf` in this example), it will be automatically prepended to the `PATH` inside your Nextflow tasks.

Additionally, it will be made available inside any container from which your task may be executing.

This demo uses the `python:3` Docker container to execute a custom script, `bin/divide.py`, on a series of values. One set of values results in a divide by zero error.

The error can be fixed by simply updating the `divide.py` script to use a `try/except` to catch the error.

In this way, we can easily debug custom scripts used in a Nextflow pipeline without having to rebuild the container image that holds their runtime requirements.

# Usage

- NOTE: Docker should be installed and running. The Docker container `python:3` will be used.

Install Nextflow;

```
$ curl -fsSL get.nextflow.io | bash
```

Run the workflow

```
$ ./nextflow run main.nf
N E X T F L O W  ~  version 20.04.1
Launching `main.nf` [nice_hugle] - revision: ddec5bc54a
~~~~~ Starting Workflow ~~~~~
values_list: [[3, 2], [4, 2], [1, 0]]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
executor >  local (3)
[80/3d36fc] process > divide (1) [100%] 2 of 2, failed: 1
numerator: 4.0, denominator: 2.0, result: 2.0

WARN: Killing pending tasks (1)
Error executing process > 'divide (3)'

Caused by:
  Process `divide (3)` terminated with an error exit status (1)

Command executed:

  divide.py "1" "0"

Command exit status:
  1

Command output:
  (empty)

Command error:
  Traceback (most recent call last):
    File "/Users/steve/projects/nextflow-demos/bin-dir-container-debugging/bin/divide.py", line 12, in <module>
      result = numerator / denominator
  ZeroDivisionError: float division by zero

Work dir:
  /Users/steve/projects/nextflow-demos/bin-dir-container-debugging/work/b3/dda1df96c554b5df36515cb8ef2dd0

Tip: you can try to figure out what's wrong by changing to the process work dir and showing the script file named `.command.sh`
```

As we can see, the workflow crashed with a divide by zero error in the Python script.

We are able to isolate and reproduce the error by entering the described `work` dir and checking the task execution files.

```
$ cd /Users/steve/projects/nextflow-demos/bin-dir-container-debugging/work/48/5e8bc76fe86cf94e19c79c1ede9497

$ ls -a
.              ..             .command.begin .command.err   .command.log   .command.out   .command.run   .command.sh    .exitcode

```

Here we can see the files that Nextflow uses to execute the task. We can check the task logs:

```
$ cat .command.log
Traceback (most recent call last):
  File "/Users/steve/projects/nextflow-demos/bin-dir-container-debugging/bin/divide.py", line 12, in <module>
    result = numerator / denominator
ZeroDivisionError: float division by zero
```

This shows us the full error message from the task.

We can check the task that was run in `.command.sh`:

```
$ cat .command.sh
#!/bin/bash -ue
divide.py "1" "0"
```

This shows the values that were passed to the `divide.py` script, to remove any ambiguity about what was being executed.

We can try to run the task again to isolate and reproduce the error, using the `.command.run` script which sets up the environment and executes `.command.sh` inside the Docker container

```
$ bash .command.run
Traceback (most recent call last):
  File "/Users/steve/projects/nextflow-demos/bin-dir-container-debugging/bin/divide.py", line 12, in <module>
    result = numerator / denominator
ZeroDivisionError: float division by zero
```

As expected, we see the same error.

Now, we can try to debug the error by editing the original `divide.py` script located in the parent `bin` directory at the top level of the project. In `bin/divide.py`, we can change this line:

```python
result = numerator / denominator
```

to this:

```python
try:
    result = numerator / denominator
except ZeroDivisionError:
    result = "NA"
```

Back in our work directory (`work/48/5e8bc76fe86cf94e19c79c1ede9497`) we can try to execute the task again

```
$ cd /Users/steve/projects/nextflow-demos/bin-dir-container-debugging/work/48/5e8bc76fe86cf94e19c79c1ede9497

$ bash .command.run
numerator: 1.0, denominator: 0.0, result: NA
```

We now see the correct result, without errors. We can go back to the parent project directory and try to run the workflow again. This time, we can also include the `-resume` flag in order to tell Nextflow to resume the workflow from where it left off.

```
$ ./nextflow run main.nf -resume
N E X T F L O W  ~  version 20.04.1
Launching `main.nf` [romantic_ampere] - revision: ddec5bc54a
~~~~~ Starting Workflow ~~~~~
values_list: [[3, 2], [4, 2], [1, 0]]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
executor >  local (3)
[5a/24f28d] process > divide (1) [100%] 3 of 3 ✔
numerator: 1.0, denominator: 0.0, result: NA

numerator: 4.0, denominator: 2.0, result: 2.0

numerator: 3.0, denominator: 2.0, result: 1.5

```

Now the pipeline completes successfully.
