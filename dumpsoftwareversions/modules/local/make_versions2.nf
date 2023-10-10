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