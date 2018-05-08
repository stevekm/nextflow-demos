// ~~~~~~~ CONFIG ~~~~~~ //
// create a timestamp
import java.text.SimpleDateFormat
Date now = new Date()
SimpleDateFormat timestamp_fmt = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss")
def timestamp = timestamp_fmt.format(now)

// parameters
params.output_dir = "output"
params.variants_file = "all-variants.tsv"
params.desired_variants = "desired_variants.txt"
params.splitsize = 4
params.runID = null
def runID
if ( params.runID == null ) {
    runID = timestamp
} else {
    runID = params.runID
}


// ~~~~~~~ INPUT ~~~~~~ //
Channel.fromPath(params.variants_file)
        .splitCsv(sep: "\t")
        .map { caller, sampleID, variants_path ->
            def variants_file = file(variants_path)
            return([ caller, sampleID, variants_file ])
        }
        .into { variants; variants2 }

Channel.fromPath(params.desired_variants).set { desired_variants_file }

// ~~~~~~~ WORKFLOW ~~~~~~ //
process update_table {
    tag "${prefix}"
    publishDir "${params.output_dir}/update_table", overwrite: true

    input:
    set caller, sampleID, variants_file from variants

    output:
    file("${output_file}") into updated_variants

    script:
    prefix = "${sampleID}.${caller}"
    output_file = "${prefix}.variants.tsv"
    """
    paste-col.py -i "${variants_file}" --header Run --value "${runID}" | \
    paste-col.py --header Sample --value "${sampleID}" | \
    paste-col.py --header VariantCaller --value "${caller}" > \
    "${output_file}"
    """
}

updated_variants.buffer( size: params.splitsize, remainder: true )
                .map { items ->
                return( [items] ) // return a nested list
                }
                .combine(desired_variants_file) // add the variants patterns file
                .set { split_updated_variants }

process split_combine_search {
    tag "${input_tables}"

    input:
    set file(input_tables: '*'), file(desired_variants) from split_updated_variants

    output:
    file("combined.variants.tsv") into combined_variants

    script:
    """
    concat-tables.py ${input_tables} | head -1 > combined.variants.tsv
    concat-tables.py ${input_tables} | \
    grep -f "${desired_variants}" >> combined.variants.tsv

    # simulate a long-running process
    sleep 10
    """
}

process final_combine {
    publishDir "${params.output_dir}/", overwrite: true

    input:
    file(input_tables: 'table?') from combined_variants.collect()

    output:
    file('final.variants.tsv')

    script:
    """
    concat-tables.py ${input_tables} > final.variants.tsv

    # simulate a long-running process
    sleep 10
    """
}
