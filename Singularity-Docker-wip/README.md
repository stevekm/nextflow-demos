

```
docker run --platform linux/amd64 --workdir $PWD --volume $PWD:$PWD --rm -ti quay.io/singularity/singularity:v3.11.0 pull --no-https --arch amd64 container.sif docker://continuumio/miniconda3:4.7.12

docker run --entrypoint bash --platform linux/amd64 --workdir $PWD --volume $PWD:$PWD --rm -ti quay.io/singularity/singularity:v3.11.0


docker run --platform linux/amd64 --workdir $PWD --volume $PWD:$PWD --rm -ti quay.io/singularity/singularity:v3.11.0 build container.sif container.def

docker run --platform linux/amd64 --rm -ti continuumio/miniconda3:4.7.12  bash

conda install -c bioconda bioconductor-deseq2
```