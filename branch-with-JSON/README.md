# branch with JSON

Demo of using the [`branch`](https://www.nextflow.io/docs/latest/operator.html#branch) operator with JSON parsing to conditionally select Channels to send files through.

This demo uses pairs of files as input. It will then run a simple `diff` command on each file pair. Inside a bash Nextflow process, the results of the `diff` will be evaluated ("pass" or "fail") and saved to a JSON file. This JSON file will then be passed as process output, and parsed inside a Nextflow Channel. After parsing the JSON into a Groovy map object, the pass/fail values can be retrieved inside Nextflow and utilized for conditional path branching inside the channel, optionally sending passed files downstream for more processing, while failed files get saved to a log file.

## Usage

In this example, files `file1_R1.txt` and `file1_R2.txt` are identical and will pass the diff check and be sent to the `USE_FILE` downstream process. Files `file2_R1.txt` and `file2_R2.txt` fail the diff test, and get logged to the file `failed.log`

```
$ nextflow run main.nf
N E X T F L O W  ~  version 23.04.1
Launching `main.nf` [jolly_jones] DSL2 - revision: 4ef954b80e
executor >  local (3)
[7f/9602e0] process > DIFF (1)     [100%] 2 of 2 ✔
[8a/1e9276] process > USE_FILE (1) [100%] 1 of 1 ✔
>>> USE_FILE: file1_R1.txt file1_R2.txt

$ cat failed.log
file2_R1.txt file2_R2.txt
```