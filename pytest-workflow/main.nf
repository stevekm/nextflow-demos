nextflow.enable.dsl=2

process make_file {
    publishDir "output"
    output:
    path("output.txt")

    script:
    def output_file = "output.txt"
    """
    printf "foo\tbar\n" > output.txt
    printf "baz\tbuzz\n" >> output.txt
    """
}

workflow {
    make_file()
    make_file.out.view()
}