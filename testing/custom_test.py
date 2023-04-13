#!/usr/bin/env python3
import pathlib
import pytest

@pytest.mark.workflow('Run workflow')
def test_line_count(workflow_dir):
    output_file = pathlib.Path(workflow_dir, "output", "output.vcf")
    numLines = 0
    with open(output_file) as fin:
        for line in fin:
            if not line.startswith("#"):
                numLines += 1
    assert numLines == 20