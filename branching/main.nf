params.output_dir = "output"
Channel.from([
    ['demo1', file('input/demo1.tsv')],
    ['demo2', file('input/demo2.tsv')],
    ['demo3', file('input/demo3.tsv')]
    ])
    .set { demo_tsvs }

align_params = [
"foo",
"bar"
]
process align {
    publishDir "${params.output_dir}/${branch}", mode: "copy"
    tag "${prefix} - ${branch}"
    input:
    set val(sampleID), file(input_file) from demo_tsvs
    each param from align_params

    output:
    set val(branch), val(sampleID), file(output_file) into alignments

    script:
    prefix = "${sampleID}"
    branch = "align.${param}"
    output_file = "${prefix}.align.txt"
    """
    echo "${param}" > "${output_file}"
    """
}

dedup_params = [
"buz",
"baz"
]
process dedup {
    publishDir "${params.output_dir}/${branch_out}", mode: "copy"
    tag "${prefix} - ${branch_out}"

    input:
    set val(branch_in), val(sampleID), file(input_file) from alignments
    each param from dedup_params

    output:
    set val(branch_out), val(sampleID), file(output_file) into dedups

    script:
    prefix = "${sampleID}"
    branch_out = "dedup.${param}/${branch_in}"
    output_file = "${prefix}.dedup.txt"
    """
    echo "${param}" > "${output_file}"
    """
}

peaks_params = [
"aa",
"bb"
]
process peak_calling {
    publishDir "${params.output_dir}/${branch_out}", mode: "copy"
    tag "${prefix} - ${branch_out}"

    input:
    set val(branch_in), val(sampleID), file(input_file) from dedups
    each param from peaks_params

    output:
    set val(branch_out), val(sampleID), file(output_file) into peaks

    script:
    prefix = "${sampleID}"
    branch_out = "peaks.${param}/${branch_in}"
    output_file = "${prefix}.peaks.txt"
    """
    echo "${param}" > "${output_file}"
    """
}
