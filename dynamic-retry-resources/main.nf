process run_task {
    tag "${task.attempt}"
    echo true

    script:
    """
    echo "task.attempt: ${task.attempt}"
    echo "task.memory: ${task.memory}"
    echo "task.time: ${task.time}"

    if [ "${task.attempt}" -lt "${params.maxRetries}" ]; then exit 1; fi
    """
}
