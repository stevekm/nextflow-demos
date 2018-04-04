#!/usr/bin/env Rscript

print("the test.R script has been loaded")

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

# imported from tools.R
print(foo)

sessionInfo()
