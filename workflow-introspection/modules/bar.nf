process BAR {
    // this shows how to use custom methods inside a process
    tag "${task.process}.${id}.tag"

    input:
    val(id)

    exec:
    println "--------- BAR start -----------"
    println ">>> BAR: ${id}"
    println Utils.customMessage("${task.process}") // custom method here works with `task` object
    println task.resourceLabels.getClass()
    println "--------- BAR end -----------"
}
