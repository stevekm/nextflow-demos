process BAZ {
    // use a script from a module's bin dir
    debug true
    script:
    """
    echo "\$(baz.sh) inside BAZ process"
    echo "\$(bar.sh) inside BAZ process"
    """
}