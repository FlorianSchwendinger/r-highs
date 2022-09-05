q("no")
R


library("highs")
library(microbenchmark)

highs:::highs_infinity()


mb <- microbenchmark(highs:::highs_infinity())
print(mb, "us")
