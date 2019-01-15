Channel.from(['a', 'b', 'c']).into { input_ch; input_ch2 }

// global variable
output_files = [
    "task1": [
        "suffix": "bar",
        "ext": "txt"
        ],
    "task2": [
        "suffix": "baz",
        "ext": "txt",
        "tmpfile": "tmp"
        ]
]

def get_outputfile(task, key = "suffix"){
    // return suffix.ext by default, otherwise return only key value
    def process_name = task.process
    def filename
    if( key == "suffix"){
        filename = "${output_files[process_name][key]}.${output_files[process_name].ext}"
    } else {
        filename = "${output_files[process_name][key]}"
    }
    return(filename)
}

process task1 {
    tag "${sampleID}"
    input:
    val(sampleID) from input_ch

    script:
    output_bam = "${sampleID}.${get_outputfile(task)}"
    """
    echo "[task1] ${output_bam}"
    touch "${sampleID}.bam"
    """

}
process task2 {
    tag "${sampleID}"
    input:
    val(sampleID) from input_ch2

    script:
    output_bam = "${sampleID}.${get_outputfile(task)}"
    tmp_file = get_outputfile(task, key = "tmpfile")
    """
    echo "[task2] ${output_bam}, ${tmp_file}"
    touch "${sampleID}.bam"
    """
}
