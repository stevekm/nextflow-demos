# Workflow summary in MultiQC

Super basic rudimentary prototype simple method for getting a workflow summary table from Nextflow into Multiqc.

# Usage

```bash
nextflow run main.nf
```

- requires Docker

Creates the file `workflow_summary_mqc.yaml` which has a format like this;

```
id: 'workflow-summary'
description: " - this information is collected when the pipeline is started."
section_name: 'Workflow Summary'
section_href: 'https://github.com/stevekm/nextflow-demos'
plot_type: 'html'
data: |
    <dl class="dl-horizontal">
        <dt>outdir</dt><dd><samp>output</samp></dd>
        <dt>val1</dt><dd><samp>foo</samp></dd>
        <dt>val2</dt><dd><samp>bar</samp></dd>
...
```

This file is passed to MultiQC, where it gets automatically ingested and turned into a report section with HTML table.

# Resources

- https://multiqc.info/docs/usage/pipelines/
- https://github.com/nf-core/cookiecutter/issues/28
  - https://github.com/nf-core/tools/issues/92
  - https://github.com/wikiselev/rnaseq/blob/eaebf588e83e2f78cea0a4451db2d4eea5789493/main.nf#L1036-L1054
  - https://github.com/wikiselev/rnaseq/blob/eaebf588e83e2f78cea0a4451db2d4eea5789493/main.nf#L201-L246
  - https://github.com/nf-core/rnaseq/blob/b89fac32650aacc86fcda9ee77e00612a1d77066/workflows/rnaseq.nf#L869