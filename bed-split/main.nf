params.bedFile = "targets.bed"
params.splitBy = "chrom"
params.outputDir = "output"
params.numLines = 75
params.numFiles = 9

log.info "bedFile:   ${params.bedFile}"
log.info "outputDir: ${params.outputDir}"
log.info "numLines:  ${params.numLines}"
log.info "numFiles:  ${params.numFiles}"

Channel.fromPath("${params.bedFile}").into { targets_bed; targets_bed2; targets_bed3 }

// split the .bed file into a new file per-chromosome
process chrom_chunk {
    publishDir "${params.outputDir}/chrom", mode: 'copy'
    
    input:
    file(bedFile) from targets_bed
    
    output:
    file("*") into chrom_chunk_ch
    
    script:
    """
    split-bed-chrom.py "${bedFile}"
    """
}
chrom_chunk_ch.flatten()
    .map { targets ->
        def chunkType = "chrom"
        // get the label at the end of the filename; targets.bed.chr1 -> chr1
        def chunkLabel = targets.name.substring(targets.name.lastIndexOf('.') + 1) 
        println "[chrom_chunk] ${targets.name} -> ${chunkLabel}"
        
        return([ targets, chunkLabel, chunkType ])
    }.set { chrom_chunk_ch2 }

// split the .bed file into new files based on desired lines in each file
process line_chunk {
    publishDir "${params.outputDir}/line", mode: 'copy'
    
    input:
    file(bedFile) from targets_bed2
    
    output:
    file('*') into line_chunk_ch
    
    script:
    """
    split-bed-lines.py "${bedFile}" "${params.numLines}"
    """
}
line_chunk_ch.flatten()
    .map { targets ->
        def chunkType = "lines"
        // get number at the end of the file basename
        def chunkLabel = "${targets.name}".findAll(/\d*$/)[0] 
        println "[line_chunk] ${targets.name} -> ${chunkLabel}"
        
        return([ targets, chunkLabel, chunkType ])
    }.set { line_chunk_ch2 }


// split the .bed file based on the desired number of total split files
process file_chunk {
    publishDir "${params.outputDir}/file", mode: 'copy'
    
    input:
    file(bedFile) from targets_bed3
    
    output:
    file('*') into file_chunk_ch
    
    script:
    """
    split-bed-files.py "${bedFile}" "${params.numFiles}"
    """
}
file_chunk_ch.flatten()
    .map { targets ->
        def chunkType = "files"
        // get number at the end of the file basename
        def chunkLabel = "${targets.name}".findAll(/\d*$/)[0] 
        println "[file_chunk] ${targets.name} -> ${chunkLabel}"
        
        return([ targets, chunkLabel, chunkType])
    }.set { file_chunk_ch2 }




// conditionally use each of the target chunks based on the user specifications
process use_chrom_chunks {
    echo true

    input:
    set file(bedFile), val(chunkLabel), val(chunkType) from chrom_chunk_ch2
    
    when:
    params.splitBy == "chrom"
    
    output:
    file("${output_file}") into use_chrom_chunks_ch
    
    script:
    output_file = "${chunkType}.${chunkLabel}"
    """
    touch "${output_file}"
    """
}

process use_line_chunks {
    echo true

    input:
    set file(bedFile), val(chunkLabel), val(chunkType) from line_chunk_ch2
    
    when:
    params.splitBy == "lines"
    
    output:
    file("${output_file}") into use_line_chunks_ch
    
    script:
    output_file = "${chunkType}.${chunkLabel}"
    """
    touch "${output_file}"
    """
}

process use_file_chunks {
    echo true

    input:
    set file(bedFile), val(chunkLabel), val(chunkType) from file_chunk_ch2
    
    when:
    params.splitBy == "files"
    
    output:
    file("${output_file}") into use_file_chunks_ch
    
    script:
    output_file = "${chunkType}.${chunkLabel}"
    """
    touch "${output_file}"
    """
}

// collect all the results
process use_all_results {
    echo true
    input:
    file('*') from use_chrom_chunks_ch.mix(use_line_chunks_ch, use_file_chunks_ch).collect()
    
    script:
    """
    ls -1
    """
}
