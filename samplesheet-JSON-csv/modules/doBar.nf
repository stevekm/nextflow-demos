process BAR {
    tag "${meta.id} - ${arg}"
    debug true

    input:
    tuple val(meta), path(inputFile)
    each arg

    script:
    output_file = "${meta.id}.bar.${arg}.txt"
    """
    echo ">>> BAR: arg:${arg}, Sample: ${meta.id}, file: ${inputFile}"
    touch "${output_file}"
    """
}