process CUSTOM_DUMPSOFTWAREVERSIONS {
    publishDir "${params.output_dir}/dumpsoftwareversions", mode: "copy"

    // Requires `pyyaml` which does not have a dedicated container but is in the MultiQC container
    container "quay.io/biocontainers/multiqc:1.14--pyhdfd78af_0"

    input:
    path versions

    output:
    path "software_versions.yml"    , emit: yml
    path "software_versions_mqc.yml", emit: mqc_yml
    path "versions.yml"             , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    template 'dumpsoftwareversions.py'
}
