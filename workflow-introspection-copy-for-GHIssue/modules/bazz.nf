process BAZZ {
    // this shows how custom methods dont work with `task` object inside
    // process directives, but `task` itself does with with process directives
    // tag "${task.process}.${id}.tag" // THIS WORKS
    // tag {task.process}
    // tag Utils.customMessage("foobarbazz") // THIS WORKS
    // tag Utils.customMessage("zzz") + [ foo: "mmm"].foo // THIS DOESNT WORK
    // tag params.customMessage + [  foo:"${task.process}"].foo
    // tag Utils.customMessage({ "${task.process}" }) // THIS DOESNT WORK
    // resourceLabels customLabel: Utils.customMessage("${task.process}") // THIS DOESNT WORK
    // NOTE: usage of someVar here will result in 'null'
    resourceLabels fooKey: "${task.process}"

    input:
    val(id)

    exec:
    someVar = "foooooo"
    println ">>> BAZZ: ${id}" // `id` is accessible as expected
    println Utils.customMessage("${task.process}.${someVar}.${id}") // custom method here works with both `task` and `someVar` objects
}
