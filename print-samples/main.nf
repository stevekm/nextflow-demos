// set up Channels from list of character strings
Channel.from( ['Sample1','Sample2','Sample3','Sample4'] )
        .into { samples; samples2; samples3; samples4 }

// code surrounded by ' { } ' is a closure; an in-place function
// default variable for values passed to closure is 'it'
// print each entry that passes throught the Channel
samples.subscribe { println "[samples] ${it}" }

// basic process to print a value
process print_sample {
    input:
    val(sampleID) from samples2

    script:
    """
    echo "[print_sample] ${sampleID}"
    """
}

// give each instance of the process a tag based on the sample ID value
process with_tags {
    tag { "${sampleID}" }

    input:
    val(sampleID) from samples3

    script:
    """
    echo "[with_tags] ${sampleID}"
    """
}

// print the output of each process to the terminal
process with_echo {
    tag "${sampleID}"
    echo true

    input:
    val(sampleID) from samples4

    script:
    """
    echo "[with_echo] ${sampleID}"
    """
}
