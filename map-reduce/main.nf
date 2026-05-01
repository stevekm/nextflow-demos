// https://community.seqera.io/t/recursion-in-workflow-control/659
// https://github.com/nextflow-io/nextflow/discussions/2521

process MERGE_FILES {
    debug true
    input:
    path(input_files, stageAs: "input*")

    output:
    path("output.txt"), emit: merged
    script:
    """
    merge_files.sh $input_files
    """
}

workflow ROUND1 {
    take:
        input_ch

    emit:
        output_ch

    main:
        MERGE_FILES(input_ch)
        output_ch = MERGE_FILES.out.merged
}


workflow ROUND2 {
    take:
        input_ch

    emit:
        output_ch

    main:
        MERGE_FILES(input_ch)
        output_ch = MERGE_FILES.out.merged
}

workflow ROUND3 {
    take:
        input_ch

    emit:
        output_ch

    main:
        MERGE_FILES(input_ch)
        output_ch = MERGE_FILES.out.merged
}

workflow {
    input_files_ch = Channel.from(
        file("input/file1.txt"),
        file("input/file2.txt"),
        file("input/file3.txt"),
        file("input/file4.txt"),
        file("input/file5.txt"),
        file("input/file6.txt"),
        file("input/file7.txt"),
        file("input/file8.txt"),
        file("input/file9.txt"),
        ).buffer(size: 2, remainder: true)
    // input_files_ch.view()

    ROUND1(input_files_ch)
    results1 = ROUND1.out.output_ch

    // use fixed number of iterations
    // since true recursion is not fully supported in Nextflow
    ROUND2(results1.buffer(size: 2, remainder: true))
    results2 = ROUND2.out.output_ch
    // results2.view()

    ROUND3(results2.buffer(size: 2, remainder: true))
    results3 = ROUND3.out.output_ch

    // final merge all remaining tables
    MERGE_FILES(results3.collect())
    MERGE_FILES.out.merged.view()
}