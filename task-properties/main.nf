nextflow.enable.dsl=2

// allow to set the --max value from CLI
params.max = "2"
def max = "${params.max}" as int

process run_task {
    echo true

    // dummy input value so we can more easily call multiple parallel instances of the task
    input:
    val(x)

    script:
    // // you can also just print the task properties directly from within Groovy with this;
    // println task.properties.sort{it.key}.collect{it}.findAll{!['class', 'active'].contains(it.key)}.join('\n')
    """
    printf '%s\n%s\n%s\n%s\n%s\n\n' 'x: ${x}' 'task: ${task}' 'workflow: ${workflow}' 'all task properties: ${task.properties.sort{it.key}.collect{it}.findAll{!['class', 'active'].contains(it.key)}.join('\n')}'
    """
}

workflow {
    // start two parallel instances of the task
    run_task(Channel.fromList(1..max))
}
