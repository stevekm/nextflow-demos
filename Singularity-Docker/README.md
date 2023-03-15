# Singularity, Docker, and conda demo

Demonstration on how to use conda inside of a Docker or Singularity container for use within a Nextflow workflow.

#### Build the Docker container

```
$ docker build -t nf-demo .
```

#### Build the Singularity container

```
$ singularity build container.sif container.def
```

- the arg `--fakeroot` might be needed

#### Build the Singularity cointainer on a system that does not have Singularity installed

For example, on your local computer, using Docker

```
$ docker run --privileged --workdir $PWD --volume $PWD:$PWD --rm -ti quay.io/singularity/singularity:v3.11.0 build container.sif container.def
```

- the default `ENTRYPOINT` for the `quay.io/singularity/singularity` container is `singularity` (you can change this at runtime with the Docker arg `--entrypoint bash` if needed)

- note that the `docker run` arg `--platform linux/amd64` might be required and/or the `singularity build` args `--no-https` and `--arch amd64`

- the `--privileged` arg is used to deal with the Singularity error that results in;

`ERROR  : Failed to create user namespace: user namespace requires to set /proc/sys/kernel/unprivileged_userns_clone to 1`

##### Check that the Singularity container works

```
$ docker run --privileged --workdir $PWD --volume $PWD:$PWD --rm -ti quay.io/singularity/singularity:v3.11.0 exec container.sif bash -c 'which R; Rscript -e "library(ggplot2); print(.libPaths())"; echo $?'
```

## Run the workflow

```
$ nextflow run main.nf

$ nextflow run -profile docker main.nf

$ nextflow run -profile singularity main.nf
```

# Resources

- https://uwekorn.com/2021/03/01/deploying-conda-environments-in-docker-how-to-do-it-right.html
- https://pythonspeed.com/articles/activate-conda-dockerfile/
