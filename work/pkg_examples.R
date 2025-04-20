pkgname <- "highs"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('highs')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("example_model")
### * example_model

flush(stderr()); flush(stdout())

### Name: example_model
### Title: Generate Example Optimization Models
### Aliases: example_model

### ** Examples

model <- example_model("LP")
model <- example_model("MILP")
model <- example_model("QP")




cleanEx()
nameEx("example_solver")
### * example_solver

flush(stderr()); flush(stdout())

### Name: example_solver
### Title: Create a HiGHS Solver Object
### Aliases: example_solver

### ** Examples

solver <- example_solver("LP")
solver <- example_solver("MILP")
solver <- example_solver("QP")




cleanEx()
nameEx("hi_model_get_ncons")
### * hi_model_get_ncons

flush(stderr()); flush(stdout())

### Name: hi_model_get_ncons
### Title: Get Number of Constraints in a Model
### Aliases: hi_model_get_ncons

### ** Examples

model <- hi_new_model()
hi_model_get_ncons(model)




cleanEx()
nameEx("hi_model_get_nvars")
### * hi_model_get_nvars

flush(stderr()); flush(stdout())

### Name: hi_model_get_nvars
### Title: Get Number of Variables in a Highs Model
### Aliases: hi_model_get_nvars

### ** Examples

model <- hi_new_model()
hi_model_get_nvars(model)




cleanEx()
nameEx("hi_model_set_constraint_matrix")
### * hi_model_set_constraint_matrix

flush(stderr()); flush(stdout())

### Name: hi_model_set_constraint_matrix
### Title: Set Constraint Matrix for Highs Model
### Aliases: hi_model_set_constraint_matrix

### ** Examples

model <- hi_new_model()
matrix <- matrix(c(1, 0, 0, 1), nrow = 2)
hi_model_set_constraint_matrix(model, matrix)




cleanEx()
nameEx("hi_model_set_hessian")
### * hi_model_set_hessian

flush(stderr()); flush(stdout())

### Name: hi_model_set_hessian
### Title: Set Hessian Matrix for Highs Model
### Aliases: hi_model_set_hessian

### ** Examples

model <- hi_new_model()
hessian_matrix <- matrix(c(1, 0, 0, 1), nrow = 2)
hi_model_set_hessian(model, hessian_matrix)




cleanEx()
nameEx("hi_model_set_lhs")
### * hi_model_set_lhs

flush(stderr()); flush(stdout())

### Name: hi_model_set_lhs
### Title: Set Left Hand Side for a Highs Model
### Aliases: hi_model_set_lhs

### ** Examples

model <- hi_new_model()
model <- hi_model_set_lhs(model, c(0, 1, 2))




cleanEx()
nameEx("hi_model_set_lower")
### * hi_model_set_lower

flush(stderr()); flush(stdout())

### Name: hi_model_set_lower
### Title: Set Lower Bounds for Highs Model
### Aliases: hi_model_set_lower

### ** Examples

model <- hi_new_model()
lower_bounds <- c(0, 1, 2)
hi_model_set_lower(model, lower_bounds)




cleanEx()
nameEx("hi_model_set_ncol")
### * hi_model_set_ncol

flush(stderr()); flush(stdout())

### Name: hi_model_set_ncol
### Title: Sets the number of columns in the model
### Aliases: hi_model_set_ncol

### ** Examples

model <- hi_new_model()
hi_model_set_ncol(model, 10L) # Sets the model to have 10 columns



cleanEx()
nameEx("hi_model_set_nrow")
### * hi_model_set_nrow

flush(stderr()); flush(stdout())

### Name: hi_model_set_nrow
### Title: Set the number of rows in the model
### Aliases: hi_model_set_nrow

### ** Examples

model <- hi_new_model()
hi_model_set_nrow(model, 5L) # Sets the model to have 5 rows



cleanEx()
nameEx("hi_model_set_objective")
### * hi_model_set_objective

flush(stderr()); flush(stdout())

### Name: hi_model_set_objective
### Title: Set Objective for Highs Model
### Aliases: hi_model_set_objective

### ** Examples

model <- hi_new_model()
objective <- c(1, 2, 3)
hi_model_set_objective(model, objective)




cleanEx()
nameEx("hi_model_set_offset")
### * hi_model_set_offset

flush(stderr()); flush(stdout())

### Name: hi_model_set_offset
### Title: Set Offset for Highs Model
### Aliases: hi_model_set_offset

### ** Examples

model <- hi_new_model()
hi_model_set_offset(model, 10)




cleanEx()
nameEx("hi_model_set_rhs")
### * hi_model_set_rhs

flush(stderr()); flush(stdout())

### Name: hi_model_set_rhs
### Title: Set Right Hand Side for a Highs Model
### Aliases: hi_model_set_rhs

### ** Examples

model <- hi_new_model()
model <- hi_model_set_rhs(model, c(0, 1, 2))




cleanEx()
nameEx("hi_model_set_sense")
### * hi_model_set_sense

flush(stderr()); flush(stdout())

### Name: hi_model_set_sense
### Title: Set the sense of the optimization model
### Aliases: hi_model_set_sense

### ** Examples

model <- hi_new_model()
hi_model_set_sense(model, TRUE) # Set the model to maximization
hi_model_set_sense(model, FALSE) # Set the model to minimization




cleanEx()
nameEx("hi_model_set_upper")
### * hi_model_set_upper

flush(stderr()); flush(stdout())

### Name: hi_model_set_upper
### Title: Set Upper Bounds for a Highs Model
### Aliases: hi_model_set_upper

### ** Examples

model <- hi_new_model()
upper_bounds <- c(10, 20, 30)
hi_model_set_upper(model, upper_bounds)




cleanEx()
nameEx("hi_model_set_vartype")
### * hi_model_set_vartype

flush(stderr()); flush(stdout())

### Name: hi_model_set_vartype
### Title: Set Variable Types in a Highs Model
### Aliases: hi_model_set_vartype

### ** Examples

model <- hi_new_model()
types <- c(1, 2, 1, 0)
hi_model_set_vartype(model, types)




cleanEx()
nameEx("hi_new_solver")
### * hi_new_solver

flush(stderr()); flush(stdout())

### Name: hi_new_solver
### Title: Create a new solver instance.
### Aliases: hi_new_solver

### ** Examples

model <- example_model()
hi_new_solver(model)



cleanEx()
nameEx("hi_reset_global_scheduler")
### * hi_reset_global_scheduler

flush(stderr()); flush(stdout())

### Name: hi_reset_global_scheduler
### Title: Reset Global Scheduler
### Aliases: hi_reset_global_scheduler

### ** Examples

hi_reset_global_scheduler(TRUE)




cleanEx()
nameEx("hi_solver_add_cols")
### * hi_solver_add_cols

flush(stderr()); flush(stdout())

### Name: hi_solver_add_cols
### Title: Add Variables to Model
### Aliases: hi_solver_add_cols

### ** Examples

solver <- example_solver()
hi_solver_add_cols(solver, c(1), c(0), c(10), c(0, 1), c(0), c(2))




cleanEx()
nameEx("hi_solver_add_rows")
### * hi_solver_add_rows

flush(stderr()); flush(stdout())

### Name: hi_solver_add_rows
### Title: Add Constraints to Model
### Aliases: hi_solver_add_rows

### ** Examples

solver <- example_solver()
hi_solver_add_rows(solver, c(-Inf), c(10), c(0, 2), c(0, 1), c(1, 2))




cleanEx()
nameEx("hi_solver_add_vars")
### * hi_solver_add_vars

flush(stderr()); flush(stdout())

### Name: hi_solver_add_vars
### Title: Add Variables to the Solver
### Aliases: hi_solver_add_vars

### ** Examples

solver <- example_solver()
hi_solver_add_vars(solver, lower = c(0, 0, 0), upper = c(10, 10, 10))




cleanEx()
nameEx("hi_solver_change_constraint_bounds")
### * hi_solver_change_constraint_bounds

flush(stderr()); flush(stdout())

### Name: hi_solver_change_constraint_bounds
### Title: Change Constraint Bounds
### Aliases: hi_solver_change_constraint_bounds

### ** Examples

solver <- example_solver()
hi_solver_change_constraint_bounds(solver, 1, -Inf, 100)




cleanEx()
nameEx("hi_solver_change_variable_bounds")
### * hi_solver_change_variable_bounds

flush(stderr()); flush(stdout())

### Name: hi_solver_change_variable_bounds
### Title: Change Variable Bounds
### Aliases: hi_solver_change_variable_bounds

### ** Examples

solver <- example_solver()
hi_solver_change_variable_bounds(solver, 1, 0, 10)




cleanEx()
nameEx("hi_solver_clear")
### * hi_solver_clear

flush(stderr()); flush(stdout())

### Name: hi_solver_clear
### Title: Clear All Solver Data
### Aliases: hi_solver_clear

### ** Examples

solver <- example_solver()
hi_solver_clear(solver)




cleanEx()
nameEx("hi_solver_clear_model")
### * hi_solver_clear_model

flush(stderr()); flush(stdout())

### Name: hi_solver_clear_model
### Title: Clear Model Data
### Aliases: hi_solver_clear_model

### ** Examples

solver <- example_solver()
hi_solver_clear_model(solver)




cleanEx()
nameEx("hi_solver_clear_solver")
### * hi_solver_clear_solver

flush(stderr()); flush(stdout())

### Name: hi_solver_clear_solver
### Title: Clear Solver State
### Aliases: hi_solver_clear_solver

### ** Examples

solver <- example_solver()
hi_solver_clear_solver(solver)




cleanEx()
nameEx("hi_solver_get_bool_option")
### * hi_solver_get_bool_option

flush(stderr()); flush(stdout())

### Name: hi_solver_get_bool_option
### Title: Get Boolean Option Value
### Aliases: hi_solver_get_bool_option

### ** Examples

solver <- example_solver()
value <- hi_solver_get_bool_option(solver, "parallel")




cleanEx()
nameEx("hi_solver_get_constraint_bounds")
### * hi_solver_get_constraint_bounds

flush(stderr()); flush(stdout())

### Name: hi_solver_get_constraint_bounds
### Title: Get Constraint Bounds
### Aliases: hi_solver_get_constraint_bounds

### ** Examples

solver <- example_solver()
bounds <- hi_solver_get_constraint_bounds(solver)




cleanEx()
nameEx("hi_solver_get_constraint_matrix")
### * hi_solver_get_constraint_matrix

flush(stderr()); flush(stdout())

### Name: hi_solver_get_constraint_matrix
### Title: Get Constraint Matrix
### Aliases: hi_solver_get_constraint_matrix

### ** Examples

solver <- example_solver()
matrix <- hi_solver_get_constraint_matrix(solver)




cleanEx()
nameEx("hi_solver_get_dbl_option")
### * hi_solver_get_dbl_option

flush(stderr()); flush(stdout())

### Name: hi_solver_get_dbl_option
### Title: Get Double Option Value
### Aliases: hi_solver_get_dbl_option

### ** Examples

solver <- example_solver()
value <- hi_solver_get_dbl_option(solver, "time_limit")




cleanEx()
nameEx("hi_solver_get_int_option")
### * hi_solver_get_int_option

flush(stderr()); flush(stdout())

### Name: hi_solver_get_int_option
### Title: Get Integer Option Value
### Aliases: hi_solver_get_int_option

### ** Examples

solver <- example_solver()
value <- hi_solver_get_int_option(solver, "ipm_iteration_count")




cleanEx()
nameEx("hi_solver_get_lp_costs")
### * hi_solver_get_lp_costs

flush(stderr()); flush(stdout())

### Name: hi_solver_get_lp_costs
### Title: Get Objective Coefficients
### Aliases: hi_solver_get_lp_costs

### ** Examples

solver <- example_solver()
costs <- hi_solver_get_lp_costs(solver)




cleanEx()
nameEx("hi_solver_get_model")
### * hi_solver_get_model

flush(stderr()); flush(stdout())

### Name: hi_solver_get_model
### Title: Get Model from Solver
### Aliases: hi_solver_get_model

### ** Examples

solver <- example_solver()
model <- hi_solver_get_model(solver)




cleanEx()
nameEx("hi_solver_get_num_col")
### * hi_solver_get_num_col

flush(stderr()); flush(stdout())

### Name: hi_solver_get_num_col
### Title: Get Number of Variables
### Aliases: hi_solver_get_num_col

### ** Examples

solver <- example_solver()
n_vars <- hi_solver_get_num_col(solver)




cleanEx()
nameEx("hi_solver_get_num_row")
### * hi_solver_get_num_row

flush(stderr()); flush(stdout())

### Name: hi_solver_get_num_row
### Title: Get Number of Constraints
### Aliases: hi_solver_get_num_row

### ** Examples

solver <- example_solver()
n_constraints <- hi_solver_get_num_row(solver)




cleanEx()
nameEx("hi_solver_get_sense")
### * hi_solver_get_sense

flush(stderr()); flush(stdout())

### Name: hi_solver_get_sense
### Title: Get the optimization sense of the solver instance.
### Aliases: hi_solver_get_sense

### ** Examples

solver <- example_solver()
hi_solver_get_sense(solver)




cleanEx()
nameEx("hi_solver_get_str_option")
### * hi_solver_get_str_option

flush(stderr()); flush(stdout())

### Name: hi_solver_get_str_option
### Title: Get String Option Value
### Aliases: hi_solver_get_str_option

### ** Examples

solver <- example_solver()
value <- hi_solver_get_str_option(solver, "solver")




cleanEx()
nameEx("hi_solver_get_variable_bounds")
### * hi_solver_get_variable_bounds

flush(stderr()); flush(stdout())

### Name: hi_solver_get_variable_bounds
### Title: Get Variable Bounds
### Aliases: hi_solver_get_variable_bounds

### ** Examples

solver <- example_solver()
bounds <- hi_solver_get_variable_bounds(solver)




cleanEx()
nameEx("hi_solver_get_vartype")
### * hi_solver_get_vartype

flush(stderr()); flush(stdout())

### Name: hi_solver_get_vartype
### Title: Get Variable Types
### Aliases: hi_solver_get_vartype

### ** Examples

solver <- example_solver()
types <- hi_solver_get_vartype(solver)




cleanEx()
nameEx("hi_solver_infinity")
### * hi_solver_infinity

flush(stderr()); flush(stdout())

### Name: hi_solver_infinity
### Title: Get Solver Infinity Value
### Aliases: hi_solver_infinity

### ** Examples

inf <- hi_solver_infinity()




cleanEx()
nameEx("hi_solver_info")
### * hi_solver_info

flush(stderr()); flush(stdout())

### Name: hi_solver_info
### Title: Get Solver Information
### Aliases: hi_solver_info

### ** Examples

solver <- example_solver()
info <- hi_solver_info(solver)




cleanEx()
nameEx("hi_solver_run")
### * hi_solver_run

flush(stderr()); flush(stdout())

### Name: hi_solver_run
### Title: Run the Solver
### Aliases: hi_solver_run

### ** Examples

solver <- example_solver()
hi_solver_run(solver)




cleanEx()
nameEx("hi_solver_set_coeff")
### * hi_solver_set_coeff

flush(stderr()); flush(stdout())

### Name: hi_solver_set_coeff
### Title: Set a coefficient in the constraint matrix.
### Aliases: hi_solver_set_coeff

### ** Examples

solver <- example_solver()
hi_solver_set_coeff(solver, 1, 1, 4.2)




cleanEx()
nameEx("hi_solver_set_constraint_bounds")
### * hi_solver_set_constraint_bounds

flush(stderr()); flush(stdout())

### Name: hi_solver_set_constraint_bounds
### Title: Set constraint bounds for a given constraint.
### Aliases: hi_solver_set_constraint_bounds

### ** Examples

solver <- example_solver()
hi_solver_set_constraint_bounds(solver, 1, -Inf, 100)




cleanEx()
nameEx("hi_solver_set_integrality")
### * hi_solver_set_integrality

flush(stderr()); flush(stdout())

### Name: hi_solver_set_integrality
### Title: Set integrality for a variable in the solver.
### Aliases: hi_solver_set_integrality

### ** Examples

solver <- example_solver()
hi_solver_set_integrality(solver, 1, 1)




cleanEx()
nameEx("hi_solver_set_objective")
### * hi_solver_set_objective

flush(stderr()); flush(stdout())

### Name: hi_solver_set_objective
### Title: Set the objective coefficient for a variable.
### Aliases: hi_solver_set_objective

### ** Examples

solver <- example_solver()
hi_solver_set_objective(solver, 2, 3.5)




cleanEx()
nameEx("hi_solver_set_offset")
### * hi_solver_set_offset

flush(stderr()); flush(stdout())

### Name: hi_solver_set_offset
### Title: Set the objective offset for the solver.
### Aliases: hi_solver_set_offset

### ** Examples

solver <- example_solver()
hi_solver_set_offset(solver, 5.0)




cleanEx()
nameEx("hi_solver_set_options")
### * hi_solver_set_options

flush(stderr()); flush(stdout())

### Name: hi_solver_set_options
### Title: Set Solver Option
### Aliases: hi_solver_set_options

### ** Examples

solver <- example_solver()
hi_solver_set_options(solver, list(time_limit = 100))




cleanEx()
nameEx("hi_solver_set_sense")
### * hi_solver_set_sense

flush(stderr()); flush(stdout())

### Name: hi_solver_set_sense
### Title: Set the optimization sense of the solver instance.
### Aliases: hi_solver_set_sense

### ** Examples

solver <- example_solver()
hi_solver_set_sense(solver, TRUE)




cleanEx()
nameEx("hi_solver_set_variable_bounds")
### * hi_solver_set_variable_bounds

flush(stderr()); flush(stdout())

### Name: hi_solver_set_variable_bounds
### Title: Set variable bounds for a given variable.
### Aliases: hi_solver_set_variable_bounds

### ** Examples

solver <- example_solver()
hi_solver_set_variable_bounds(solver, 2, 0, 10)




cleanEx()
nameEx("hi_solver_solution")
### * hi_solver_solution

flush(stderr()); flush(stdout())

### Name: hi_solver_solution
### Title: Get Solution
### Aliases: hi_solver_solution

### ** Examples

solver <- example_solver()
hi_solver_run(solver)
solution <- hi_solver_solution(solver)




cleanEx()
nameEx("hi_solver_status")
### * hi_solver_status

flush(stderr()); flush(stdout())

### Name: hi_solver_status
### Title: Get Solver Status
### Aliases: hi_solver_status

### ** Examples

solver <- example_solver()
hi_solver_run(solver)
status <- hi_solver_status(solver)




cleanEx()
nameEx("hi_solver_status_message")
### * hi_solver_status_message

flush(stderr()); flush(stdout())

### Name: hi_solver_status_message
### Title: Get Solver Status Message
### Aliases: hi_solver_status_message

### ** Examples

solver <- example_solver()
hi_solver_run(solver)
message <- hi_solver_status_message(solver)




cleanEx()
nameEx("hi_solver_write_basis")
### * hi_solver_write_basis

flush(stderr()); flush(stdout())

### Name: hi_solver_write_basis
### Title: Write Basis to File
### Aliases: hi_solver_write_basis

### ** Examples

solver <- example_solver()
hi_solver_write_basis(solver, "basis.txt")




cleanEx()
nameEx("hi_solver_write_model")
### * hi_solver_write_model

flush(stderr()); flush(stdout())

### Name: hi_solver_write_model
### Title: Write Model to File
### Aliases: hi_solver_write_model

### ** Examples

solver <- example_solver()
hi_solver_write_model(solver, "model.mps")




cleanEx()
nameEx("highs_available_solver_options")
### * highs_available_solver_options

flush(stderr()); flush(stdout())

### Name: highs_available_solver_options
### Title: Available Solver Options
### Aliases: highs_available_solver_options

### ** Examples

highs_available_solver_options()



cleanEx()
nameEx("highs_control")
### * highs_control

flush(stderr()); flush(stdout())

### Name: highs_control
### Title: Highs Control
### Aliases: highs_control

### ** Examples

control <- highs_control()



cleanEx()
nameEx("highs_model")
### * highs_model

flush(stderr()); flush(stdout())

### Name: highs_model
### Title: Create a Highs Model
### Aliases: highs_model

### ** Examples

library("highs")
# Minimize:
#  x_0 +  x_1 + 3
# Subject to:
#               x_1 <=  7
#  5 <=  x_0 + 2x_1 <= 15
#  6 <= 3x_0 + 2x_1
#  0 <= x_0 <= 4
#  1 <= x_1
A <- rbind(c(0, 1), c(1, 2), c(3, 2))
m <- highs_model(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf),
                 A = A, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf),
                 offset = 3)
m

# Minimize:
#  -x_2 - 3x_3 + (1/2) * (2 x_1^2 - 2 x_1x_3 + 0.2 x_2^2 + 2 x_3^2)
# Subject to:
#  x_1 + x_3 <= 2
#  0 <= x
L <- c(0, -1, -3)
Q <- rbind(c(2, 0.0, -1), c(0, 0.2, 0), c(-1, 0.0, 2))
A <- cbind(1, 0, 1)
m <- highs_model(Q = Q, L = L, lower = 0, A = A, rhs = 2)
m



cleanEx()
nameEx("highs_solve")
### * highs_solve

flush(stderr()); flush(stdout())

### Name: highs_solve
### Title: Solve an Optimization Problems
### Aliases: highs_solve

### ** Examples

library("highs")
# Minimize:
#  x_0 +  x_1 + 3
# Subject to:
#               x_1 <=  7
#  5 <=  x_0 + 2x_1 <= 15
#  6 <= 3x_0 + 2x_1
#  0 <= x_0 <= 4
#  1 <= x_1
A <- rbind(c(0, 1), c(1, 2), c(3, 2))
s <- highs_solve(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf),
                 A = A, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf),
                 offset = 3)
s[["objective_value"]]
s[["primal_solution"]]

# Minimize:
#  -x_2 - 3x_3 + (1/2) * (2 x_1^2 - 2 x_1x_3 + 0.2 x_2^2 + 2 x_3^2)
# Subject to:
#  x_1 + x_3 <= 2
#  0 <= x
L <- c(0, -1, -3)
Q <- rbind(c(2, 0.0, -1), c(0, 0.2, 0), c(-1, 0.0, 2))
A <- cbind(1, 0, 1)
s <- highs_solve(Q = Q, L = L, lower = 0, A = A, rhs = 2)
s[["objective_value"]]
s[["primal_solution"]]



cleanEx()
nameEx("highs_solver")
### * highs_solver

flush(stderr()); flush(stdout())

### Name: highs_solver
### Title: Highs Solver
### Aliases: highs_solver

### ** Examples

A <- rbind(c(0, 1), c(1, 2), c(3, 2))
m <- highs_model(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf),
                 A = A, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf),
                 offset = 3)
solver <- highs_solver(m)




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
