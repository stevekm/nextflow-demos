process BAZZ {
    // this shows how custom methods dont work with `task` object inside
    // process directives, but `task` itself does with with process directives
    tag "${task.process}.${id}.tag" // THIS WORKS
    // tag Utils.customMessage("foobarbazz") // THIS WORKS
    // tag Utils.customMessage("${task.process}") // THIS DOESNT WORK
    // resourceLabels customLabel: Utils.customMessage("${task.process}") // THIS DOESNT WORK
    // NOTE: usage of someVar here will result in 'null'

    input:
    val(id)

    exec:
    someVar = "foooooo"
    println "--------- BAZZ start -----------"
    println ">>> BAZZ: ${id}"
    println Utils.customMessage("${task.process}.${someVar}") // custom method here works with both `task` and `someVar` objects
    println "--------- BAZZ end -----------"
}
