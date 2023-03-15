# Combinatorial

A method for evaluation of all unique combinations of all parameters in a set. For example, running all combinations of a set of arguments for a program.

So, for a set of arguments like this:

```
[ '-arg 1', '-arg 2', '-arg 3', '-arg 4' ]
```

Evaluate combinations such as:

```
-arg 1
-arg 1 -arg 2
-arg 1 -arg 2 -arg 3
-arg 1 -arg 2 -arg 3 -arg 4
-arg 2 -arg 3
-arg 2 -arg 3 -arg 4
...
...
# etc.
```

## Usage

Pipeline can be run using the included `Makefile` with the command:

```
make run
```

## Output

Output should look like this:

```
$ make run
./nextflow run main.nf
N E X T F L O W  ~  version 0.28.0
Launching `main.nf` [thirsty_hopper] - revision: 9d28a2d665
[warm up] executor > local
[40/e8b30c] Submitted process > run (2)
[1b/617ab8] Submitted process > run (4)
[57/f9eb89] Submitted process > run (3)
[43/6359c0] Submitted process > run (1)
[ba/81dfec] Submitted process > run (7)
param4.param1: -arg 4 -arg 1
param3.param1: -arg 3 -arg 1
[38/0c7100] Submitted process > run (5)
param1: -arg 1
[98/976c92] Submitted process > run (6)
param4.param1.param3: -arg 4 -arg 1 -arg 3
[38/d6fb04] Submitted process > run (9)
param3.param2.param1: -arg 3 -arg 2 -arg 1
[55/64fcb4] Submitted process > run (10)
param4.param2.param1: -arg 4 -arg 2 -arg 1
[cc/71f692] Submitted process > run (11)
param2: -arg 2
[a1/87586b] Submitted process > run (12)
param4.param2: -arg 4 -arg 2
[95/ad25e6] Submitted process > run (13)
param3: -arg 3
[e5/8be1a3] Submitted process > run (14)
param3.param4: -arg 3 -arg 4
[69/3e9426] Submitted process > run (8)
param4: -arg 4
[16/058b6a] Submitted process > run (15)
param4.param2.param3.param1: -arg 4 -arg 2 -arg 3 -arg 1
param2.param1: -arg 2 -arg 1
param3.param2: -arg 3 -arg 2
param4.param2.param3: -arg 4 -arg 2 -arg 3
```
