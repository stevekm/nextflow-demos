nextflow.enable.dsl=2

params.inputVcf = "data/multisample.vcf"

process VCF_FILTER {
    container "quay.io/biocontainers/bcftools:1.16--hfe4b78e_1"
    publishDir "output"

    input:
    path(vcf)

    output:
    path("output.vcf")

    script:
    """
    bcftools filter -e "INFO/DP>1000" "${vcf}" > output.vcf
    """
}

workflow {
    vcf_ch = Channel.fromPath("${params.inputVcf}")
    VCF_FILTER(vcf_ch)
}