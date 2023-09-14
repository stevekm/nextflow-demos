nextflow.enable.dsl=2

process DO_SOMETHING {
    tag "${meta.id}"
    debug true

    input:
    tuple val(meta), path(fastq)

    output:
    path("done.txt")

    script:
    """
    echo ">>> Running ${meta.id}; meta: ${meta}; memory: ${task.memory.toString()}"
    touch done.txt
    """
}


workflow {
    input_ch = Channel.from(file("Samplesheet.csv"))
    .splitCsv(header: true)
    .map { row ->
        def inputMem = row.memMB
        def fastq = file(row.file)
        def numReads = fastq.countFastq()
        def metaMap = row.subMap("id") + ["reads": numReads, "memOverride": false, "memOverrideVal": 0]

        if (inputMem.isInteger()) {
            metaMap["memOverride"] = true
            metaMap["memOverrideVal"] = inputMem as Integer
        }

        return [metaMap, fastq]
    }

    DO_SOMETHING(input_ch)
}