q("no")
R

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




