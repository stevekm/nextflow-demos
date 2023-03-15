#### Build the Docker container

```
docker build -t nf-demo .
```

#### Build the Singularity cointainer on a system that does not have Singularity installed

For example, on your local computer, using Docker

```
docker run --privileged --workdir $PWD --volume $PWD:$PWD --rm -ti quay.io/singularity/singularity:v3.11.0 build container.sif container.def
```

- the default `ENTRYPOINT` for the `quay.io/singularity/singularity` container is `singularity`

- note that the `docker run` arg `--platform linux/amd64` might be required and/or the `singularity build` args `--no-https` and `--arch amd64`

- the `--privileged` arg is used to deal with the Singularity error that results in;

`ERROR  : Failed to create user namespace: user namespace requires to set /proc/sys/kernel/unprivileged_userns_clone to 1`

##### Check that the Singularity container works

```
$ docker run --privileged --workdir $PWD --volume $PWD:$PWD --rm -ti quay.io/singularity/singularity:v3.11.0 exec container.sif bash -c 'which R; Rscript -e "library(ggplot2); print(.libPaths())"; echo $?'
```


#### Run the workflow

```
$ nextflow run main.nf

$ nextflow run -profile docker main.nf
```

-----

```
docker run --platform linux/amd64 --workdir $PWD --volume $PWD:$PWD --rm -ti quay.io/singularity/singularity:v3.11.0 pull --no-https --arch amd64 container.sif docker://continuumio/miniconda3:4.7.12

docker run --entrypoint bash --platform linux/amd64 --workdir $PWD --volume $PWD:$PWD --rm -ti quay.io/singularity/singularity:v3.11.0


docker run --platform linux/amd64 --workdir $PWD --volume $PWD:$PWD --rm -ti quay.io/singularity/singularity:v3.11.0 build container.sif container.def

docker run --platform linux/amd64 --rm -ti continuumio/miniconda3:4.7.12  bash

conda install -c bioconda bioconductor-deseq2
```