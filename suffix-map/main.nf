Channel.from( ['Sample1','Sample2','Sample3', 'Sample4'] ).into { samples; samples2; samples3 }

suffix_key = [:]

file1_suffix = "file1.txt"
suffix_key['file1'] = file1_suffix
process make_file1 {
    tag "${sampleID}"

    input:
    val(sampleID) from samples

    output:
    set val(sampleID), file("${output_file}") into sample_file1

    script:
    output_file = "${sampleID}.${file1_suffix}"
    """
    echo "[make_file1] ${sampleID}" > "${output_file}"
    """
}

file2_suffix = "file2.txt"
suffix_key['file2'] = file2_suffix
process make_file2 {
    tag "${sampleID}"

    input:
    val(sampleID) from samples2

    output:
    set val(sampleID), file("${output_file}") into sample_file2

    script:
    output_file = "${sampleID}.${file2_suffix}"
    """
    echo "[make_file2] ${sampleID}" > "${output_file}"
    """
}

sample_file1.concat(sample_file2)
.groupTuple()
.tap { all_sample_files }
.subscribe { println "${it}" }
process collect_all_files {
    echo true

    input:
    set val(sampleID), file(all_files: "*") from all_sample_files

    script:
    """
    printf "
    [collect_all_files] ${sampleID}:  ${all_files}\n
    file1 suffix: ${suffix_key['file1']}, file2 suffix: ${suffix_key['file2']}
    "
    """
}

println "suffix_key: ${suffix_key}"
