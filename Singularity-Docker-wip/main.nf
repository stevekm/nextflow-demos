process foo {
    debug true

    output:
    stdout

    script:
    """
    printf "hostname: %s\n" \$(hostname)
    printf "username: %s\n" \$(whoami)
    uname -a
    if [ -e /etc/os-release ]; then cat /etc/os-release; fi
    if which R; then which R; Rscript -e "library(ggplot2); print(.libPaths())"; fi
    """
}

workflow {
    foo()
}