nextflow.enable.dsl=2
nextflow.preview.topic = true

process FOO {
    tag "${id}"

    input:
    val(id)

    output:
    // simple example with static version label using `val`
    // NOTE: also try task.name
    tuple val(task.process), val(task.container), val("v1.1"), topic: versions

    script:
    """
    """
}

process BAR {
    tag "${id}"
    container "quay.io/biocontainers/multiqc:1.14--pyhdfd78af_0"

    input:
    val(id)

    output:
    // using `eval` but need to use a | with sed
    tuple val(task.process),
        val(task.container),
        eval('bash -c "multiqc --version | sed -e \'s/multiqc, version //g\'"'), topic: versions

    script:
    """
    """
}

process BAZ {
    tag "${id}"

    input:
    val(id)

    output:
    // simple `eval` but no sed pipe needed
    tuple val(task.process), val(task.container), eval('echo 4.3.1'), topic: versions

    script:
    """
    """
}

workflow BAR_SUBWORKFLOW {
    take:
        ids_ch

    main:
        BAR(ids_ch)
        BAZ(ids_ch)
}

workflow {
    input_ch = Channel.from("Sample1", "Sample2", "Sample3")

    FOO(input_ch)
    BAR_SUBWORKFLOW(input_ch)

    // get unique version strings parsed into a YAML mapping
    channel.topic('versions').map { proc, container, vers ->
        // if it has a ':' from a subworkflow name, then remove it and return the last item
        def proc_label = proc.contains(":") ? proc.tokenize(':').tail()[0] : proc

        // build a YAML entry
        // TODO: instead build an actual map object and convert it to YAML...
        def vers_str = """
${proc_label}:
    version: ${vers}
    container: ${container}
        """.stripIndent()

        return vers_str
    }.unique().view()

}