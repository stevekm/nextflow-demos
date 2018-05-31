# Aggregate Database Report

A demonstration of using a database to store data produced during your Nextflow pipeline for dynamic report generation. Two workflows are presented:

- `plots.nf`: an R-centric workflow that generates R plot objects for parameter sets, stores them in database, then generates a report based on the database contents.

- `people.nf`: a more generic workflow that downloads images of British royalty, stores the images along with metadata in databases, then passes them to a report.

During data analysis workflows, it is common to analyze many datasets in parallel. Nextflow makes this process very easy. Generating summary reports based on that data can often require maintaining the association between datasets, analysis output, and various metadata, which may not be as easy with Nextflow, especially if the output includes binary data such as images and objects. To help with this task, a database can be used to store the required metadata along with objects and figures for consumption by the downstream reporting program.

__NOTE:__ This is presented for demonstration purposes only and does not necessarily represent best programming practices.

__NOTE:__ SQLite is used here for simplicity. However real-life implementations would likely benefit from using a database server like MySQL, PostgreSQL, etc.

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

Output should look like this:

```
$ make run
./nextflow run people.nf
N E X T F L O W  ~  version 0.29.0
Launching `people.nf` [cheeky_murdock] - revision: 289d1117f3
[warm up] executor > local
[1d/183597] Submitted process > create_db (Helena)
[79/343382] Submitted process > download_pics (Victoria)
[2e/21cee5] Submitted process > create_db (Victoria)
[9c/0c1a01] Submitted process > create_db (Albert)
[03/d94ebc] Submitted process > download_pics (Albert)
[7b/882838] Submitted process > download_pics (Helena)
[96/6f6700] Submitted process > update_dbs (Victoria)
[92/8e540d] Submitted process > update_dbs (Albert)
[8c/ef838d] Submitted process > update_dbs (Helena)
[ea/aa04bc] Submitted process > concat_dbs
[84/8684b6] Submitted process > report (1)
./nextflow run plots.nf
N E X T F L O W  ~  version 0.29.0
Launching `plots.nf` [modest_kilby] - revision: 4c19e53841
[warm up] executor > local
[d3/ab445b] Submitted process > make_plot_dbs (Sample3)
[6f/23aab7] Submitted process > make_plot_dbs (Sample4)
[a0/eda743] Submitted process > make_plot_dbs (Sample2)
[05/f72859] Submitted process > make_plot_dbs (Sample1)
[01/229d2a] Submitted process > concat_dbs
[8e/0f0144] Submitted process > report (1)
```

Example report outputs can be found here:

- [people.html](https://rawgit.com/stevekm/nextflow-demos/aggr-reports/aggregate-db-report/output/people/people.html)

- [plots.html](https://rawgit.com/stevekm/nextflow-demos/aggr-reports/aggregate-db-report/output/plots/plots.html)

# Software

- SQLite

- Python

- R 3.3+ is required for some plot rendering functionality used here, with the following libraries:

  - `rmarkdown`, `ggplot2`, `knitr`, `RSQLite`
