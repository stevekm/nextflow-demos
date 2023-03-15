process foo {
    debug true

    output:
    stdout

    script:
    """
    hostname
    whoami
    uname -a
    if [ -e /etc/os-release ]; then cat /etc/os-release; fi
    """
}

workflow {
    foo()
}