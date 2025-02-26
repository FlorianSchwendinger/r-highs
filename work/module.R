q("no")
R

# destdir <- normalizePath("~/pkgs")
# download.packages("inline", destdir = destdir, repos = "https://cran.wu.ac.at", method = "libcurl")
# install.packages("inline", repos = "https://cran.wu.ac.at/")
# install.packages("roxygen2", repos = "https://cran.wu.ac.at/")
library("inline")
library("Rcpp")
loadModule(module = "RcppHighs", TRUE)

library("highs")
attach(getNamespace("highs"))
ls()


RcppHighs <- Module("RcppHighs", getDynLib("highs"))
Highs <- RcppHighs$Highs
hi <- new(Highs)

hi$getNumCol()
hi$getNumRow()
hi$getNumNz()

ls(hi)
hi$getNumCol()
hi




