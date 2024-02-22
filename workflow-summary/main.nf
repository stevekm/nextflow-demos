#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// https://github.com/wikiselev/rnaseq/blob/eaebf588e83e2f78cea0a4451db2d4eea5789493/main.nf#L1036-L1054
// https://github.com/nf-core/tools/issues/92
// https://github.com/nf-core/cookiecutter/issues/28

process MULTIQC {
    // https://github.com/nf-core/modules/blob/ae7b3a25e0abfa1ccccc8048ba5753aae79a33b2/modules/nf-core/multiqc/main.nf
    publishDir "${params.outdir}", mode: "copy"

    container 'quay.io/biocontainers/multiqc:1.20--pyhdfd78af_0'

    input:
    path(multiqc_files, stageAs: "?/*")

    output:
    path("multiqc_report.html"), emit: html

    script:
    """
    multiqc .
    """
}

workflow {
    println "hello world"

    files_ch = Channel.empty()

    summary = [:]
    summary << params
    summary << workflow.properties
    summary << workflow.manifest.properties

    yaml_ch = Channel.from("").map{ it ->
        // note that some of these are repeated from the manifest
        def yaml_str = """
    id: 'workflow-summary'
    description: " - this information is collected when the pipeline is started."
    section_name: 'Workflow Summary'
    section_href: 'https://github.com/stevekm/nextflow-demos'
    plot_type: 'html'
    data: |
        <dl class=\"dl-horizontal\">
${summary.collect { k,v -> "            <dt>$k</dt><dd><samp>${v ?: '<span style=\"color:#999999;\">N/A</a>'}</samp></dd>" }.join("\n")}
        </dl>
        """.stripIndent()
        return yaml_str
    }.collectFile(name: "workflow_summary_mqc.yaml")

    files_ch = files_ch.mix(
        yaml_ch
    )

    MULTIQC(
        files_ch
        )
}