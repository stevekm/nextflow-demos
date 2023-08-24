#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include { CUSTOM_DUMPSOFTWAREVERSIONS } from './modules/nf-core/custom/dumpsoftwareversions/main.nf'
include { MULTIQC                                        } from './modules/nf-core/multiqc/main.nf'

process MAKE_VERSIONS1 {
    input:
    val(id)

    output:
    path("versions.yml"), emit: versions

    script:
    """
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        MAKE_VERSIONS1: \$(echo fooVersion)
        container: "${task.container}"
    END_VERSIONS
    """
}

process MAKE_VERSIONS2 {
    input:
    val(id)

    output:
    path("versions.yml"), emit: versions

    script:
    """
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        MAKE_VERSIONS2: \$(echo barVersion)
        container: "${task.container}"
    END_VERSIONS
    """
}

workflow {
    input_ch = Channel.from([1,2,3,4,5])
    ch_versions = Channel.empty()
    version_yaml = Channel.empty()

    MAKE_VERSIONS1(input_ch)
    MAKE_VERSIONS2(input_ch)

    ch_versions = ch_versions.mix(MAKE_VERSIONS1.out.versions.first())
    ch_versions = ch_versions.mix(MAKE_VERSIONS2.out.versions.first())

    CUSTOM_DUMPSOFTWAREVERSIONS (
        ch_versions.unique().collectFile(name: 'collated_versions.yml')
    )

    version_yaml = CUSTOM_DUMPSOFTWAREVERSIONS.out.mqc_yml.collect()

    multiqc_files = Channel.empty()
    multiqc_files = multiqc_files.mix(version_yaml)

    MULTIQC(multiqc_files.collect(), [], [], [])

}