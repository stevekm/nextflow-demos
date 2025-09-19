process DO_THING {
    // debug true
    errorStrategy "ignore"

    input:
    val(x)

    output:
    tuple val(sampleID), val("${task.process}"), topic: passed

    script:
    sampleID = "${x}"
    """
    echo "got $x"
    if [ "$x" == "Sample1" ]; then echo "bad sample!"; exit 1; fi
    """
}

process DO_THING2 {
    // debug true
    errorStrategy "ignore"

    input:
    val(x)

    output:
    tuple val(sampleID), val("${task.process}"), topic: passed

    script:
    sampleID = "${x}"
    """
    echo "got $x"
    if [ "$x" == "Sample2" ]; then echo "bad sample!"; exit 1; fi
    """
}

process DO_THING3 {
    // debug true
    errorStrategy "ignore"

    input:
    val(x)

    output:
    tuple val(sampleID), val("${task.process}"), topic: passed

    script:
    sampleID = "${x}"
    """
    echo "got $x"
    if [ "$x" == "Sample3" ]; then echo "bad sample!"; exit 1; fi
    """
}

process MULTIQC {
    // put your multiqc here to do thing with the table you made
    debug true
    publishDir "output", mode: "copy"

    input:
    path(input_file)

    output:
    path("multiqc_report.html")

    script:
    """
    multiqc --force .
    """
}

workflow {
    samples = Channel.from("Sample1", "Sample2", "Sample3", "Sample4")

    // list all the input samples
    inputSamples = samples.map { sampleID ->
        return [sampleID, "INPUT"]
    }

    DO_THING(samples)
    DO_THING2(samples)
    DO_THING3(samples)

    // view the samples that passed
    allSamples = inputSamples.concat(channel.topic("passed")).map { sampleID, items ->
        // NOTE: need to force all the sampleID's back to the default string type
        // you can check the data types with; println sampleID.getClass()
        return [sampleID.toString(), items]
    }.groupTuple()
    // Sample1	[INPUT, DO_THING2, DO_THING3]
    // Sample3	[INPUT, DO_THING2, DO_THING]
    // Sample4	[INPUT, DO_THING, DO_THING2, DO_THING3]
    // Sample2	[INPUT, DO_THING3, DO_THING]

    // make a single .tsv table from the entries
    samplesTable = allSamples.collectFile(storeDir: "output", newLine: false, keepHeader: true){ sampleID, processList ->
        // make a header line; only the first will get saved in the output table
        def header = "SampleID\tTasks"
        // make the table row
        def line = "${sampleID}\t${processList}"
        // combine the header and row
        def lines = "${header}\n${line}\n"

        // NOTE: files with name '*_mqc.tsv' will get imported to MultiQC automatically
        return ["passed_samples_mqc.tsv", lines]
    }

    MULTIQC(samplesTable)
}