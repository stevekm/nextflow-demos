nextflow.enable.dsl=2

// use a custom Groovy function
println Utils.customMessage("main.nf")

params.customMessage = Utils.customMessage("zzz")
include { BAZZ } from './modules/bazz.nf'

workflow {
    BAZZ("Sample1")
}