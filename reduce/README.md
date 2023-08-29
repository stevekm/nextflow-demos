# Reduce

Demo of implementing the `reduce` Channel operator to get the unique entries from a series of files

## Usages

```
$ nextflow run main.nf
N E X T F L O W  ~  version 23.04.1
Launching `main.nf` [magical_bernard] DSL2 - revision: 6349916143
data/Sample10.txt
data/Sample8.txt
data/Sample9.txt
data/Sample7.txt
data/Sample6.txt
data/Sample4.txt
data/Sample5.txt
data/Sample1.txt
data/Sample2.txt
data/Sample3.txt
combined: [12, 17, 19, 2, 20, 4, 5, 6, 7, 9]
combined: [12, 17, 19, 2, 20, 3, 4, 5, 6, 7, 8, 9]
combined: [1, 12, 14, 17, 19, 2, 20, 3, 4, 5, 6, 7, 8, 9]
combined: [1, 12, 14, 16, 17, 18, 19, 2, 20, 3, 4, 5, 6, 7, 8, 9]
combined: [1, 12, 14, 16, 17, 18, 19, 2, 20, 3, 4, 5, 6, 7, 8, 9]
combined: [1, 11, 12, 14, 16, 17, 18, 19, 2, 20, 3, 4, 5, 6, 7, 8, 9]
combined: [1, 11, 12, 14, 16, 17, 18, 19, 2, 20, 3, 4, 5, 6, 7, 8, 9]
combined: [1, 11, 12, 14, 16, 17, 18, 19, 2, 20, 3, 4, 5, 6, 7, 8, 9]
combined: [1, 10, 11, 12, 13, 14, 16, 17, 18, 19, 2, 20, 3, 4, 5, 6, 7, 8, 9]
[1, 10, 11, 12, 13, 14, 16, 17, 18, 19, 2, 20, 3, 4, 5, 6, 7, 8, 9]
```