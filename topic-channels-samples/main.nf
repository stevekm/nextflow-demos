process DO_THING {
    debug true
    errorStrategy "ignore"

    input:
    val(x)

    output:
    val("DO_THING - ${sampleID}"), topic: passed

    script:
    sampleID = "${x}"
    """
    echo "got $x"
    if [ "$x" == "Sample1" ]; then echo "bad sample!"; exit 1; fi
    """
}

process DO_THING2 {
    debug true
    errorStrategy "ignore"

    input:
    val(x)

    output:
    val("DO_THING2 - ${sampleID}"), topic: passed

    script:
    sampleID = "${x}"
    """
    echo "got $x"
    if [ "$x" == "Sample2" ]; then echo "bad sample!"; exit 1; fi
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
    println("hello")

    samples = Channel.from("Sample1", "Sample2", "Sample3", "Sample4")

    DO_THING(samples)
    DO_THING2(samples)

    // view the samples that passed
    channel.topic("passed").collect().view()

    // make a table out of the passing samples
    samplesTable = channel.topic("passed").collectFile(name: "passed.txt", storeDir: "output", newLine: true)
    FAKE_MULTIQC(samplesTable)
}