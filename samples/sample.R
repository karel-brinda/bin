#!/usr/bin/env Rscript

isRStudio <- Sys.getenv("RSTUDIO") == "1"
set.seed(42)

if (isRStudio) {

} else {
  pdf("plot.pdf",
      width = 5,
      height = 5)
}

df <- read.delim("data.txt", header = TRUE)







if (!isRStudio) {
  dev.off()
}
