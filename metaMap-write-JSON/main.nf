import groovy.json.JsonOutput
import groovy.json.JsonSlurper
nextflow.enable.dsl=2

params.samplesheet = "samplesheet.csv"
params.outputDir = "output"

// cli override to turn off JSON saving since it currently appears to conflict with -resume
// $ nextflow run main.nf --saveJSON false ;
// case-insensitive True / False gets converted automatically to bool type
params.saveJSON = true

// https://code-maven.com/groovy-json
process WRITE_JSON {
    publishDir "${params.outputDir}", mode: 'copy'

    input:
    val(meta)

    output:
    path(outputfile), emit: metaJson

    when:
    params.saveJSON

    // NOTE: do not use 'def' here
    exec:
    // println ">>> WRITE_JSON meta: ${meta}"
    json_str = JsonOutput.toJson(meta)
    // println ">>> WRITE_JSON json_str: ${json_str}"
    json_indented = JsonOutput.prettyPrint(json_str)
    // println ">>> WRITE_JSON json_indented: ${json_indented}"
    outputfile = new File("${task.workDir}/${meta.sampleID}.exec.json")
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

    when:
    params.saveJSON

    exec:
    // println ">>> READ_JSON inputJsonPath: ${inputJsonPath}"
    contents = file(inputJsonPath).text
    // NOTE: why doesnt this work??? ;  // File file_obj = new File("${inputJsonPath}")
    // println ">>> READ_JSON contents: ${contents}"
    metaMap = new JsonSlurper().parseText(contents)
    println ">>> READ_JSON metaMap: ${metaMap}"
}

process WRITE_JSON_SCRIPT {
    // write using script; the default shell is bash
    publishDir "${params.outputDir}", mode: 'copy'

    input:
    val(meta)

    output:
    path(outputFile), emit: jsonFile

    script:
    outputFile = "${meta.sampleID}.script.json"
    json_str = JsonOutput.toJson(meta)
    json_indented = JsonOutput.prettyPrint(json_str)
    // NOTE: using single quotes is required here!
    """
    echo '${json_indented}' > "${outputFile}"
    """
}

workflow {
    // load csv
    Channel.fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map { row ->
            def sampleFile = file(row.sampleFile)

            // construct meta map from subset of samplesheet fields
            meta = row.subMap('sampleID', 'sampleType', 'sampleVal', 'sampleTag')

            [meta, sampleFile]
        }
        // send the output to two separate channels
        .multiMap { meta, sampleFile ->
            meta: meta
            samples: [meta, sampleFile] // for demonstration purposes; not actually using this one
        }.set { input_ch }

        // create a JSON file with Nextflow exec
        WRITE_JSON(input_ch.meta)

        // also use the Nextflow script scope to write the file
        WRITE_JSON_SCRIPT(input_ch.meta)

        // read the file contents
        READ_JSON(WRITE_JSON.out.metaJson.concat(WRITE_JSON_SCRIPT.out.jsonFile))

        // pass the file contents through a channel
        READ_JSON.out.metaMap.map{ meta ->
            println "output channel meta: ${meta}"
        }
}