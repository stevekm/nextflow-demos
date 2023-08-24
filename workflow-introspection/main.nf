nextflow.enable.dsl=2

// use a custom Groovy function
println Utils.customMessage("main.nf")

include { BAR } from './modules/bar.nf'
include { BAZZ } from './modules/bazz.nf'

process FOO {
    // this is a basic process to show how to dump out process task attributes
    tag "foo_bar_tag"

    exec:
    println "-------- FOO start ----------"
    println ">>> task.process: ${task.process}"
    println ">>> task.process.toLowerCase(): ${task.process.toLowerCase()}"
    println "${task.properties.sort{it.key}.collect{it}.join('\n')}"
    println "--------- FOO end -----------"
}

workflow {
    FOO()
    BAR("Sample1")
    BAZZ("Sample1")
    println "--------- workflow start -----------"
    println workflow
    println "${workflow.properties.sort{it.key}.collect{it}.join('\n')}"
    println "-------- workflow manifest properties ----------"
    println "${workflow.manifest.properties.sort{it.key}.collect{it}.join('\n')}"
    println "--------- workflow end -----------"
}