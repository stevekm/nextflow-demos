install Mamba into a currently existing conda

https://stackoverflow.com/questions/76760906/installing-mamba-on-a-machine-with-conda

- must be using Miniconda, NOT Anaconda

- must install into conda base env

```bash
## prioritize 'conda-forge' channel
conda config --add channels conda-forge

## update existing packages to use 'conda-forge' channel
conda update -n base --all

## install 'mamba'
conda install -n base mamba

```


official docs

https://mamba.readthedocs.io/en/latest/installation/mamba-installation.html
https://github.com/conda-forge/miniforge
