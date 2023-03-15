# Report output

This demonstration shows how to output HTML reports for your pipeline using Nextflow's built-in output.

- `nextflow.config` includes settings for report and trace output, along with email notification settings

- Nextflow pipeline execution overview and timeline reports;


    - [pipeline report](https://htmlpreview.github.io/?https://github.com/stevekm/nextflow-demos/blob/report-output/reporting/nextflow-report.html)

    - [timeline report](https://htmlpreview.github.io/?https://github.com/stevekm/nextflow-demos/blob/report-output/reporting/timeline-report.html)


## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

The terminal output should look like this:

```
$ make run
export NXF_VER="0.28.0" && \
	curl -fsSL get.nextflow.io | bash

      N E X T F L O W
      version 0.28.0 build 4779
      last modified 10-03-2018 12:13 UTC (07:13 EDT)
      cite doi:10.1038/nbt.3820
      http://nextflow.io


Nextflow installation completed. Please note:
- the executable file `nextflow` has been created in the folder: /Users/kellys04/projects/nextflow-demos/reporting
- you may complete the installation by moving it to a directory in your $PATH

./nextflow run main.nf -with-dag flowchart.dot
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [chaotic_yonath] - revision: 34fd80df2a
[warm up] executor > local
[02/d84251] Submitted process > make_file (Sample6)
[84/f8318e] Submitted process > make_file (Sample7)
[10/b9fc3b] Submitted process > make_file (Sample1)
[83/14cb81] Submitted process > make_file (Sample5)
[b3/211cfd] Submitted process > make_file (Sample4)
[7e/8812c1] Submitted process > make_file (Sample3)
[f7/0b1be4] Submitted process > make_file (Sample2)
[52/29baa9] Submitted process > collect_files
```

If you have Graphviz Dot installed, you can also compile the `flowchart.dot` to PNG format with the included command:

```
$ make flowchart
[ -f flowchart.dot ] && dot flowchart.dot -Tpng -o flowchart.png || echo "file flowchart.dot not present"
```

output:

![flowchart](https://user-images.githubusercontent.com/10505524/39445152-11e10f26-4c88-11e8-99ad-e32b66ce356d.png)
