nextflow.enable.dsl=2

process BAR {
    // this shows how to use custom methods inside a process
    tag "${task.process}.${id}.tag"

    input:
    val(id)

    exec:
    println "--------- BAR start -----------"
    println ">>> BAR: ${id}"
    println "task.resourceLabels: ${task.resourceLabels}"
    println "--------- BAR end -----------"
}


workflow {
    BAR(Channel.from(["Sample1"]))

}