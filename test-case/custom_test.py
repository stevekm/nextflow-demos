import pathlib
import pytest
"""
Run with:
$ pytest

https://pytest-workflow.readthedocs.io/en/stable/#writing-custom-tests
"""


@pytest.mark.workflow('Run workflow') # this must match a named test in the yaml file
def test_line_count(workflow_dir):
    output_file = pathlib.Path(workflow_dir, "output.txt")
    with open(output_file) as fin:
        file_content = fin.readlines()
    assert len(file_content) == 2