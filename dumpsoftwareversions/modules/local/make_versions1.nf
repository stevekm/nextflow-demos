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