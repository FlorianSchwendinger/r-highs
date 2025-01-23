library("highs.check")
library("highs")


# HiGHS/src/util/HighsHashTree.h:858:32: runtime error: index 1 out of bounds for type 'NodePtr [1]'
writeLines(paste(rep("#", 80), collapse = ""))
writeLines("Highs runtime error which showed up in an example from the designmatch package")
writeLines(paste(rep("#", 80), collapse = ""))
op <- highs_check("distmatch_1")
# highs_write_model(do.call(highs_model, op[setdiff(names(op), "control")]), "inst/distmatch_1.lp")
str(op)
do.call(highs_solve, op)


writeLines(paste(rep("#", 80), collapse = ""))
writeLines("Highs runtime error which showed up in an example from the MatchIt package")
writeLines(paste(rep("#", 80), collapse = ""))
op <- highs_check("matchit_1")
# highs_write_model(do.call(highs_model, op[setdiff(names(op), "control")]), "inst/matchit_1.lp")
str(op)
do.call(highs_solve, op)


# model <- do.call(highs_model, op[setdiff(names(op), "control")])
# control <- do.call(highs_control, op$control)
# solver <- highs:::new_solver(model)
# highs:::solver_write_model(solver, "inst/model.lp")
