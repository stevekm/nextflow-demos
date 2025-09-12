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

process FAKE_MULTIQC {
    // put your multiqc here to do thing with the table you made
    debug true

    input:
    path(input_file)

    script:
    """
    echo "put your multiqc with the table here"
    echo "here is your table:"
    cat "${input_file}"
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
    // allSamples.view()

    // make a table out of the passing samples
    samplesTable = allSamples.map { sampleId, processList  ->
            return "${sampleId}\t${processList}"
        }
        .collectFile(name: "passed.txt", storeDir: "output", newLine: true)
    FAKE_MULTIQC(samplesTable)
}