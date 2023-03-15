params.cwl_dir = "cwl"
params.archive_type = "zip"
def cwl_dir = new File("${params.cwl_dir}").getCanonicalPath()

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
    jq -n --arg message "hello this is ${sampleID}" '{"message":\$message}' > input.json
    cwl-runner "${cwl_dir}/echo.cwl" input.json
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
    printf "Got message for sample ${sampleID} from file ${message_txt}: %s\n" "\$(cat ${message_txt})"
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
    println "WARNING: bad sample was filtered out: ${sampleID}"
}

// alternate task execution based on input parameters
// NOTE: this conditional can also be implemented less verbosely under the 'script' directive
if ( "${params.archive_type}" == "zip" ) {
    // create a zip archive from the message file
    process zip_message {
        tag "${sampleID}"

        input:
        set val(sampleID), file(message_txt) from good_samples

        output:
        set val(sampleID), val("${params.archive_type}"), file("${output_file}") into archived_messages

        script:
        output_file = "${sampleID}.message.zip"
        // zip foo.txt.zip foo.txt
        """
        jq -n --arg archive_output_file "${output_file}" \
        --arg archive_input_file "${message_txt}" \
        '{"archive_output_file":\$archive_output_file, \
        "archive_input_file": {"class": "File", "path":\$archive_input_file} }' \
        > input.json

        cwl-runner "${cwl_dir}/zip.cwl" input.json
        """
    }
} else if ( "${params.archive_type}" == "tar" ) {
    process tar_message {
        tag "${sampleID}"

        input:
        set val(sampleID), file(message_txt) from good_samples

        output:
        set val(sampleID), val("${params.archive_type}"), file("${output_file}") into archived_messages

        script:
        output_file = "${sampleID}.message.tar.gz"
        // tar -czf foo.txt.tar.gz foo.txt
        """
        jq -n --arg archive_output_file "${output_file}" \
        --arg archive_input_file "${message_txt}" \
        '{"archive_output_file":\$archive_output_file, \
        "archive_input_file": {"class": "File", "path":\$archive_input_file} }' \
        > input.json

        cwl-runner "${cwl_dir}/tar.cwl" input.json
        """
    }
}

// Sample2 is destined for failure!
process please_dont_break {
    tag "${sampleID}"
    echo true
    errorStrategy "ignore"

    input:
    set val(sampleID), val(archive_type), file(archive_file) from archived_messages

    output:
    set val(archive_type), file(archive_file) into successful_messages

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
    set val(archive_type), file(items: '*') from grouped_messages

    output:
    file(items)

    script:
    """
    echo "Got these files of type ${archive_type}:"
    echo "${items}"
    """
}
