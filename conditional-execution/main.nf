Channel.fromPath( "input/fastq/*.fastq.gz" )
        .filter { "${it}".contains("_L004_") } // remove files from Lane 4; filename contains '_L004_'
        .into { input_files; input_files2 }

// contrived example
process analyze_HapMaps {
    tag "${fastq}"
    echo true

    input:
    file(fastq) from input_files

    // only execute process if the filename contains 'HapMap'
    when:
    fastq.name.contains("HapMap")

    // run different commands based on 'params.mode' variable from profile
    script:
    if( params.mode == 'foo' )
        """
        echo "[analyze_HapMaps] running foo script on file: ${fastq}"
        """

    else if( params.mode == 'bar' )
        """
        echo "[analyze_HapMaps] running bar script on file: ${fastq}"
        """

    else if( params.mode == 'baz' )
        """
        echo "[analyze_HapMaps] running baz script on file: ${fastq}"
        """

    else
        error "Invalid mode: ${params.mode}"

}

// mock variant calling & downstream processing with different tools
callers = ['LoFreq', 'HaplotypeCaller', 'MuTect2']
process call_variants {
    tag "${fastq}"
    echo true

    input:
    file(fastq) from input_files2
    each caller from callers

    output:
    set val(caller), file(fastq) into variant_calls

    script:
    if( caller == "LoFreq" )
        """
        echo "[call_variants] running LoFreq on ${fastq}"
        """
    else if( caller == 'HaplotypeCaller' )
        """
        echo "[call_variants] running HaplotypeCaller on ${fastq}"
        """
    else if( caller == 'MuTect2' )
        """
        echo "[call_variants] running MuTect2 on ${fastq}"
        """
    else
        error "Invalid caller: ${caller}"
}

process annotate_variants {
    tag "${fastq}"
    echo true

    input:
    set val(caller), file(fastq) from variant_calls

    script:
    if( caller == "LoFreq" )
        """
        echo "[annotate_variants] annotating variants from LoFreq on ${fastq}"
        """
    else if( caller == 'HaplotypeCaller' )
        """
        echo "[annotate_variants] annotating variants from HaplotypeCaller on ${fastq}"
        """
    else if( caller == 'MuTect2' )
        """
        echo "[annotate_variants] annotating variants from MuTect2 on ${fastq}"
        """
    else
        error "Invalid caller: ${caller}"
}
