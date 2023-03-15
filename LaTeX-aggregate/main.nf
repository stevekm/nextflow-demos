Channel.from(["foo", "bar", "baz"]).set { words }
params.outputDir = "output"
params.reportTex = "report.tex"
Channel.fromPath("${params.reportTex}").set { reportTex }

// make demo PDF with input contents
process print_word {
    tag "${word}"

    input:
    val(word) from words

    output:
    file("texput.pdf") into pdfs

    script:
    """
    echo '\\shipout\\hbox{${word}}\\end' | pdftex
    """
}

// aggregate all the pdfs output and combine with report template
pdfs.collect().toList().set { all_pds }

// compile the report
process make_report {\
    publishDir "${params.outputDir}/"

    input:
    set file(report), file('fig?.pdf') from reportTex.combine(all_pds)

    output:
    file("report.pdf")

    script:
    """
    pdflatex "${report}"
    """
}
