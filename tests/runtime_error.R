library("highs")

# -----------------------------------------------------------------------------
#
# Example from the designmatch package
# - to reproduce error shown in gccUBSAN checks
#
# -----------------------------------------------------------------------------
file <- system.file("op/distmatch_1.rds", package = "highs")
op <- readRDS(file)
str(op)
do.call(highs_solve, op)


# -----------------------------------------------------------------------------
#
# Example from the MatchIt package
# - to reproduce error shown in gccUBSAN checks
#
# -----------------------------------------------------------------------------
file <- system.file("op/matchit_1.rds", package = "highs")
op <- readRDS(file)
str(op)
do.call(highs_solve, op)
