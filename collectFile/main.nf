#!/usr/bin/env nextflow
import groovy.json.JsonOutput
nextflow.enable.dsl=2

params.outdir = "output"

samples_ch = Channel.from( ['Sample1','Sample2','Sample3', 'Sample4'] )

process GET_VALUE {
    publishDir "${params.outdir}/GET_VALUE", overwrite: true, mode: "copy"

    input:
    val(id)

    output:
    path(output_filename), emit: id_tsv
    tuple val(id), path(output_num_filename), emit: id_num

    script:
    output_filename = "${id}.value.tsv"
    output_num_filename = "${id}.value.txt"
    """
    num="\$(echo "${id}" | sed -e 's|Sample||g' )"
    echo "\${num}" > "${output_num_filename}"
    printf '%s\t%s\n' "${id}" "\${num}" > "${output_filename}"
    """
}

workflow {
    GET_VALUE(samples_ch)

    // write a simple concatenated file from the samples input
    samples_ch.collectFile(name: 'samples.collectFile.txt', storeDir: "${params.outdir}/samples_ch", newLine: true)

    // write a file from the combined process output
    GET_VALUE.out.id_tsv.collectFile(name: 'allSamples.allValues.tsv', storeDir: "${params.outdir}/GET_VALUE_collectFile")

    // generate a metMap for each sample
    meta_ch = GET_VALUE.out.id_num.map{ id, numFile ->
        // get the value from the text file and convert to int
        def num = numFile.text.strip().toInteger()
        // make a meta map out of it
        def meta = ["id":id, "value":num]
        return meta
    }


    // save each sample into a different file
    meta_ch.collectFile(storeDir: "${params.outdir}/samples") { meta ->
        def filename = "${meta.id}.json"
        def json_str = JsonOutput.toJson(meta)
        def json_indented = JsonOutput.prettyPrint(json_str)
        return [ filename, json_indented ]
    }

    // convert to single list of maps and save a final file for all samples
    meta_ch.collect()
        .collectFile(storeDir: "${params.outdir}/meta_ch") { mapList ->
                def filename = "allSamples.json"
                def json_str = JsonOutput.toJson(mapList)
                def json_indented = JsonOutput.prettyPrint(json_str)
                return [ filename, json_indented ]
            }

    // direct from a map Channel
    map_ch = Channel.of(
        ["id":"S1", "val":10],
        ["id":"S1", "val":20],
        ["id":"S2", "val":30],
        ["id":"S2", "val":40])
    // map_ch.collectFile(storeDir: "${params.outdir}", newLine: true) { meta ->
    //     def filename = "${meta.id}.txt"
    //     return [filename, meta.val.toString()]
    // }

    // save all the vals to a different file per Sample, in subdirs
    map_ch.collectFile(storeDir: "${params.outdir}/subdirs") { meta ->
        // create output dir ahead of time
        // https://github.com/nextflow-io/nextflow/issues/4409
        new File("${params.outdir}/subdirs/${meta.id}").mkdirs()
        def filename = "${meta.id}/${meta.id}.txt"
        return [filename, meta.val.toString()]
    }

}
