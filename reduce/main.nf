workflow {
    // 10 files each with 5 random integers selected from 1-20
    input_ch = Channel.from(file("data/*")).view()
    input_ch.map{ it ->
        def contents = it.text.readLines()
        return contents
    }
    .reduce { a, b ->
        def combined = a + b
        combined = combined.toSet().sort()
        println "combined: ${combined}"
        return combined
    }.view()
}