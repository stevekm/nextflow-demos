# nextflow-demos

*NOTE*: Some of the techniques demonstrated here may be deprecated by the new [DSL2](https://www.nextflow.io/docs/latest/dsl2.html) syntax offered by Nextflow. Be sure to check that out as well. Many of these examples were written prior to the development of new Nextflow programming syntaxes and techniques and prior to the deprication of some old ones. At this point there are too many examples for me to go back and update everything so I will likely leave things as-is until I need to revisit an old method for myself.

*NOTE*: This is not an official Nextflow documentation repo, this is just my personal collection of code snippets to use in Nextflow workflows. Be sure to see the links to the official Nextflow resources listed at the bottom of this page and listed here.

This repository contains demonstrations of various programming techniques for use inside [Nextflow](https://www.nextflow.io/) pipelines. This repository is meant to be a supplement to the [official Nextflow documentation](https://www.nextflow.io/docs/latest/getstarted.html) (links below).

- an overview presentation about Nextflow can be found [here](https://github.com/stevekm/nextflow-demos/blob/docs/docs/Nextflow_presentation.pdf) (view [here](https://docs.google.com/viewer?url=https://raw.githubusercontent.com/stevekm/nextflow-demos/docs/docs/Nextflow_presentation.pdf))

- example Nextflow HTML report examples can be found here:

    - [pipeline report](https://htmlpreview.github.io/?https://github.com/stevekm/nextflow-demos/blob/report-output/reporting/nextflow-report.html)

    - [timeline report](https://htmlpreview.github.io/?https://github.com/stevekm/nextflow-demos/blob/report-output/reporting/timeline-report.html)

# Install

Clone this repo:

```bash
git clone git@github.com:stevekm/nextflow-demos.git
cd nextflow-demos
```

These days, I usually use the included `environment.yml` file to create a `conda` environment to install Nextflow into for general use. If you would like to use this env, please read the description inside the file carefully since usage of some included `bioconda` packages requires specific commands to be run in a specific order for conda to easily resolve the package installs.

Once you have Nextflow installed (either via the [official](https://www.nextflow.io/) methods or via conda, etc.) then you can run most included pipeline demo's with a command like

```
nextflow run main.nf
```

Unless otherwise noted in the demos' included README files. 

You can also view the contents of included Makefiles to see other run commands and args that might be used, though I no longer actually use the Makefiles myself for workflow execution. Newer demo's will likely not include a Makefile and will just utilize `nextflow run` or other commands listed in the README.

# Contents

Each subdirectory contains files to run sample Nextflow pipelines.

## Files

- `main.nf`: Nextflow pipeline file

- `nextflow.config`: config file for Nextflow pipeline (optional)

- `README.md`: notes on the pipeline description and execution 

- `Makefile`: shortcut to commands to install and clean up Nextflow and its pipeline output (run the included recipes with a command like `make run`, `make clean`, etc.)

## Sample Pipeline Directories

(listed in recommended order for new users)

- `print-samples`: Prints samples from a list to the terminal

- `make-files`: Creates files based on sample ID inputs

- `output-files`: Same as `make-files` but includes custom file output options

- `async`: demonstration of asynchronous process execution

- `custom-email-output`: Creates files from sample ID's then sends the user an email with a pipeline summary and files attached

- `output-variable-name`: Same as `output-files` but includes inline variable definition of output file names

- `R-Python`: methods for using other scripting languages inside the Nextflow pipeline

- `join-pairs`: joining pairs of samples based on ID across input channels

- `parse-samplesheet`: parsing of a samplesheet as input for Nextflow pipeline

- `reporting`: execution of Nextflow pipeline with reporting and config features enabled.

- `profiles-Docker-module`: usage of 'profiles' to change process execution behavior to use Docker or environment modules

- `Groovy-code`: example of using inline Groovy code inside the Nextflow pipeline

## Extras

- `nf-clean.sh`: helper script to clean up Nextflow outputs (if for some reason you dont want to use [`nextflow clean`](https://www.nextflow.io/docs/latest/cli.html#clean) )
- `environment.yml`: helper conda env recipe to install Nextflow, read the included notes carefully to make sure the `bioconda` packages install correctly
- `r-base.4.1.yml`: conda env recipe for a basic R installation, since so many Nf pipelines end up including R scripts that need debugging too, its just easier to bundle it here as well

# Resources

- Nextflow Homepage: https://www.nextflow.io/

- Nextflow Docs: https://www.nextflow.io/docs/latest/getstarted.html

- Nextflow Patterns: https://nextflow-io.github.io/patterns/index.html

- Nextflow GitHub: https://github.com/nextflow-io/nextflow

- Nextflow Google Group: https://groups.google.com/forum/#!forum/nextflow

- nf-core Nextflow community pipelines, docs, and more; https://nf-co.re/ 

- for help with Nextflow consider some of the following avenues (in no particular order);
  - Nextflow community Slack https://www.nextflow.io/slack-invite.html
  - nf-core community Slack https://nf-co.re/join
  - Stack Overflow `nextflow` tag https://stackoverflow.com/questions/tagged/nextflow
  - BioStars https://www.biostars.org/

## Examples

- Nextflow tutorial: https://github.com/nextflow-io/hack17-tutorial

- Nextflow examples: https://github.com/nextflow-io/examples

- Pipeline examples: https://github.com/nextflow-io/awesome-nextflow

- NYU pipelines:

    - exome sequencing: https://github.com/NYU-Molecular-Pathology/NGS580-nf

    - demultiplexing: https://github.com/NYU-Molecular-Pathology/demux-nf
