process FOO {
    tag "${meta.id}"
    debug true

    input:
    tuple val(meta), path(inputFile)

    output:
    path(output_file)

    script:
    output_file = "${meta.id}.foo.txt"
    """
    echo ">>> FOO: arg:${meta.arg1}, Sample: ${meta.id}, file: ${inputFile}"
    touch "${output_file}"
    """
}