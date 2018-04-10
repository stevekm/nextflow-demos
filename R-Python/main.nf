Channel.from(["Sample1"]).into { samples; samples2; samples3; samples4; samples5 }
params.output_dir = "output"

process test_R {
    tag "${sample}"
    echo true

    input:
    val(sample) from samples

    script:
    """
    echo "[test_R] \$(test.R)"
    """
}

process test_Python {
    tag { "${sample}" }
    echo true

    input:
    val(sample) from samples2

    script:
    """
    echo "[test_Python] \$(test.py)"
    """
}

process Python_inline {
    tag "${sample}"
    echo true

    input:
    val(sample) from samples3

    script:
    """
    #!/usr/bin/env python
    import os
    import sys

    # allow for import 'tools' from Nextflow bin directory, which is prepended to PATH
    nextflow_bin = os.environ['PATH'].split(os.pathsep)[0]
    sys.path.insert(0, nextflow_bin)
    import tools

    x = "${sample}"
    print("[Python_inline] the sample is: {}".format(x))
    """
}

process Python_args {
    echo true

    input:
    val(all_samples) from samples4.collect()

    script:
    """
    python - ${all_samples} <<E0F
import sys
print("[Python_args] {0}".format(sys.argv))
E0F
    """
}


process R_inline {
    tag "${sample}"
    echo true

    input:
    val(sample) from samples5

    script:
    """
    #!/usr/bin/env Rscript

    # source the 'tools' script in the bin dir
    tryCatch({
        source("tools.R")
    },
    error=function(cond) {
        # try to source from PATH
        path <- Sys.getenv('PATH')
        bin_dir <- unlist(strsplit(x = path, split = ':'))[1]
        source(file.path(bin_dir, "tools.R"))
    })

    x <- "${sample}"
    print(sprintf("[R_inline] the sample is: %s", x))
    """
}
