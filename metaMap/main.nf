nextflow.enable.dsl=2

params.samplesheet = "samplesheet.csv"
params.foo_val = 1
params.bar_val = 2

process PRINT_META {
    debug true

    input:
    tuple val(meta), path(fastqR1), path(fastqR2)

    script:
    """
    echo ">>> PRINT_META sample: ${meta.id}, type: ${meta.type}"
    """
}

workflow {
    samples_ch = Channel.fromPath(params.samplesheet)
    .splitCsv(header: true)
    .map { row ->
        // the row object is already a Groovy map object

        // we can create a new map to hold meta information
        def meta = [:]
        def fastqR1 = file(row.FastqR1)
        def fastqR2 = file(row.FastqR2)

        // we can append specific fields from the row map using the Groovy subMap method
        meta = meta + row.subMap("SampleID", "SampleType", "Library")

        // if for whatever reason, the keys from the samplesheet row are not the ones we want to use
        // we can update the meta map
        meta.put("id", meta.get("SampleID"))
        meta.put("type", meta.get("SampleType"))
        meta.put("library", meta.get("Library"))

        // remove the old keys to keep the meta object lean
        meta.remove("SampleID")
        meta.remove("SampleType")
        meta.remove("Library")

        // we can add extra items from the global params map object, if you wanted to do that for some reason
        meta = meta + params.subMap("foo_val", "bar_val")

        return([meta, fastqR1, fastqR2])
    }
    .view()

    PRINT_META(samples_ch)

}