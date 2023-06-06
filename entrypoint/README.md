# entrypoint

Demo of using named entrypoints to run different sets of sub workflows

## Usage

```
# run the default entrypoint
$ nextflow run main.nf

# run a different named entrypoint
$ nextflow run main.nf -entry run_one
```