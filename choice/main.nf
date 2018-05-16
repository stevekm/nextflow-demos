// printf 'foo' > demo1.tsv; printf 'foo\nbar' > demo2.tsv; printf 'foo' > demo3.tsv; printf 'foo' > demo4.tsv; printf 'foo\nbar' > demo5.tsv
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

all_bad_inputs = Channel.create()
all_good_inputs = Channel.create()


first_inputs.choice( good_first_inputs, bad_first_inputs ){ items ->
    def output = 1 // bad by default
    def sampleID = items[0]
    def sampleFile = items[1]
    def count = sampleFile.readLines().size()
    if (count > 1) output = 0
    println "[first_inputs] ${sampleID} ${sampleFile} ${count} ${output}"
    return(output)
    }

// good_first_inputs.subscribe { println "[good_first_inputs] ${it}" }
// bad_first_inputs.subscribe { println "[bad_first_inputs] ${it}" }


second_inputs.choice( good_second_inputs, bad_second_inputs ){ items ->
    def output = 1 // bad by default
    def sampleID = items[0]
    def sampleFile = items[1]
    def count = sampleFile.readLines().size()
    if (count > 1) output = 0
    println "[second_inputs] ${sampleID} ${sampleFile} ${count} ${output}"
    return(output)
    }

// good_second_inputs.subscribe { println "[good_second_inputs] ${it}" }
// bad_second_inputs.subscribe { println "[bad_second_inputs] ${it}" }

all_good_inputs.mix(good_first_inputs, good_second_inputs).subscribe { println "[all_good_inputs] ${it}" }
// .collectFile(storeDir: '.', name: 'all_good_inputs.txt', newLine: true)

all_bad_inputs.mix(bad_first_inputs, bad_second_inputs).subscribe { println "[all_bad_inputs] ${it}" }
// .collectFile(storeDir: '.', name: 'all_bad_inputs.txt', newLine: true)
