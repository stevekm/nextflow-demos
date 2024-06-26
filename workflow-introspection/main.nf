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

process BUZZ {
    tag "buzz_tag"

    script:
    """
    echo "-------- BUZZ start ----------"
    echo '${task.properties.sort{it.key}.collect{it}.join('\n')}'
    echo "--------- BUZZ end -----------"
    """
}

workflow {
    FOO()
    BAR("Sample1")
    BAZZ("Sample1")
    BUZZ()
    println "--------- workflow start -----------"
    println workflow
    println "${workflow.properties.sort{it.key}.collect{it}.join('\n')}"
    println "-------- workflow manifest properties ----------"
    println "${workflow.manifest.properties.sort{it.key}.collect{it}.join('\n')}"
    println "--------- workflow end -----------"
    // nextflow.trace.ReportObserver.renderPayloadJson()

    // reportObserver = new nextflow.trace.ReportObserver();
    // reportObserver.renderPayloadJson()
}

workflow.onComplete {
    println " --------- workflow.onComplete start -----------"

    println nextflow.Session

    // TODO: try out some of these methods...
    // println workflow
    // println "${workflow.properties.sort{it.key}.collect{it}.join('\n')}"
    // nextflow.trace.ReportObserver.renderPayloadJson()
    // reportObserver = new nextflow.trace.ReportObserver();
    //reportObserver.renderPayloadJson()

    println " --------- workflow.onComplete end -----------"
}
