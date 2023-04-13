# Testing methods for Nextflow workflows

Run the workflow normally to make sure it works properly on your system (requires Docker)

```
$ nextflow run main.nf
N E X T F L O W  ~  version 22.10.6
Launching `main.nf` [trusting_wiles] DSL2 - revision: 15a5bc0069
executor >  local (1)
[a4/fbd7d3] process > VCF_FILTER (1) [100%] 1 of 1 ✔
```

## `pytest-workflow`

( `pytest-workflow` installation is included with the included conda `environment.yml` in the parent dir )

```
$ pytest
===================================== test session starts =====================================
platform darwin -- Python 3.10.4, pytest-7.1.2, pluggy-1.0.0
rootdir: /Users/steve/projects/nextflow-demos/testing
plugins: xdist-2.5.0, workflow-2.0.1, forked-1.3.0
collecting ...
collected 4 items

Run workflow:
	command:   nextflow run main.nf
	directory: /var/folders/jr/z1c9w1d91x75p2cr86441w9w0000gp/T/pytest_workflow_w537cid6/Run_workflow
	stdout:    /var/folders/jr/z1c9w1d91x75p2cr86441w9w0000gp/T/pytest_workflow_w537cid6/Run_workflow/log.out
	stderr:    /var/folders/jr/z1c9w1d91x75p2cr86441w9w0000gp/T/pytest_workflow_w537cid6/Run_workflow/log.err
'Run workflow' done.

custom_test.py .    [ 25%]
test.yml ...        [100%] Removing temporary directories and logs. Use '--kwd' or '--keep-workflow-wd' to disable this behaviour.


====================================== 4 passed in 2.88s ======================================
```

Resources:
- https://github.com/LUMC/pytest-workflow
- https://pytest-workflow.readthedocs.io/en/stable/#introduction
- https://nf-co.re/events/2021/bytesize-17-pytest-workflow

## `nf-test`

```
$ ./nf-test test main.nf.test

🚀 nf-test 0.7.3
https://code.askimed.com/nf-test
(c) 2021 - 2023 Lukas Forer and Sebastian Schoenherr


Test Pipeline

  Test [99b66001] 'Should run without failures' PASSED (4.583s)


SUCCESS: Executed 1 tests in 4.587s
```

Resources:
- https://github.com/askimed/nf-test
- https://code.askimed.com/nf-test/