Channel.from( ['Sample1','Sample2','Sample3', 'Sample4'] ).into { samples; samples2; samples3 }

process make_file1 {
    tag "${sampleID}"

    input:
    val(sampleID) from samples

    output:
    set val(sampleID), file("${output_file}") into sample_file1

    script:
    output_file = "${sampleID}.file1.txt"
    """
    echo "[make_file1] ${sampleID}" > "${output_file}"
    """
}
sample_file1.filter{ sampleID, sampleFile ->
    if( "${sampleID}" == 'Sample1' | "${sampleID}" == 'Sample2' ){
        return true
    } else {
        return false
    }
}
.tap { sample_file1_filtered }
// .subscribe { println "[sample_file1] ${it}" }


process make_file2 {
    tag "${sampleID}"

    input:
    val(sampleID) from samples2

    output:
    set val(sampleID), file("${output_file}") into sample_file2

    script:
    output_file = "${sampleID}.file2.txt"
    """
    echo "[make_file2] ${sampleID}" > "${output_file}"
    """
}
sample_file2.filter{ sampleID, sampleFile ->
    if( "${sampleID}" != 'Sample3' ){
        return true
    } else {
        return false
    }
}
.tap { sample_file2_filtered }
// .subscribe { println "[sample_file2] ${it}" }

samples3.map { sampleID ->
    // add a placeholder file to fix channel cardinality for grouping
    def placeholder = file('.placeholder')
    return([ sampleID, placeholder ])
}
// add the output from the other channels
.concat(sample_file1_filtered, sample_file2_filtered)
.groupTuple()
.map { sampleID, fileList ->
    // demonstrate Groovy list manipulation in for loop, for more complex processing
    def i = fileList.iterator()
    while (i.hasNext()) {
        def item = i.next()
        def item_name = item.name
        if( "${item_name}" == ".placeholder" ){
            println "${item} will be removed from the list"
            // i.remove()
        }
    }

    // remove the 'placeholder' files from the list inplace for simpler operation
    def newFileList = fileList.findAll { it.name != ".placeholder" }

    return([ sampleID, newFileList ])
}
.tap { all_samples_files }
// .subscribe { println "[concat] ${it}" }


process collect_all_files {
    echo true

    input:
    set val(sampleID), file(sampleFiles: "*") from all_samples_files

    script:
    """
    echo "[collect_all_files] ${sampleID}: got these files: ${sampleFiles}"

    # do things with files here
    """
}
