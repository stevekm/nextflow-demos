process BAZ {
    // use a script from a module's bin dir
    debug true
    script:
    """
    baz.sh
    echo "inside BAZ process"
    bar.sh
    echo "inside BAZ process"
    """
}