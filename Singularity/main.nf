process demo {
    echo true
    input:
    val(x) from Channel.from('')

    script:
    """
    env
    echo "NTHREADS is \${NTHREADS:-not set}"
    """
}
