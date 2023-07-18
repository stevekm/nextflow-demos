import groovy.json.JsonSlurper
nextflow.enable.dsl=2

process DIFF {
    // compare the two files
    input:
    tuple path(file1), path(file2)

    output:
    tuple path("output.json"), path(file1), path(file2), emit: pass_json

    script:
    // a passed diff will have empty output (no lines)
    // make sure set -e is not enabled or it will trigger an error condition
    """
    set +e

    res="\$( diff "${file1}" "${file2}" )"

    if [ "\$( printf '%s' "\$res" | wc -l )" -gt 0 ]; then
        echo '{"diff_pass": false}' > output.json
    else
        echo '{"diff_pass": true}' > output.json
    fi
    """
}

process USE_FILE {
    // put your custom commands here for processing the file
    debug true

    input:
    tuple path(file1), path(file2)

    script:
    """
    echo ">>> USE_FILE: ${file1} ${file2}"
    """
}

workflow {
    input_ch = Channel.from([
        [file("file1_R1.txt"), file("file1_R2.txt")], // should pass
        [file("file2_R1.txt"), file("file2_R2.txt")], // should not pass
    ])

    DIFF(input_ch)

    passed_ch = DIFF.out.pass_json.map{ jsonFile, file1, file2 ->
        // read the JSON file contents into a Groovy map object
        def jsonObj = new JsonSlurper().parseText(jsonFile.text)
        return [ jsonObj.diff_pass, file1, file2 ]
    }
    // check if the file pair passed diff or not
    .branch { passed, file1, file2 ->
        pass: passed == true
            return([file1, file2]) // return the files
        failed: passed == false
            def labels = file1.getFileName().toString() + " " + file2.getFileName().toString()
            return(labels) // return a message to print to a log
    }

    // save the failures to a log
    // OR pass them to some other `process`
    passed_ch.failed.collectFile(name: "failed.log", storeDir: ".", newLine: true)

    // do something useful with the files that passed
    USE_FILE(passed_ch.pass)
}