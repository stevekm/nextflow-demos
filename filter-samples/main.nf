params.archiveType = "zip"

def input_samples = [
['Sample1', 1],
['Sample2', 2],
['Sample3', 3],
['Sample4', 4]
]

log.info "~~~~~ Starting Workflow ~~~~~"
log.info "archiveType: ${params.archiveType}"
log.info "input_samples: ${input_samples}"
log.info "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

sample_values = Channel.from(input_samples)

process create_file {
    // make a file with some contents
    tag "${sampleID}"
    echo true

    input:
    set val(sampleID), val(sampleVal) from sample_values

    output:
    set val(sampleID), file("${output_file}") into sample_files, sample_files2

    script:
    output_file = "${sampleID}.data.txt"
    """
    for i in \$(seq ${sampleVal}); do
        echo ${sampleID} >> "${output_file}"
    done
    """
}

// print to console the files that we created
sample_files2.subscribe { log.info "Got items: ${it} " }

// do not process anything with <2 lines
import java.nio.file.Files;
sample_files.filter { sampleID, sampleFile ->
    long count = Files.lines(sampleFile).count()
    if (count <= 1) log.warn "File for ${sampleID} has too few lines and will be removed"

    // "true" or "false"
    count > 1 // final statement in a closure is the return value
}.set { sample_files_filtered }



process create_archive {
    // make an archive for each sample's data
    tag "(${params.archiveType}) ${sampleID}"

    input:
    set val(sampleID), file(message_txt) from sample_files_filtered

    output:
    set val(sampleID), val("${params.archiveType}"), file("${output_file}") into archived_messages

    script:
    // alternate task execution based on input parameters
    if ( "${params.archiveType}" == "zip" ) {
        output_file = "${sampleID}.message.zip"
        """
        zip "${output_file}" "${message_txt}"
        """
    } else if ( "${params.archiveType}" == "tar" ) {
        output_file = "${sampleID}.message.tar.gz"
        """
        tar -czf "${output_file}" "${message_txt}"
        """
    } else {
        log.error "Unrecognized archiveType: ${params.archiveType}"
    }
}


process please_dont_break {
    // Sample2 is destined for failure!
    tag "${sampleID}"
    echo true
    errorStrategy "ignore"

    input:
    set val(sampleID), val(archiveType), file(archive_file) from archived_messages

    output:
    set val(archiveType), file(archive_file) into successful_messages

    script:
    """
    if [ "${sampleID}" == "Sample2" ]; then
        echo ">>> ERROR: ${sampleID} has failed!"
        exit 1
    fi
    """
}

// group all the items by archive type
// groups by first element in each set by default
// [ [ archiveType, archive_file ], [ archiveType, archive_file ], ...   ]
// becomes
// [ [ archiveType, [ archive_file, archive_file, ... ]], ... ]
successful_messages.groupTuple().set { grouped_messages }

process gather_files {
    echo true
    publishDir "output"

    input:
    set val(archiveType), file(items: '*') from grouped_messages

    output:
    file(items)

    script:
    """
    echo "Last step in the workflow! Got these ${archiveType} files:"
    echo "${items}"
    """
}
