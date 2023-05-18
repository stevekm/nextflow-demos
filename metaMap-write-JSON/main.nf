import groovy.json.JsonOutput
import groovy.json.JsonSlurper
nextflow.enable.dsl=2

params.samplesheet = "samplesheet.csv"
params.outputDir = "output"

// https://code-maven.com/groovy-json
process WRITE_JSON {
    publishDir "${params.outputDir}", mode: 'copy'

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

process READ_JSON {
    // NOTE: must use val here to get input file path; see these;
    // https://github.com/nextflow-io/nextflow/issues/378
    // https://github.com/nextflow-io/nextflow/issues/942
    input:
    val(inputJsonPath)

    output:
    val(metaMap), emit: metaMap

    exec:
    println ">>> READ_JSON inputJsonPath: ${inputJsonPath}"
    contents = file(inputJsonPath).text
    // NOTE: why doesnt this work??? ;  // File file_obj = new File("${inputJsonPath}")
    println ">>> READ_JSON contents: ${contents}"
    metaMap = new JsonSlurper().parseText(contents)
    println ">>> READ_JSON metaMap: ${metaMap}"
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

        // create a JSON file
        WRITE_JSON(input_ch.meta)

        // read the file contents
        READ_JSON(WRITE_JSON.out.metaJson)

        // pass the file contents through a channel
        READ_JSON.out.metaMap.map{ meta ->
            println "output channel meta: ${meta}"
        }
}