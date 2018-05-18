Channel.from([
    ['demo1', file('demo1.tsv')],
    ['demo2', file('demo2.tsv')],
    ['demo3', file('demo3.tsv')]
    ])
    .set { first_inputs }
good_first_inputs = Channel.create()
bad_first_inputs = Channel.create()

Channel.from([
    ['demo4', file('demo4.tsv')],
    ['demo5', file('demo5.tsv')]
    ])
    .set { second_inputs }
good_second_inputs = Channel.create()
bad_second_inputs = Channel.create()

// dummy processes to create channels
process start_good {
    input:
    val(foo) from Channel.from("")
    output:
    val(foo) into all_good_inputs
    exec:
    sleep(0)
}

process start_bad {
    input:
    val(foo) from Channel.from("")
    output:
    val(foo) into all_bad_inputs
    exec:
    sleep(0)
}

first_inputs.choice( good_first_inputs, bad_first_inputs ){ items ->
    def output = 1 // bad by default
    def sampleID = items[0]
    def sampleFile = items[1]
    def count = sampleFile.readLines().size()
    if (count > 1) output = 0
    println "[first_inputs] ${sampleID} ${sampleFile} ${count} ${output}"
    return(output)
    }

second_inputs.choice( good_second_inputs, bad_second_inputs ){ items ->
    def output = 1 // bad by default
    def sampleID = items[0]
    def sampleFile = items[1]
    def count = sampleFile.readLines().size()
    if (count > 1) output = 0
    println "[second_inputs] ${sampleID} ${sampleFile} ${count} ${output}"
    return(output)
    }

all_good_inputs.filter { line ->
        line != ""
    }
    .mix(good_first_inputs, good_second_inputs)
    .map{ items ->
    def sampleID = items[0]
    def fileName = items[1]
    def reason = "File has enough lines"
    def output = [reason, sampleID, fileName].join('\t')
    return(output)
    }
    .collectFile(storeDir: '.', name: 'all_good_inputs.txt', newLine: true)

all_bad_inputs.filter { line ->
        line != ""
    }
    .mix(bad_first_inputs, bad_second_inputs).map { items ->
    def sampleID = items[0]
    def fileName = items[1]
    def reason = "Not enough lines in file"
    def output = [reason, sampleID, fileName].join('\t')
    return(output)
    }
    .collectFile(storeDir: '.', name: 'all_bad_inputs.txt', newLine: true)
