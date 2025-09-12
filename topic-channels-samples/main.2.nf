process DO_THING {
    // debug true
    errorStrategy "ignore"

    input:
    val(x)

    output:
    tuple val("${sampleID}"), val("${task.process}"), topic: passed
    tuple val("${sampleID}"), val("${task.process}"), emit: passed

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
    tuple val("${sampleID}"), val("${task.process}"), topic: passed
    tuple val("${sampleID}"), val("${task.process}"), emit: passed

    script:
    sampleID = "${x}"
    """
    echo "got $x"
    if [ "$x" == "Sample2" ]; then echo "bad sample!"; exit 1; fi
    """
}

process FAKE_MULTIQC {
    // put your multiqc here to do thing with the table you made
    // debug true

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
        return ["${sampleID}", "INPUT"]
    }
    inputSamples2 = samples.map { sampleID ->
        return ["${sampleID}", "INPUT2"]
    }

    DO_THING(samples)
    DO_THING2(samples)

    // view the samples that passed
    // allSamples = inputSamples.concat(channel.topic("passed")).concat(inputSamples2).groupTuple(by: 0)
    allSamples = inputSamples.concat(DO_THING.out.passed, DO_THING2.out.passed).concat(inputSamples2).groupTuple(by: 0)
    allSamples.view()

    // gives the following output;
    // [Sample1, [INPUT]]
    // [Sample2, [INPUT]]
    // [Sample3, [INPUT]]
    // [Sample4, [INPUT]]
    // [Sample1, [DO_THING2]]
    // [Sample3, [DO_THING, DO_THING2]]
    // [Sample4, [DO_THING, DO_THING2]]
    // [Sample2, [DO_THING]]

    // but its supposed to look like this;
    // [Sample1, [INPUT, DO_THING2]]
    // [Sample3, [INPUT, DO_THING, DO_THING2]]
    // [Sample4, [INPUT, DO_THING, DO_THING2]]
    // [Sample2, [INPUT, DO_THING]]

    // make a table out of the passing samples
    samplesTable = channel.topic("passed")
        .map { processName, sampleId ->
            return "${processName}\t${sampleId}"
        }
        .collectFile(name: "passed.txt", storeDir: "output", newLine: true)
    FAKE_MULTIQC(samplesTable)
}