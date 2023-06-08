import groovy.json.JsonSlurper
nextflow.enable.dsl=2

params.inputJSON = "input.json"


// example of a Groovy function defined in-line with the main.nf workflow file
// https://www.nextflow.io/docs/latest/dsl2.html#function
def UpdateMap (inputMap) {
    // its a good practice in Nextflow workflows to never modify a map object
    // but instead return a new updated map
    // to avoid potential issues with shared memory access across Channels and processes
    def outputMap = [:]
    outputMap << inputMap
    outputMap["foo"] = "bar"
    return outputMap
}


process ECHO {
    debug true
    input:
    val(meta)

    script:
    newMeta = Utils.updateMap2(meta)
    """
    echo 'ECHO process: ${newMeta}'
    """
}

workflow {
    // show that our external methods file is working
    Utils.hello()

    // load the input JSON; a map with key "samples" that contains a list of sample metadata
    contents = file(params.inputJSON).text
    inputMap = new JsonSlurper().parseText(contents)
    println "inputMap: ${inputMap}"

    // use the imported external function method inside of a Channel map
    samples_ch = Channel.from(inputMap.samples)
    .map { sampleMap ->
        // use the inline Groovy function on it
        def newMap = UpdateMap(sampleMap)
        return Utils.updateMap(newMap)
    }.view()

    ECHO(samples_ch)
}