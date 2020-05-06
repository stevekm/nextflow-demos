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
    container "python:3"

    input:
    set val(numerator), val(denominator) from some_values

    script:
    """
    divide.py "${numerator}" "${denominator}"
    """
}
