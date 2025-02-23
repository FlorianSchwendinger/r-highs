q("no")
R

library("highs")


solver <- example_solver()
solver_get_num_row(solver)
solver_get_num_col(solver)
solver_add_vars(solver, lower = c(0, 0, 0), upper = c(10, 10, 10))
