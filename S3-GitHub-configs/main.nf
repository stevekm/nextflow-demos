nextflow.enable.dsl=2

workflow {
    println "hello world"
    println "params.local_val = ${params.local_val}"
    println "params.remote_val = ${params.remote_val}"
    println "params.remote_s3_val = ${params.remote_s3_val}"
}