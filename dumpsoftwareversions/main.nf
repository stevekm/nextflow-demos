#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.output_dir = "output"

include { CUSTOM_DUMPSOFTWAREVERSIONS } from './modules/nf-core/custom/dumpsoftwareversions/main.nf'
include { MULTIQC                                        } from './modules/nf-core/multiqc/main.nf'
include { MAKE_VERSIONS } from  './workflows/make_versions.nf'

workflow {
    // input_ch = Channel.from([1,2,3,4,5])
    ch_versions = Channel.empty()
    version_yaml = Channel.empty()

    // MAKE_VERSIONS1(input_ch)
    // MAKE_VERSIONS2(input_ch)
    MAKE_VERSIONS()

    // its assumed that all versions files from individual processes will be identical so just use the first one of each
    ch_versions = ch_versions.mix(MAKE_VERSIONS.out.version1.first())
    ch_versions = ch_versions.mix(MAKE_VERSIONS.out.version2.first())

    CUSTOM_DUMPSOFTWAREVERSIONS (
        ch_versions.unique().collectFile(name: 'collated_versions.yml', storeDir: "${params.output_dir}/ch_versions")
    )

    version_yaml = CUSTOM_DUMPSOFTWAREVERSIONS.out.mqc_yml.collect()
    // version_yaml.view()

    multiqc_files = Channel.empty()
    multiqc_files = multiqc_files.mix(version_yaml)

    MULTIQC(multiqc_files.collect(), [], [], [])

}