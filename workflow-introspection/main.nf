nextflow.enable.dsl=2

process FOO {
    tag "foo_bar_tag"

    exec:
    println "-------- task properties ----------"
    println ">>> task.process: ${task.process}"
    println ">>> task.process.toLowerCase(): ${task.process.toLowerCase()}"
    println "${task.properties.sort{it.key}.collect{it}.join('\n')}"
    println "--------------------"
}

workflow {
    FOO()
    println "--------- workflow properties -----------"
    println workflow
    println "${workflow.properties.sort{it.key}.collect{it}.join('\n')}"
    println "-------- manifest properties ----------"
    println "${workflow.manifest.properties.sort{it.key}.collect{it}.join('\n')}"
}