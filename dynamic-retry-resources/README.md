# Dynamic Resource Allocation on Task Retry

This demonstration shows how to use dynamic directives to retry a failed tasks with a greater resource allocation. It also shows how to pass in the starting values for these resource allocations from the command line.

## Usage

Install Nextflow:

```
export NXF_VER:=19.10.0
curl -fsSL get.nextflow.io | bash
```

Run the workflow with default allocations; it should start with 1GB memory and 10 minute time limit, and retry for 3 attempts, printing the final resource allocation on the last attempt.

```
$ ./nextflow run main.nf
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [desperate_pike] - revision: 0c2d572de9
~~~~ Starting Workflow Configuration ~~~~~
memory: 1GB
time: 10m
maxRetries: 3
errorStrategy: retry
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
executor >  local (3)
[e0/80d7f7] process > run_task (attempt 3) [100%] 3 of 3, failed: 2 ✔
task.attempt: 3
task.memory: 3 GB
task.time: 30m

[ae/bea054] NOTE: Process `run_task (attempt 1)` terminated with an error exit status (1) -- Execution is retried (1)
[51/b25db4] NOTE: Process `run_task (attempt 2)` terminated with an error exit status (1) -- Execution is retried (2)
```

Try passing different combinations of resource allocations from the command line.

```
$ ./nextflow run main.nf --memory 1.2MB --time 2m10s --maxRetries 2
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [gigantic_baekeland] - revision: 0c2d572de9
~~~~ Starting Workflow Configuration ~~~~~
memory: 1.2MB
time: 2m10s
maxRetries: 2
errorStrategy: retry
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
executor >  local (2)
[8e/834dea] process > run_task (attempt 2) [100%] 2 of 2, failed: 1 ✔
task.attempt: 2
task.memory: 2.4 MB
task.time: 4m 20s

[00/8c6c6d] NOTE: Process `run_task (attempt 1)` terminated with an error exit status (1) -- Execution is retried (1)


$ ./nextflow run main.nf --memory 3GB --time 1h13m --maxRetries 3
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [determined_bernard] - revision: 0c2d572de9
~~~~ Starting Workflow Configuration ~~~~~
memory: 3GB
time: 1h13m
maxRetries: 3
errorStrategy: retry
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
executor >  local (3)
[84/51ad00] process > run_task (attempt 3) [100%] 3 of 3, failed: 2 ✔
task.attempt: 3
task.memory: 9 GB
task.time: 3h 39m

[74/adaac9] NOTE: Process `run_task (attempt 1)` terminated with an error exit status (1) -- Execution is retried (1)
[52/1f556a] NOTE: Process `run_task (attempt 2)` terminated with an error exit status (1) -- Execution is retried (2)
```

# References

Examples of valid memory unit notation: https://github.com/nextflow-io/nextflow/blob/6f18745e364c5c6648ab712ae67716938bb0e257/modules/nf-commons/src/test/nextflow/util/MemoryUnitTest.groovy

Examples of valid time unit notaion: https://github.com/nextflow-io/nextflow/blob/6f18745e364c5c6648ab712ae67716938bb0e257/modules/nf-commons/src/test/nextflow/util/DurationTest.groovy
