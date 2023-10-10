process STEVE_DUMPSOFTWAREVERSIONS {
    publishDir "${params.output_dir}/steve-dumpsoftwareversions", mode: "copy"
    container "stevekm/dump-software-versions:0.1"

    input:
    path(versionsYAMLFile)

    output:
    path(output_filename), emit: mqc_yml

    script:
    // NOTE: need this filename for use with MultiQC
    output_filename = "software_versions_mqc.yml"
    // NOTE: hard-coding the "version" for the current process since the dumpSoftwareVersions tool doesnt have that internally yet
    """
    dumpSoftwareVersions \
    -manifestName "${workflow.manifest.name}" \
    -manifestVersion "${workflow.manifest.version}" \
    -nxfVersion "${workflow.nextflow.version}" \
    -processLabel "${task.process}" \
    "${versionsYAMLFile}" > "${output_filename}"

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        STEVE_DUMPSOFTWAREVERSIONS: 0.1
        container: "${task.container}"
    END_VERSIONS
    """
}