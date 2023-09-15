# Samplesheet Input - JSON vs CSV

Demo of pipeline input from both JSON and .csv format samplesheets.

A common method of supplying input data to a Nextflow pipeline is via a .csv formatted samplesheet, where each row represents one sample and each column represents an attribute associated with the sample.

Nextflow also has built-in JSON input parsing via the `-params-file` command line argument. A supplied input JSON file in the form of a map object will automatically populate the attributes of the implicit Nextflow `params`. We can use this to supply the same sample data input that would have been stored in a .csv samplesheet.

There are advantages and disadvantages of both formats and methods.

#### CSV

Pros:

- easier to write by hand in text editor, or exported from Microsoft Excel
- plays a little nicer with standard command line tools like `cut`

Cons:

- hard to read if there are large numbers of columns
- all values are strings; no implicit data typing, needs extra parsing in your code to convert values to the correct type
- can only store one table (mapping) per file; if you have multiple mappings, you need multiple files
- raw .csv format can have a lot of discrepancies and edge cases to deal with (carriage returns, quoting, escape characters, comments, etc..)

Example:

- `input.csv` contents:

```
id,type,species,arg1,doBar,file
Sample1,melanoma,human,10,true,data/Sample1.txt
Sample4,adenoma,mouse,25,false,data/Sample4.txt
```

#### JSON

Pros:

- easier to read in some cases (e.g. printed with indentations and many key:value pairs)
- implicit data typing for int's, booleans
- supports list and map objects natively, along with sub-mappings and sub-lists, so you can represent complex data types easily
- can store multiple tables (mappings) in the same object
- its a universal standard format that can be read easily without issues in practically all programming languages (avoids format issues inherent to csv)
- can be more easily converted directly into an object inside your program

Cons:

- can be harder to write by hand and parse with standard tools (need `jq` for easy cli parsing)
- can't be viewed in Excel

Example:

- `input.json` contents:

```
{
    "samples": [
        { "id": "Sample1", "file": "data/Sample1.txt", "type": "melanoma", "species": "human", "arg1": 10, "doBar": true },
        { "id": "Sample4", "file": "data/Sample4.txt", "type": "adenoma", "species": "mouse", "arg1": 25, "doBar": false }
    ],
    "barArgs": [
        "bar1",
        "bar2",
        "bar3"
    ]
}
```

-----

In this example, we show common methods to use either .csv or JSON format as the input to your pipeline.

Our pipeline has two steps, called `FOO` and `BAR`. Task `FOO` will be performed on all input samples, using args supplied per-sample in the samplesheet. Task `BAR` will only be executed for samples who are labeled with the attribute `doBar true` enabled in their samplesheet input. Additionally, the task `BAR` will be repeated for every arg that is passed in to the list `barArgs`. This list `barArgs` is supplied natively in the JSON input format, however when using the .csv input an additional file is supplied for this via the arg `--barArgsTxt`.

# Usage

Run the workflow using the JSON input;

```
$ nextflow run main.nf -params-file input.json
N E X T F L O W  ~  version 23.04.1
Launching `main.nf` [golden_bhabha] DSL2 - revision: c44265d3dd
executor >  local (5)
[ab/84c0c8] process > FOO (Sample1)        [100%] 2 of 2 ✔
[52/82479b] process > BAR (Sample1 - bar2) [100%] 3 of 3 ✔
>>> FOO: arg:25, Sample: Sample4, file: Sample4.txt

>>> FOO: arg:10, Sample: Sample1, file: Sample1.txt

>>> BAR: arg:bar1, Sample: Sample1, file: Sample1.txt

>>> BAR: arg:bar3, Sample: Sample1, file: Sample1.txt

>>> BAR: arg:bar2, Sample: Sample1, file: Sample1.txt
```

Run the workflow with .csv input and supplemental args file;

```
$ nextflow run main.nf --inputCsv input.csv --barArgsTxt barArgs.txt
N E X T F L O W  ~  version 23.04.1
Launching `main.nf` [hungry_curran] DSL2 - revision: c44265d3dd
executor >  local (5)
[5a/47c15f] process > FOO (Sample1)        [100%] 2 of 2 ✔
[33/dd77c0] process > BAR (Sample1 - bar2) [100%] 3 of 3 ✔
>>> BAR: arg:bar3, Sample: Sample1, file: Sample1.txt

>>> FOO: arg:25, Sample: Sample4, file: Sample4.txt

>>> BAR: arg:bar1, Sample: Sample1, file: Sample1.txt

>>> BAR: arg:bar2, Sample: Sample1, file: Sample1.txt

>>> FOO: arg:10, Sample: Sample1, file: Sample1.txt
```

# Conclusions

If possible, it is preferable to utilize JSON input with `-params-file` for Nextflow sample input, for several reasons;

- it allows you to set all `params` values in the pipeline at once, instead of needing to specify numerous cli args to your pipeline. Compare

```
nextflow run main.nf -params-file input.json
```

to

```
nextflow run main.nf --samplesheet samples.csv --arg1 foo --arg2 bar --arg3 bazz ...
```

- it allows you to skip text-parsing of your input samplesheet contents

- it allows you to input more complex data structures as input to your pipeline, such as nested sub-mappings per sample

- it allows you to input data from multiple sources at once, instead of requiring multiple individual samplesheet inputs

- if your pipeline is being launched by an external orchestrator, it simplifies the data serialization needed to create your pipeline input file

However you may still utilize .csv format in cases such as

- other users need to be able to view and modify samplesheet data in Excel

- you already have other infrastructure built around .csv files and dont yet want to switch to a different format

Whichever format you choose, you will find sufficient tools in the Nextflow, Groovy, and Java ecosystems to handle your input sample parsing tasks.