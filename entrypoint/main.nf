nextflow.enable.dsl=2

// $ nextflow run main.nf
// $ nextflow run main.nf -entry run_one

// https://www.nextflow.io/docs/latest/dsl2.html#workflow
// https://www.nextflow.io/docs/latest/dsl2.html#workflow-entrypoint
// https://www.nextflow.io/docs/latest/cli.html#run

params.inputFile = "file.txt"
params.outputDir = "output"
input_ch = Channel.from(file(params.inputFile))

process FILTER_1 {
    publishDir "${params.outputDir}", mode: 'copy'

    input:
    path(input_file)

    output:
    path(output_file)

    script:
    output_file = "output.1.txt"
    """
    grep -v 1 "${input_file}" > "${output_file}"
    """
}


process FILTER_FOO {
    publishDir "${params.outputDir}", mode: 'copy'

    input:
    path(input_file)

    output:
    path(output_file)

    script:
    output_file = "output.foo.txt"
    """
    grep -v foo "${input_file}" > "${output_file}"
    """
}


workflow one_filter {
    take:
    input_data

    main:
    FILTER_1(input_data)

    emit:
    filtered = FILTER_1.out
}

workflow foo_filter {
    take:
    input_data

    main:
    FILTER_FOO(input_data)

    emit:
    filtered = FILTER_FOO.out
}

workflow run_one_foo {
    one_filter(input_ch)
    foo_filter(one_filter.out.filtered)
}

workflow run_one {
    one_filter(input_ch)
}

// default entrypoint
workflow {
    run_one_foo()
}