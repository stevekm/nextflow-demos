// nextflow.enable.moduleBinaries = true // this does not work yet but will soon in Nextflow 24.10

include { BAZ } from './modules/baz/main.nf'

process FOO {
    debug true
    script:
    """
    echo this is foo nextflow process
    """
}

process BAR {
    // use a script from the top-level bin dir
    debug true
    script:
    """
    echo "\$(bar.sh) inside BAR process"
    """
}

process BUZZ {
    // try to use the module script outside the module; should break
    tag "shouldBreak"
    debug true
    errorStrategy 'ignore'
    script:
    """
    baz.sh
    """
}


workflow {
    FOO()
    BAR()
    BAZ()
    BUZZ()
}