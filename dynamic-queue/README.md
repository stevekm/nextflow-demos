# Dynamic Queue

A demonstration of using dynamic directives to determine the best queue to submit each task to. Intended to be used with HPC clusters; this example is configured by default to submit to SLURM but can easily be modified for other job schedulers.

In this example, several conditions are evaluated in order to determine the "best" queue to use for each task, in the following order:

1. The presence of a valid `--queue` value passed on the command line

2. If a JSON file `queue.json` exists and contains a key `best_queue`, that value will be used instead

3. If neither of those conditions are valid, then a default queue will be used

The purpose of this is to allow for load balancing for better job execution performance on the cluster. By reading in the cluster status from a file instead of it also prevents the system from being strained by numerous `sinfo`, etc., queries in a rapid time frame. It also allows the end user to determine their own criteria for determining the "best queue" to use based on current cluster resources. The `queue.json` file can be updated at regular intervals by a dedicated external process (e.g. every 15 minutes), such as with the simple [queue-stats](https://github.com/NYU-Molecular-Pathology/queue-stats) program for SLURM.

# Usage

```
$ make run
./nextflow run main.nf
N E X T F L O W  ~  version 19.01.0
Launching `main.nf` [condescending_shirley] - revision: eeaca9ba76
[warm up] executor > slurm
[7e/696824] Submitted process > run (22)
[7f/fd22f8] Submitted process > run (14)
[de/2927a3] Submitted process > run (20)
[03/a871a6] Submitted process > run (18)
[82/013e30] Submitted process > run (31)
[9c/bb88d9] Submitted process > run (25)
[af/62ea4b] Submitted process > run (7)
[69/6ff371] Submitted process > run (36)
[bf/65eec1] Submitted process > run (21)
[ff/9b09f1] Submitted process > run (24)
[b6/9d2c76] Submitted process > run (23)
[7c/97cee0] Submitted process > run (38)
...
...
...
```

Some job parameters are collected in the file `output.txt`

```
$ head output.txt
SLURM_JOB_ID: 937171	SLURM_JOB_NAME: nf-run_(58)	SLURM_JOB_PARTITION: cpu_medium
SLURM_JOB_ID: 937142	SLURM_JOB_NAME: nf-run_(19)	SLURM_JOB_PARTITION: cpu_medium
SLURM_JOB_ID: 937205	SLURM_JOB_NAME: nf-run_(64)	SLURM_JOB_PARTITION: cpu_medium
SLURM_JOB_ID: 937220	SLURM_JOB_NAME: nf-run_(84)	SLURM_JOB_PARTITION: cpu_medium
SLURM_JOB_ID: 937128	SLURM_JOB_NAME: nf-run_(31)	SLURM_JOB_PARTITION: cpu_medium
```

A log of the dynamic queue evaluation process is saved to `queue.log`

```
$ tail queue.log
[2019-01-25 10:46:29] [2] [run] [d1/44f9ae] cpu_medium
[2019-01-25 10:46:29] [2] [run] [f1/77b9db] cpu_medium
[2019-01-25 10:46:29] [2] [run] [09/49338a] cpu_medium
[2019-01-25 10:46:29] [2] [run] [85/50450a] cpu_medium
```

The queue to use can be passed on the command line, overriding the JSON and default values

```
$ ./nextflow run main.nf --queue cpu_dev
N E X T F L O W  ~  version 19.01.0
Launching `main.nf` [awesome_chandrasekhar] - revision: eeaca9ba76
[warm up] executor > slurm
[11/73c409] Submitted process > run (37)
[e4/9d7178] Submitted process > run (3)
[b7/2cbce8] Submitted process > run (34)
[5f/a54d50] Submitted process > run (2)
...
...

$ tail queue.log
[2019-01-25 10:48:48] [1] [run] [86/02dc43] cpu_dev
[2019-01-25 10:48:48] [1] [run] [2e/cc9c2b] cpu_dev
[2019-01-25 10:48:48] [1] [run] [69/817d68] cpu_dev
[2019-01-25 10:48:48] [1] [run] [fa/47d85c] cpu_dev
```
