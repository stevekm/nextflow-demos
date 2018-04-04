# nextflow-demos

Demonstrations of various programming techniques for use inside Nextflow pipelines. 

# Install

Clone this repo:

```bash
git clone git@github.com:stevekm/nextflow-demos.git
cd nextflow-demos
```

# Contents

Each subdirectory contains files to run sample Nextflow pipelines.

## Files

- `Makefile`: shortcut to commands to install and clean up Nextflow and its pipeline output

- `main.nf`: Nextflow pipeline file

- `nextflow.config`: config file for Nextflow pipeline (optional)

## Sample Pipeline Directories

- `print-samples`: Prints samples from a list to the terminal

- `make-files`: Creates files based on sample ID inputs

- `output-files`: Same as `make-files` but includes custom file output options

- `custom-email-output`: Creates files from sample ID's then sends the user an email with a pipeline summary and files attached

- `output-variable-name`: Same as `output-files` but includes inline variable definition of output file names

- `R-Python`: methods for using other scripting languages inside the Nextflow pipeline

- `join-pairs`: joining pairs of samples based on ID across input channels

- `parse-samplesheet`: parsing of a samplesheet as input for Nextflow pipeline

# Usage

## Install Nextflow

```
# in a subdir in this repo
make
```

## Run pipeline

```
./nextflow run main.nf
```

or

```
make run
```

## Cleanup

```
make clean
```

# Resources

- Nextflow Homepage: https://www.nextflow.io/

- Nextflow Docs: https://www.nextflow.io/docs/latest/getstarted.html

- Nextflow GitHub: https://github.com/nextflow-io/nextflow

- Nextflow Google Group: https://groups.google.com/forum/#!forum/nextflow

## Examples

- Nextflow tutorial: https://github.com/nextflow-io/hack17-tutorial

- Nextflow examples: https://github.com/nextflow-io/examples

- Pipeline examples: https://github.com/nextflow-io/awesome-nextflow

- NYU pipelines:

    - exome sequencing: https://github.com/NYU-Molecular-Pathology/NGS580-nf

    - demultiplexing: https://github.com/NYU-Molecular-Pathology/demux-nf
