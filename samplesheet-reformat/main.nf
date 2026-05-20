
// https://nextflow-io.github.io/patterns/process-per-csv-record/
// https://docs.seqera.io/nextflow/reference/operator#collectfile
// https://training.nextflow.io/2.6.0/side_quests/splitting_and_grouping/#33-use-submap-to-create-a-new-joining-key
workflow {
    ch_samplesheet = channel.fromPath(file(params.samplesheet, checkIfExists: true)).splitCsv(header:true)
    ch_samplesheet.view() // [sample:Sample1, fastq_1:input/file1-1.txt, fastq_2:input/file1-2.txt, strandedness:auto, condition:control]

    new_samples = ch_samplesheet.map { row ->
        def new_row = row.subMap(["sample", "condition"])
        return new_row
    }
    // [sample:Sample3, condition:control]
    // new_samples.view()

    output_lines = new_samples.map{ row ->
        def headers = row.keySet().join(",")
        def values = row.values().join(",")
        def line = [headers, values].join("\n") + "\n" // need to add the trailing newline here
        return line
    }
    // sample,condition
    // Sample1,control

    output_lines.collectFile(name: 'new_samplesheet.csv', storeDir: "${params.outdir}", newLine: false, keepHeader: true)
}