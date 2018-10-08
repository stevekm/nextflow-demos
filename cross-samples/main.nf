Channel.fromFilePairs("samples/**{.bam,.bam.bai}").map{ sampleID, items ->
    def bamfile = items[0]
    def baifile = items[1]
    return([sampleID, bamfile, baifile])
}
.set { sample_bams }

Channel.fromPath("samples/**.HaplotypeCaller.vcf")
.map { path ->
    def dirpath = new File("${path}").parent
    def dirname = new File("${dirpath}").name
    def sampleID = "${dirname}"
    def caller = "HaplotypeCaller"
    return([sampleID, caller, path])
}.set { hc_vcfs }

Channel.fromPath("samples/**.LoFreq.vcf")
.map { path ->
    def dirpath = new File("${path}").parent
    def dirname = new File("${dirpath}").name
    def sampleID = "${dirname}"
    def caller = "LoFreq"
    return([sampleID, caller, path])
}.set { lofreq_vcfs }

hc_vcfs.concat(lofreq_vcfs)
.combine(sample_bams)
.filter { items ->
    def sampleID_vcf = items[0]
    def sampleID_bam = items[3]
    sampleID_vcf == sampleID_bam
}
.map { sampleID_vcf, caller, vcf, sampleID_bam, bam, bai ->
    return([sampleID_vcf, caller, vcf, bam, bai])
}
.println()

// [Sample3, HaplotypeCaller, /samples/Sample3/Sample3.HaplotypeCaller.vcf, /samples/Sample3/Sample3.bam, /samples/Sample3/Sample3.bam.bai]
// [Sample2, HaplotypeCaller, /samples/Sample2/Sample2.HaplotypeCaller.vcf, /samples/Sample2/Sample2.bam, /samples/Sample2/Sample2.bam.bai]
// [Sample1, HaplotypeCaller, /samples/Sample1/Sample1.HaplotypeCaller.vcf, /samples/Sample1/Sample1.bam, /samples/Sample1/Sample1.bam.bai]
// [Sample3, LoFreq, /samples/Sample3/Sample3.LoFreq.vcf, /samples/Sample3/Sample3.bam, /samples/Sample3/Sample3.bam.bai]
// [Sample2, LoFreq, /samples/Sample2/Sample2.LoFreq.vcf, /samples/Sample2/Sample2.bam, /samples/Sample2/Sample2.bam.bai]
// [Sample1, LoFreq, /samples/Sample1/Sample1.LoFreq.vcf, /samples/Sample1/Sample1.bam, /samples/Sample1/Sample1.bam.bai]
