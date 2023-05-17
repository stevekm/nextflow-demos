import groovy.json.JsonOutput
import groovy.json.JsonSlurper
nextflow.enable.dsl=2

params.samplesheet = "samplesheet.csv"
params.outputDir = "output"

// https://code-maven.com/groovy-json
process WRITE_JSON {
    publishDir "${params.outputDir}", mode: 'copy'

    // NOTE: do not try to read from input files in the 'exec' context
    input:
    val(meta)

    output:
    path(outputfile), emit: metaJson

    // NOTE: do not use 'def' here
    exec:
    println ">>> WRITE_JSON meta: ${meta}"
    json_str = JsonOutput.toJson(meta)
    println ">>> WRITE_JSON json_str: ${json_str}"
    json_indented = JsonOutput.prettyPrint(json_str)
    println ">>> WRITE_JSON json_indented: ${json_indented}"
    outputfile = new File("${task.workDir}/meta.json")
    outputfile.write(json_indented)
}

workflow {
    // load csv
        Channel.fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map { row ->
            def sampleFile = file(row.sampleFile)

            // construct meta map from subset of samplesheet fields
            meta = row.subMap('sampleID', 'sampleType')

            [meta, sampleFile]
        }
        // send the output to two separate channels
        .multiMap { meta, sampleFile ->
            meta: meta
            samples: [meta, sampleFile]
        }.set { input_ch }

        // look at channel contents
        // input_ch.meta.view()
        // input_ch.samples.view()

        // create a JSON file
        WRITE_JSON(input_ch.meta)

        // read the JSON file; note that you cannot do this from within a process exec scope
        WRITE_JSON.out.metaJson.map { jsonFile ->
            def data = new JsonSlurper().parseText(jsonFile.text)
            println "read data back in from JSON file: ${data}"
        }

}