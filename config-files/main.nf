process run_task {
    echo true
    tag "main.nf"
    memory = 3.MB
    time = "3m"

    script:
    """
    echo "task.memory: ${task.memory}"
    echo "task.time: ${task.time}"
    """
}
