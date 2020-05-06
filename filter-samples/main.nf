params.archiveType = "zip"

// make a file with some contents
process create_message {
    tag "${sampleID}"

    input:
    val(sampleID) from Channel.from(['Sample1', 'Sample2', 'Sample3', 'Sample4'])

    output:
    set val(sampleID), file("${output_file}") into messages, messages2

    script:
    output_file = "message.txt"
    """
    echo "${sampleID} says: Hello World" > "${output_file}"
    """
}

// print to console so we know we got the file and its message
process print_message {
    tag "${sampleID}"
    echo true

    input:
    set val(sampleID), file(message_txt) from messages

    output:
    set val(sampleID), file(message_txt) into printed_messages

    script:
    """
    printf "Got message for ${sampleID}: %s\n" "\$(cat ${message_txt})"
    """
}

// dont process anything called "Sample4"
good_samples = Channel.create()
bad_samples = Channel.create()

printed_messages.choice(good_samples, bad_samples){ items ->
    def sampleID = items[0]
    def message_txt = items[1]
    def output = 1 // bad by default
    if (sampleID != "Sample4") output = 0
    return(output)
}

bad_samples.subscribe{ sampleID, message_txt ->
    log.info "WARNING: bad sample was filtered out from downstream processing: ${sampleID}"
}

process create_archive {
    tag "(${params.archiveType}) ${sampleID}"

    input:
    set val(sampleID), file(message_txt) from good_samples

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


// Sample2 is destined for failure!
process please_dont_break {
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
