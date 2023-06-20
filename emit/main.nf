nextflow.enable.dsl=2

process DO_FOO {
    output:
    tuple val("hello"), path("foo.txt"), val("goodbye"), emit: foo_txt

    script:
    """
    touch foo.txt
    """
}

workflow {
    DO_FOO()
    DO_FOO.out.foo_txt.view()
}