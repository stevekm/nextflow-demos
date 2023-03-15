# Bath Processing

This example shows methods for processing a large amount of files in parallel.

For demonstration purposes, the `input` directory contains simulated files that represent data produced elsewhere (variant tables), outside of Nextflow.

Our workflow consists of the following steps

- selectively find the variant tables we wish to process (outside of Nextflow with the `find-variants.sh` script, which saves a list of paths to the file `all-variants.tsv`)

- load the paths to the desired variant tables into our Nextflow pipeline, along with the path to a file containing desired variant IDs

- add extra columns to each table

- filter each table for desired variants

- concatenate the tables

In real life, the operation we wish to perform may be very lengthy and compute intensive (a `sleep` statement simulates this in the workflow). This demonstration uses the `buffer` operator to emit groups of files to combine and filter in parallel, then their collected output is itself combined.

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

Output should look like this:

```
$ make run
./find-variants.sh
./nextflow run main.nf
N E X T F L O W  ~  version 0.29.0
Launching `main.nf` [serene_wilson] - revision: 03a6750e49
[warm up] executor > local
[03/9edfb6] Submitted process > update_table (Sample2.HaplotypeCaller)
[d0/9639a4] Submitted process > update_table (Sample1.HaplotypeCaller)
[a2/f62234] Submitted process > update_table (Sample10.LoFreq)
[80/54d83b] Submitted process > update_table (Sample1.MuTect2)
[03/09c5c4] Submitted process > update_table (Sample10.MuTect2)
[c5/9310fd] Submitted process > update_table (Sample2.LoFreq)
[a5/81387c] Submitted process > update_table (Sample1.LoFreq)
[04/73764b] Submitted process > update_table (Sample10.HaplotypeCaller)
[e0/9f5ca8] Submitted process > update_table (Sample2.MuTect2)
[b0/808a15] Submitted process > update_table (Sample3.HaplotypeCaller)
[7e/b0247f] Submitted process > update_table (Sample3.LoFreq)
[06/edda14] Submitted process > update_table (Sample3.MuTect2)
[db/c1533d] Submitted process > update_table (Sample4.HaplotypeCaller)
[32/c37f5f] Submitted process > update_table (Sample4.LoFreq)
[b1/7982f5] Submitted process > update_table (Sample6.MuTect2)
[d8/27367c] Submitted process > update_table (Sample7.HaplotypeCaller)
[fd/a4465b] Submitted process > update_table (Sample7.LoFreq)
[bd/fca4eb] Submitted process > update_table (Sample7.MuTect2)
[f5/57bbc9] Submitted process > update_table (Sample6.LoFreq)
[b8/6a1dda] Submitted process > update_table (Sample8.HaplotypeCaller)
[ad/380813] Submitted process > update_table (Sample6.HaplotypeCaller)
[44/fd8d98] Submitted process > update_table (Sample9.HaplotypeCaller)
[d2/9b15de] Submitted process > update_table (Sample4.MuTect2)
[51/6689dd] Submitted process > update_table (Sample9.LoFreq)
[48/907937] Submitted process > update_table (Sample8.MuTect2)
[3e/dbd1b0] Submitted process > update_table (Sample8.LoFreq)
[be/dcb2e1] Submitted process > update_table (Sample9.MuTect2)
[d8/f21c17] Submitted process > split_combine_search (Sample2.HaplotypeCaller.variants.tsv Sample1.HaplotypeCaller.variants.tsv Sample1.MuTect2.variants.tsv Sample10.LoFreq.variants.tsv)
[56/50aedd] Submitted process > split_combine_search (Sample10.MuTect2.variants.tsv Sample10.HaplotypeCaller.variants.tsv Sample2.LoFreq.variants.tsv Sample2.MuTect2.variants.tsv)
[95/6f6e30] Submitted process > split_combine_search (Sample3.HaplotypeCaller.variants.tsv Sample3.MuTect2.variants.tsv Sample3.LoFreq.variants.tsv Sample4.HaplotypeCaller.variants.tsv)
[e6/c7a2e1] Submitted process > split_combine_search (Sample4.LoFreq.variants.tsv Sample6.MuTect2.variants.tsv Sample7.HaplotypeCaller.variants.tsv Sample7.LoFreq.variants.tsv)
[bb/2a8591] Submitted process > split_combine_search (Sample7.MuTect2.variants.tsv Sample1.LoFreq.variants.tsv Sample8.HaplotypeCaller.variants.tsv Sample6.HaplotypeCaller.variants.tsv)
[b5/96d7bd] Submitted process > split_combine_search (Sample9.HaplotypeCaller.variants.tsv Sample4.MuTect2.variants.tsv Sample9.LoFreq.variants.tsv Sample8.MuTect2.variants.tsv)
[e0/d361d7] Submitted process > split_combine_search (Sample8.LoFreq.variants.tsv Sample9.MuTect2.variants.tsv Sample6.LoFreq.variants.tsv)
[4b/dcfa6e] Submitted process > final_combine
```

Output file should look like this:

```
$ head output/final.variants.tsv
VariantID	Run	Sample	VariantCaller
variant3	2018-05-08_13-30-59	Sample2	HaplotypeCaller
variant4	2018-05-08_13-30-59	Sample2	HaplotypeCaller
variant3	2018-05-08_13-30-59	Sample1	HaplotypeCaller
variant4	2018-05-08_13-30-59	Sample1	HaplotypeCaller
variant3	2018-05-08_13-30-59	Sample1	MuTect2
variant4	2018-05-08_13-30-59	Sample1	MuTect2
variant3	2018-05-08_13-30-59	Sample10	LoFreq
variant4	2018-05-08_13-30-59	Sample10	LoFreq
variant3	2018-05-08_13-30-59	Sample10	MuTect2
```
