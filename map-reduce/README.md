# recursive map reduce

A naive partial implementation of map reduce in Nextflow

combine all input files in a pairwise manner then do a final merge of the remaining tables

True recursion in Nextflow is not completely supported so we just use a fixed number of iterations then do a final merge on any remaining files

See these docs;

- https://community.seqera.io/t/recursion-in-workflow-control/659
- https://github.com/nextflow-io/nextflow/discussions/2521
- https://nextflow-io.github.io/patterns/feedback-loop/

## Usage

```bash
$ nextflow run main.nf
Nextflow 26.04.0 is available - Please consider updating your version to it

 N E X T F L O W   ~  version 25.04.7

Launching `main.nf` [confident_curran] DSL2 - revision: b12d340da0

executor >  local (11)
[9f/6ff946] ROUND1:MERGE_FILES (2) [100%] 5 of 5 ✔
[c2/0be045] ROUND2:MERGE_FILES (2) [100%] 3 of 3 ✔
[fe/b07415] ROUND3:MERGE_FILES (1) [100%] 2 of 2 ✔
[be/c99b2e] MERGE_FILES            [100%] 1 of 1 ✔
/Users/stevekm/projects/nextflow-demos/map-reduce/work/be/c99b2ef083d44e08e424f6b7525c16/output.txt


$ cat /Users/stevekm/projects/nextflow-demos/map-reduce/work/be/c99b2ef083d44e08e424f6b7525c16/output.txt
7	8	9	5	6	1	2	3	4
7	8	9	5	6	1	2	3	4
7	8	9	5	6	1	2	3	4
7	8	9	5	6	1	2	3	4
7	8	9	5	6	1	2	3	4
7	8	9	5	6	1	2	3	4
```
