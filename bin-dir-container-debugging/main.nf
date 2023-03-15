def values_list = [
[3, 2],
[4, 2],
[1, 0]
]

log.info "~~~~~ Starting Workflow ~~~~~"
log.info "values_list: ${values_list}"
log.info "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

some_values = Channel.from(values_list)

process divide {
    echo true
    container "python:3" // Docker container

    input:
    set val(numerator), val(denominator) from some_values

    script:
    """
    # check that we are actually inside the container
    cat /etc/*release

    divide.py "${numerator}" "${denominator}"
    """
}
