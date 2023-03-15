# Default Parameters

A demonstration of using default parameters with Nextflow pipelines.

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

Output should look like this:

```
$ make
./nextflow run main.nf
N E X T F L O W  ~  version 0.31.1
Launching `main.nf` [ridiculous_ampere] - revision: b7cf29d759
WARN: No value provided for arg1, using default: fizz
~~~~~~~~~~~~~~~~~~~~~~~~
default_input :    foo.txt
params.input  :    foo.txt
input         :    foo.txt
arg1_default  :    fizz
params.arg1   :    null
arg1          :    fizz
~~~~~~~~~~~~~~~~~~~~~~~~
```

Extra args can be supplied with `EP`:

```
$ make EP='--input baz'
./nextflow run main.nf --input baz
N E X T F L O W  ~  version 0.31.1
Launching `main.nf` [nasty_lichterman] - revision: b7cf29d759
WARN: No value provided for arg1, using default: fizz
~~~~~~~~~~~~~~~~~~~~~~~~
default_input :    foo.txt
params.input  :    baz
input         :    baz
arg1_default  :    fizz
params.arg1   :    null
arg1          :    fizz
~~~~~~~~~~~~~~~~~~~~~~~~
ERROR ~ Input is not a file or dir: baz

 -- Check '.nextflow.log' file for details
make: *** [run] Error 1
```
