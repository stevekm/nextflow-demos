// filter based on character string
Channel.from( ['good','bad','ugly'] )
        .filter { item ->
            item != 'ugly'
        }
        .set { samples }

samples.subscribe { println "[samples] ${it}" }

// filter based on number of lines
Channel.from([
    ['demo1', file('input/demo1.tsv')],
    ['demo2', file('input/demo2.tsv')],
    ['demo3', file('input/demo3.tsv')]
    ])
    .filter { sampleID, sample_tsv ->
        // loads all lines in the file into memory, then counts
        long count = sample_tsv.readLines().size()
        if (count <= 1) println ">>> WARNING: file ${sample_tsv} does not have enough lines and will not be included"
        count > 1
    }
    .set { demo_tsvs }

demo_tsvs.subscribe { println "[demo_tsvs] ${it}" }


import java.nio.file.Files;
Channel.from([
    ['demo1', file('input/demo1.tsv')],
    ['demo2', file('input/demo2.tsv')],
    ['demo3', file('input/demo3.tsv')]
    ])
    .filter { sampleID, sample_tsv ->
        // using streams; may be better for large files
        long count = Files.lines(sample_tsv).count()
        if (count <= 1) println ">>> WARNING: file ${sample_tsv} does not have enough lines and will not be included"
        count > 1
    }
    .set { demo_tsvs2 }

demo_tsvs2.subscribe { println "[demo_tsvs2] ${it}" }

// filter .VCF file based on number of entries
Channel.from([
    ['bad1', file('input/bad1.vcf')],
    ['good1', file('input/good1.vcf')],
    ['good2', file('input/good2.vcf')]
    ])
    .filter { sampleID, sample_vcf ->
        line_count = 0
        num_variants = 0
        enough_variants = false
        // make sure that the VCF has at least 1 variant, then stop counting
        sample_vcf.withReader { reader ->
            while (line = reader.readLine()) {
                if (! line.startsWith("#")) num_variants++
                if (num_variants > 0) {
                    enough_variants = true
                    break
                    }
                line_count++
            }
        }
        println ">>> Read ${line_count} lines from file ${sample_vcf} and found ${num_variants} variants"
        if(! enough_variants) println ">>> WARNING: File ${sample_vcf} does not have enough variants and will not be included"
        enough_variants
    }
    .set { demo_vcfs }

demo_vcfs.subscribe { println "[demo_vcfs] ${it}" }
