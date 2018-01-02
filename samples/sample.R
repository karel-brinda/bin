#! /usr/bin/env python3

#!/usr/bin/env Rscript

isRStudio <- Sys.getenv("RSTUDIO") == "1"
set.seed(42)

if (isRStudio){
    srcFile = "table.tsv"
} else {

    args <- commandArgs(trailingOnly = TRUE)
    srcFile <- args[1]
    outFile <- args[2]

    pdf(outFile,
        width=8,
        height=8
        )
}

df <- read.delim(srcFile, header = TRUE)

x= plot(df)


# title
title(
  main="t",
  line=0.2
)

# subtitle
title(
  main=list("sub",cex=0.7),
  line=-0.8,
  cex=0.5
)

mtext(
  "Y",
  side=2,
  line=1,
  cex.lab=2,
  las=3
)

mtext(
  side=1,
  text="Y",
  line=1.8,
  adj=0,
  cex=0.80
)

if (! isRStudio){
    dev.off()
}

