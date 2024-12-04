# module binaries

Demonstration of usage of module-specific `bin` dir for including scripts with a module.

- docs: https://www.nextflow.io/docs/latest/module.html#module-binaries

- Issue: https://github.com/nextflow-io/nextflow/issues/5204

## Usage

```
$ nextflow run main.nf
Nextflow 24.10.2 is available - Please consider updating your version to it

 N E X T F L O W   ~  version 24.04.4

Launching `main.nf` [admiring_laplace] DSL2 - revision: 362880aa6f

executor >  local (4)
[19/f33ba0] FOO                [100%] 1 of 1 ✔
[df/e53776] BAR                [100%] 1 of 1 ✔
[56/ab686c] BAZ                [100%] 1 of 1 ✔
[c0/8a8f3b] BUZZ (shouldBreak) [100%] 1 of 1, failed: 1 ✔
this is foo nextflow process

this is baz.sh inside BAZ process
this is bar.sh script inside BAZ process

this is bar.sh script inside BAR process

[c0/8a8f3b] NOTE: Process `BUZZ (shouldBreak)` terminated with an error exit status (127) -- Error is ignored

```