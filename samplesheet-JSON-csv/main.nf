nextflow.enable.dsl=2

include { BAR } from './modules/doBar.nf'
include { FOO } from './modules/doFoo.nf'

workflow {
    // add items passed in from -params-file
    input_ch = Channel.from(params.samples)
        .map { record ->
            def metaMap = record.subMap(["id", "type", "species", "arg1", "doBar"])

            return [ metaMap, file(record.file) ]
        }
    // add items from default params evaluation
    bar_args_ch = Channel.from(params.barArgs)

    // add items passed in from inputCsv samplesheet
    if ( params.inputCsv ) {
        csv_ch = Channel.fromPath(params.inputCsv)
            .splitCsv(header:true)
            .map { row ->
                def metaMap = row.subMap(["id", "type", "species", "arg1", "doBar"])

                // naive boolean parsing
                if (metaMap.doBar.toLowerCase() == "true"){
                    metaMap.doBar = true
                } else {
                    metaMap.doBar = false
                }

                return [ metaMap, file(row.file) ]
            }

        input_ch = input_ch.mix(csv_ch)
    }

    // add items from separate barArgs file
    if ( params.barArgsTxt ) {
        txt_ch = Channel.fromPath(params.barArgsTxt)
            .splitText()
            .map { arg ->
            // remove whitespace
            return [ arg.trim() ]
            }
        bar_args_ch = bar_args_ch.mix(txt_ch)
    }

    // only use the samples with Bar enabled
    bar_samples_ch = input_ch.filter { meta, file ->
        return meta.doBar // must be a boolean type for this to work properly
    }

    // do FOO on all samples
    FOO(input_ch)

    // do BAR only on filtered samples, repeat for all input Bar args
    BAR(bar_samples_ch, bar_args_ch.collect())


}