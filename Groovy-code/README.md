# Groovy code

A demo of using Groovy code inside a Nextflow pipeline.

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make install
./nextflow run main.nf
```

## Output

Output should look like this:

```
$ ./nextflow run main.nf
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [compassionate_booth] - revision: 08e9789019
[username] kellys04
[localhostname] acc38pathlabmac01
[timestamp] 2018-04-17_09-42-21
[current_dir_path] /Users/kellys04/projects/nextflow-demos/Groovy-code
```

A passed param can also be user to override the default value:

```
$ ./nextflow run main.nf  --username fooooo
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [tender_watson] - revision: 08e9789019
[username] fooooo
[localhostname] acc38pathlabmac01
[timestamp] 2018-04-17_09-43-08
[current_dir_path] /Users/kellys04/projects/nextflow-demos/Groovy-code
```
