nextflow.enable.dsl=2

process split {
    input:
    tuple val(id), path(somefile)

    output:
    tuple val(id), path("lines.*")

    script:
    """
    split -l 1 -d ${somefile} lines.
    """
}

process modify_data {
    input:
    tuple val(id), path(somefile)

    output:
    tuple val(id), path("output.txt")

    script:
    """
    # some long difficult task that takes a long time that you want to run in parallel for each file
    paste ${somefile} <(echo ${id}) <(shuf -i 1-2000000000000 -n 1) > output.txt
    """
}

process combine_data {
    // also consider https://www.nextflow.io/docs/latest/operator.html#collectfile
    input:
    tuple val(id), path("input")

    output:
    tuple val(id), path(output_file)

    script:
    output_file = "${id}.txt"
    """
    cat input* > ${output_file}
    """
}

workflow {
    Channel.from([
        ["1", file("lines1.txt")],
        ["2", file("lines2.txt")],
        ["3", file("lines3.txt")],
        ]) \
    | split \
    | transpose \
    | modify_data \
    | groupTuple \
    | combine_data \
    | view()
}

// the channel contents look like this;
// | split \ // [ 1, [ lines.1, lines.2, ... ] ], ...
//     | transpose \ // [ 1, lines.1 ], [ 1, lines.2 ], ...
//     | modify_data \ // [ 1, output ], [ 1, output ], ...
//     | groupTuple \ // [ 1, [ output, output] ], ...
//     | combine_data \ // [ 1, 1.txt ],
//     | view()