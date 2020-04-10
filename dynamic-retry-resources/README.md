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
Launching `main.nf` [reverent_kalam] - revision: f045ab05e7
executor >  local (3)
[ae/6d65a8] process > run_task (3) [100%] 3 of 3, failed: 2 ✔
task.attempt: 3
task.memory: 3 GB
task.time: 30m

[fd/14e80a] NOTE: Process `run_task (1)` terminated with an error exit status (1) -- Execution is retried (1)
[5d/6d0289] NOTE: Process `run_task (2)` terminated with an error exit status (1) -- Execution is retried (2)
```

Try passing different combinations of resource allocations from the command line.

```
$ ./nextflow run main.nf --memory 1.2MB --time 2m10s --maxRetries 2
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [chaotic_mahavira] - revision: f045ab05e7
executor >  local (2)
[8e/cb5cf1] process > run_task (2) [100%] 2 of 2, failed: 1 ✔
task.attempt: 2
task.memory: 2.4 MB
task.time: 4m 20s

[b1/3548bb] NOTE: Process `run_task (1)` terminated with an error exit status (1) -- Execution is retried (1)


$ ./nextflow run main.nf --memory 3GB --time 1h13m --maxRetries 3
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [nasty_brattain] - revision: f045ab05e7
executor >  local (3)
[3b/78beb7] process > run_task (3) [100%] 3 of 3, failed: 2 ✔
task.attempt: 3
task.memory: 9 GB
task.time: 3h 39m

[ce/378b10] NOTE: Process `run_task (1)` terminated with an error exit status (1) -- Execution is retried (1)
[8d/33c9d2] NOTE: Process `run_task (2)` terminated with an error exit status (1) -- Execution is retried (2)
```

# References

Examples of valid memory unit notation: https://github.com/nextflow-io/nextflow/blob/6f18745e364c5c6648ab712ae67716938bb0e257/modules/nf-commons/src/test/nextflow/util/MemoryUnitTest.groovy

Examples of valid time unit notaion: https://github.com/nextflow-io/nextflow/blob/6f18745e364c5c6648ab712ae67716938bb0e257/modules/nf-commons/src/test/nextflow/util/DurationTest.groovy
