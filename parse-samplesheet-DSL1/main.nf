params.samplesheet = "samples.analysis.tsv"

Channel.fromPath( file(params.samplesheet) )
        .splitCsv(header: true, sep: '\t')
        .map{row ->
            def sample_ID = row['Sample']
            def reads1 = row['R1'].tokenize( ',' ).collect { file(it) } // comma-sep string into list of files
            def reads2 = row['R2'].tokenize( ',' ).collect { file(it) }
            return [ sample_ID, reads1, reads2 ]
        }
        .tap { samples_R1_R2; samples_R1_R2_2 } // set of all fastq R1 R2 per sample
        .map { sample_ID, reads1, reads2 ->
            return [ reads1, reads2 ]
        }
        .flatMap().flatMap()
        .into { samples_each_fastq; samples_each_fastq2 } // emit each fastq file individually, no sampleID


samples_R1_R2.subscribe { println "\n[samples_R1_R2] ${it}\n"}
samples_each_fastq.subscribe { println "[samples_each_fastq] ${it}"}

process each_fastq {
    tag "${fastq}"
    echo true

    input:
    file(fastq) from samples_each_fastq2

    script:
    """
    echo "[each_fastq] got file: ${fastq}"
    """
}

process fastq_pairs {
    tag { "${sampleID}" }
    echo true

    input:
    set val(sampleID), file(fastqR1: "*"), file(fastqR2: "*") from samples_R1_R2_2

    script:
    """
    printf "[fastq_pairs] sample ${sampleID}\nR1: ${fastqR1}\nR2: ${fastqR2}\n"
    """
}
