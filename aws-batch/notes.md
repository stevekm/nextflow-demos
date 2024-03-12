```groovy
// setup for EC2
// use ECS base image that has Docker already installed
// sudo yum update -y
// sudo yum install -y htop bzip2 wget curl unzip zip screen git make

// wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
// bash Miniconda3-latest-Linux-x86_64.sh -b -f -p $HOME/miniconda
// $HOME/miniconda/bin/conda install -c conda-forge -y awscli

// curl -s "https://get.sdkman.io" | bash
// /home/ec2-user/.sdkman/libexec/version: /lib64/libc.so.6: version `GLIBC_2.28' not found (required by /home/ec2-user/.sdkman/libexec/version)

//java-1.8.0-openjdk is available for EC2 Amaon Linux 2 but its not updated enough for Nextflow...
```