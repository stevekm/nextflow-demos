#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.output_dir = "output"

include { CUSTOM_DUMPSOFTWAREVERSIONS } from './modules/nf-core/custom/dumpsoftwareversions/main.nf'
include { MULTIQC                                        } from './modules/nf-core/multiqc/main.nf'

process MAKE_VERSIONS1 {
    publishDir "${params.output_dir}/make_version_1", mode: "copy"
    container "ubuntu:22.04"

    input:
    val(id)

    output:
    path(output_filename), emit: versions

    script:
    // NOTE: the versions filename is usually versions.yml but we are renaming it here for clarity
    output_filename = "versions.${id}.yml"
    """
    cat <<-END_VERSIONS > "${output_filename}"
    "${task.process}":
        MAKE_VERSIONS1: \$(echo fooVersion)
        container: "${task.container}"
    END_VERSIONS
    """
}

process MAKE_VERSIONS2 {
    publishDir "${params.output_dir}/make_version_2", mode: "copy"
    container "ubuntu:22.04"

    input:
    val(id)

    output:
    path(output_filename), emit: versions

    script:
    output_filename = "versions.${id}.yml"
    """
    cat <<-END_VERSIONS > "${output_filename}"
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

    // its assumed that all versions files from individual processes will be identical so just use the first one of each
    ch_versions = ch_versions.mix(MAKE_VERSIONS1.out.versions.first())
    ch_versions = ch_versions.mix(MAKE_VERSIONS2.out.versions.first())

    CUSTOM_DUMPSOFTWAREVERSIONS (
        ch_versions.unique().collectFile(name: 'collated_versions.yml', storeDir: "${params.output_dir}/ch_versions")
    )

    version_yaml = CUSTOM_DUMPSOFTWAREVERSIONS.out.mqc_yml.collect()
    // version_yaml.view()

    multiqc_files = Channel.empty()
    multiqc_files = multiqc_files.mix(version_yaml)
    multiqc_files.view()

    MULTIQC(multiqc_files.collect(), [], [], [])

}