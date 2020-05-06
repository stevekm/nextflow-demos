log.info "~~~~ Starting Workflow Configuration ~~~~~"
log.info "memory: ${params.memory}"
log.info "time: ${params.time}"
log.info "maxRetries: ${params.maxRetries}"
log.info "errorStrategy: ${params.errorStrategy}"
log.info "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

process run_task {
    tag "attempt ${task.attempt}"
    echo true

    script:
    """
    echo "task.attempt: ${task.attempt}"
    echo "task.memory: ${task.memory}"
    echo "task.time: ${task.time}"

    if [ "${task.attempt}" -lt "${params.maxRetries}" ]; then exit 1; fi
    """
}
