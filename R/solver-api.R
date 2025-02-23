#' Create a new solver instance.
#'
#' This function initializes a new Highs solver instance using the provided model pointer.
#'
#' @param model an object of class \code{"highs_model"}
#' 
#' @return A new solver instance.
#' 
#' @examples
#' model <- example_model()
#' new_solver(model)
#' @export 
new_solver <- function(model) {
    .Call(`_highs_new_solver`, model)
}


# TODO: Implement this function
# highs_pass_model <- function(hi, num_col, num_row, num_nz, a_format, sense, offset, col_cost, col_lower, col_upper, row_lower, row_upper, a_start, a_index, a_value, integrality) {
#     .Call(`_highs_highs_pass_model`, hi, num_col, num_row, num_nz, a_format, sense, offset, col_cost, col_lower, col_upper, row_lower, row_upper, a_start, a_index, a_value, integrality)
# }

# TODO: Implement this function
# solver_pass_hessian <- function() {
#     .Call(`_highs_solver_pass_hessian`)
# }

# TODO: Implement this function
# solver_pass_constraints <- function() {
#     .Call(`_highs_solver_pass_constraints`)
# }



#' Get the optimization sense of the solver instance.
#'
#' This function returns the optimization sense (e.g., minimization or maximization) of the provided solver instance.
#'
#' @param solver An object of class "highs_solver" representing the solver instance.
#' 
#' @return The optimization sense of the solver instance.
#' 
#' @examples
#' solver <- example_solver()
#' solver_get_sense(solver)
#' 
#' @export 
solver_get_sense <- function(solver) {
    .Call(`_highs_solver_get_sense`, solver)
}

#' Set the optimization sense of the solver instance.
#'
#' This function updates the optimization sense for the given solver instance. Use TRUE for maximization and FALSE for minimization.
#'
#' @param solver An object of class "highs_solver".
#' @param maximum A boolean indicating whether to set maximization (TRUE) or minimization (FALSE).
#' 
#' @return The updated solver instance with the new optimization sense.
#' 
#' @examples
#' solver <- example_solver()
#' solver_set_sense(solver, TRUE)
#' 
#' @export
solver_set_sense <- function(solver, maximum) {
    .Call(`_highs_solver_set_sense`, solver, maximum)
}


#' Set the objective offset for the solver.
#'
#' This function sets the objective offset in the solver instance.
#'
#' @param solver An object of class "highs_solver".
#' @param ext_offset A numeric value representing the offset.
#' 
#' @return The solver instance with the updated offset.
#' 
#' @examples
#' solver <- example_solver()
#' solver_set_offset(solver, 5.0)
#' 
#' @export
solver_set_offset <- function(solver, ext_offset) {
    .Call(`_highs_solver_set_offset`, solver, ext_offset)
}


#' Set integrality for a variable in the solver.
#'
#' This function defines whether a variable is categorized as integral or continuous.
#'
#' @param solver An object of class "highs_solver".
#' @param index An integer specifying the variable index.
#' @param type An integer representing the integrality type.
#' 
#' @return The solver instance with updated integrality settings.
#' 
#' @examples
#' solver <- example_solver()
#' solver_set_integrality(solver, 1, 1)
#' 
#' @export
solver_set_integrality <- function(solver, index, type) {
    .Call(`_highs_solver_set_integrality`, solver, index, type)
}


#' Set the objective coefficient for a variable.
#'
#' This function assigns a coefficient to a variable in the objective function.
#'
#' @param solver An object of class "highs_solver".
#' @param index The variable index.
#' @param obj A numeric value representing the objective coefficient.
#' 
#' @return The solver instance with the updated objective.
#' 
#' @examples
#' solver <- example_solver()
#' solver_set_objective(solver, 2, 3.5)
#' 
#' @export
solver_set_objective <- function(solver, index, obj) {
    .Call(`_highs_solver_set_objective`, solver, index, obj)
}


#' Set variable bounds for a given variable.
#'
#' This function sets the lower and upper bounds for a specific variable.
#'
#' @param solver An object of class "highs_solver".
#' @param index The variable index.
#' @param lower The lower bound.
#' @param upper The upper bound.
#' 
#' @return The solver instance with updated variable bounds.
#' 
#' @examples
#' solver <- example_solver()
#' solver_set_variable_bounds(solver, 2, 0, 10)
#' 
#' @export
solver_set_variable_bounds <- function(solver, index, lower, upper) {
    .Call(`_highs_solver_set_variable_bounds`, solver, index, lower, upper)
}


#' Set constraint bounds for a given constraint.
#'
#' This function sets the lower and upper bounds for a specific constraint.
#'
#' @param solver An object of class "highs_solver".
#' @param index The constraint index.
#' @param lower The lower bound.
#' @param upper The upper bound.
#' 
#' @return The solver instance with updated constraint bounds.
#' 
#' @examples
#' solver <- example_solver()
#' solver_set_constraint_bounds(solver, 1, -Inf, 100)
#' 
#' @export
solver_set_constraint_bounds <- function(solver, index, lower, upper) {
    .Call(`_highs_solver_set_constraint_bounds`, solver, index, lower, upper)
}


#' Set a coefficient in the constraint matrix.
#'
#' This function assigns a coefficient value to a specific entry in the constraint matrix.
#'
#' @param solver An object of class "highs_solver".
#' @param row The row index.
#' @param col The column index.
#' @param val The coefficient value.
#' 
#' @return The solver instance with the updated coefficient.
#' 
#' @examples
#' solver <- example_solver()
#' solver_set_coeff(solver, 1, 1, 4.2)
#' 
#' @export
solver_set_coeff <- function(solver, row, col, val) {
    .Call(`_highs_solver_set_coeff`, solver, row, col, val)
}



#' Add Variables to the Solver
#'
#' This function adds new variables to the solver with specified bounds.
#'
#' @param solver An object of class "highs_solver".
#' @param lower A numeric vector of lower bounds for the new variables.
#' @param upper A numeric vector of upper bounds for the new variables.
#'
#' @return The solver instance with the new variables added.
#'
#' @examples
#' solver <- example_solver()
#'solver_add_vars(solver, lower = c(0, 0, 0), upper = c(10, 10, 10))
#'
#' @export
solver_add_vars <- function(solver, lower, upper) {
    .Call(`_highs_solver_add_vars`, solver, lower, upper)
}


#' Set Solver Option
#'
#' This function sets a solver option using a key-value pair.
#'
#' @param solver An object of class "highs_solver".
#' @param key A character string specifying the option name.
#' @param value The value to set for the option.
#'
#' @return The solver instance with the updated option.
#'
#' @examples
#' solver <- example_solver()
#' solver_set_option(solver, "time_limit", 100)
#'
#' @export
solver_set_option <- function(solver, key, value) {
    .Call(`_highs_solver_set_option`, solver, key, value)
}


#' Clear All Solver Data
#'
#' This function clears all data from the solver instance, including the model and solution.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return The cleared solver instance.
#'
#' @examples
#' solver <- example_solver()
#' solver_clear(solver)
#'
#' @export
solver_clear <- function(solver) {
    .Call(`_highs_solver_clear`, solver)
}


#' Clear Model Data
#'
#' This function clears only the model data from the solver instance.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return The solver instance with cleared model data.
#'
#' @examples
#' solver <- example_solver()
#' solver_clear_model(solver)
#'
#' @export
solver_clear_model <- function(solver) {
    .Call(`_highs_solver_clear_model`, solver)
}


#' Clear Solver State
#'
#' This function clears the internal solver state while preserving the model.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return The solver instance with cleared solver state.
#'
#' @examples
#' solver <- example_solver()
#' solver_clear_solver(solver)
#'
#' @export
solver_clear_solver <- function(solver) {
    .Call(`_highs_solver_clear_solver`, solver)
}


#' Run the Solver
#'
#' This function executes the optimization solver on the current model.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return The solver instance after optimization.
#'
#' @examples
#' solver <- example_solver()
#' solver_run(solver)
#'
#' @export
solver_run <- function(solver) {
    .Call(`_highs_solver_run`, solver)
}


#' Get Model from Solver
#'
#' This function retrieves the current optimization model from the solver.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return The current optimization model.
#'
#' @examples
#' solver <- example_solver()
#' model <- solver_get_model(solver)
#'
#' @export
solver_get_model <- function(solver) {
    .Call(`_highs_solver_get_model`, solver)
}


#' Get Number of Variables
#'
#' This function returns the number of variables (columns) in the optimization model.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return An integer representing the number of variables.
#'
#' @examples
#' solver <- example_solver()
#' n_vars <- solver_get_num_col(solver)
#'
#' @export
solver_get_num_col <- function(solver) {
    .Call(`_highs_solver_get_num_col`, solver)
}


#' Get Number of Constraints
#'
#' This function returns the number of constraints (rows) in the optimization model.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return An integer representing the number of constraints.
#'
#' @examples
#' solver <- example_solver()
#' n_constraints <- solver_get_num_row(solver)
#'
#' @export
solver_get_num_row <- function(solver) {
    .Call(`_highs_solver_get_num_row`, solver)
}


#' Write Model to File
#'
#' This function writes the current optimization model to a file.
#'
#' @param solver An object of class "highs_solver".
#' @param filename A character string specifying the output file path.
#'
#' @return Invisible NULL.
#'
#' @examples
#' solver <- example_solver()
#' solver_write_model(solver, "model.mps")
#'
#' @export
solver_write_model <- function(solver, filename) {
    .Call(`_highs_solver_write_model`, solver, filename)
}


#' Write Basis to File
#'
#' This function writes the current basis information to a file.
#'
#' @param solver An object of class "highs_solver".
#' @param filename A character string specifying the output file path.
#'
#' @return Invisible NULL.
#'
#' @examples
#' solver <- example_solver()
#' solver_write_basis(solver, "basis.txt")
#'
#' @export
solver_write_basis <- function(solver, filename) {
    .Call(`_highs_solver_write_basis`, solver, filename)
}


#' Get Solver Status Message
#'
#' This function returns a human-readable message describing the current solver status.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return A character string containing the status message.
#'
#' @examples
#' solver <- example_solver()
#' solver_run(solver)
#' message <- solver_status_message(solver)
#'
#' @export
solver_status_message <- function(solver) {
    .Call(`_highs_solver_status_message`, solver)
}


#' Get Solver Status
#'
#' This function returns the current status of the solver.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return A status code indicating the solver state.
#'
#' @examples
#' solver <- example_solver()
#' solver_run(solver)
#' status <- solver_status(solver)
#'
#' @export
solver_status <- function(solver) {
    .Call(`_highs_solver_status`, solver)
}


#' Get Solver Infinity Value
#'
#' This function returns the value that the solver uses to represent infinity.
#'
#' @return A numeric value representing infinity in the solver.
#'
#' @examples
#' inf <- solver_infinity()
#'
#' @export
solver_infinity <- function() {
    .Call(`_highs_solver_infinity`)
}


#' Reset Global Scheduler
#'
#' This function resets the global scheduler used by the solver.
#'
#' @param blocking A logical value indicating whether to wait for completion.
#'
#' @return Invisible NULL.
#'
#' @examples
#' reset_global_scheduler(TRUE)
#'
#' @export
reset_global_scheduler <- function(blocking) {
    .Call(`_highs_reset_global_scheduler`, blocking)
}


#' Get Solver Information
#'
#' This function retrieves detailed information about the solver's state and performance.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return A list containing solver information.
#'
#' @examples
#' solver <- example_solver()
#' info <- solver_info(solver)
#'
#' @export
solver_info <- function(solver) {
    .Call(`_highs_solver_info`, solver)
}


#' Get Solution
#'
#' This function retrieves the solution from the solver after optimization.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return A list containing the solution information.
#'
#' @examples
#' solver <- example_solver()
#' solver_run(solver)
#' solution <- solver_solution(solver)
#'
#' @export
solver_solution <- function(solver) {
    .Call(`_highs_solver_solution`, solver)
}


#' Get Boolean Option Value
#'
#' This function retrieves the value of a boolean solver option.
#'
#' @param solver An object of class "highs_solver".
#' @param key A character string specifying the option name.
#'
#' @return A logical value.
#'
#' @examples
#' solver <- example_solver()
#' value <- solver_get_bool_option(solver, "parallel")
#'
#' @export
solver_get_bool_option <- function(solver, key) {
    .Call(`_highs_solver_get_bool_option`, solver, key)
}


#' Get Integer Option Value
#'
#' This function retrieves the value of an integer solver option.
#'
#' @param solver An object of class "highs_solver".
#' @param key A character string specifying the option name.
#'
#' @return An integer value.
#'
#' @examples
#' solver <- example_solver()
#' value <- solver_get_int_option(solver, "ipm_iteration_count")
#'
#' @export
solver_get_int_option <- function(solver, key) {
    .Call(`_highs_solver_get_int_option`, solver, key)
}


#' Get Double Option Value
#'
#' This function retrieves the value of a double precision solver option.
#'
#' @param solver An object of class "highs_solver".
#' @param key A character string specifying the option name.
#'
#' @return A numeric value.
#'
#' @examples
#' solver <- example_solver()
#' value <- solver_get_dbl_option(solver, "time_limit")
#'
#' @export
solver_get_dbl_option <- function(solver, key) {
    .Call(`_highs_solver_get_dbl_option`, solver, key)
}


#' Get String Option Value
#'
#' This function retrieves the value of a string solver option.
#'
#' @param solver An object of class "highs_solver".
#' @param key A character string specifying the option name.
#'
#' @return A character string.
#'
#' @examples
#' solver <- example_solver()
#' value <- solver_get_str_option(solver, "solver")
#'
#' @export
solver_get_str_option <- function(solver, key) {
    .Call(`_highs_solver_get_str_option`, solver, key)
}


#' Change Variable Bounds
#'
#' This function updates the bounds of an existing variable in the model.
#'
#' @param solver An object of class "highs_solver".
#' @param idx An integer specifying the variable index.
#' @param lower The new lower bound.
#' @param upper The new upper bound.
#'
#' @return The solver instance with updated bounds.
#'
#' @examples
#' solver <- example_solver()
#' solver_change_variable_bounds(solver, 1, 0, 10)
#'
#' @export
solver_change_variable_bounds <- function(solver, idx, lower, upper) {
    .Call(`_highs_solver_change_variable_bounds`, solver, idx, lower, upper)
}


#' Change Constraint Bounds
#'
#' This function updates the bounds of an existing constraint in the model.
#'
#' @param solver An object of class "highs_solver".
#' @param idx An integer specifying the constraint index.
#' @param lhs The new left-hand side bound.
#' @param rhs The new right-hand side bound.
#'
#' @return The solver instance with updated constraint bounds.
#'
#' @examples
#' solver <- example_solver()
#' solver_change_constraint_bounds(solver, 1, -Inf, 100)
#'
#' @export
solver_change_constraint_bounds <- function(solver, idx, lhs, rhs) {
    .Call(`_highs_solver_change_constraint_bounds`, solver, idx, lhs, rhs)
}


#' Add Constraints to Model
#'
#' This function adds new constraints (rows) to the optimization model.
#'
#' @param solver An object of class "highs_solver".
#' @param lhs A numeric vector of left-hand side bounds.
#' @param rhs A numeric vector of right-hand side bounds.
#' @param start An integer vector of starting positions in the sparse matrix.
#' @param index An integer vector of column indices.
#' @param value A numeric vector of coefficient values.
#'
#' @return The solver instance with new constraints added.
#'
#' @examples
#' solver <- example_solver()
#' solver_add_rows(solver, c(-Inf), c(10), c(0, 2), c(0, 1), c(1, 2))
#'
#' @export
solver_add_rows <- function(solver, lhs, rhs, start, index, value) {
    .Call(`_highs_solver_add_rows`, solver, lhs, rhs, start, index, value)
}


#' Add Variables to Model
#'
#' This function adds new variables (columns) to the optimization model.
#'
#' @param solver An object of class "highs_solver".
#' @param costs A numeric vector of objective coefficients.
#' @param lower A numeric vector of lower bounds.
#' @param upper A numeric vector of upper bounds.
#' @param start An integer vector of starting positions in the sparse matrix.
#' @param index An integer vector of row indices.
#' @param value A numeric vector of coefficient values.
#'
#' @return The solver instance with new variables added.
#'
#' @examples
#' solver <- example_solver()
#' solver_add_cols(solver, c(1), c(0), c(10), c(0, 1), c(0), c(2))
#'
#' @export
solver_add_cols <- function(solver, costs, lower, upper, start, index, value) {
    .Call(`_highs_solver_add_cols`, solver, costs, lower, upper, start, index, value)
}


#' Get Objective Coefficients
#'
#' This function retrieves the objective coefficients of the linear program.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return A numeric vector of objective coefficients.
#'
#' @examples
#' solver <- example_solver()
#' costs <- solver_get_lp_costs(solver)
#'
#' @export
solver_get_lp_costs <- function(solver) {
    .Call(`_highs_solver_get_lp_costs`, solver)
}


#' Get Variable Bounds
#'
#' This function retrieves the bounds for all variables in the model.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return A list containing lower and upper bounds for all variables.
#'
#' @examples
#' solver <- example_solver()
#' bounds <- solver_get_variable_bounds(solver)
#'
#' @export
solver_get_variable_bounds <- function(solver) {
    .Call(`_highs_solver_get_variable_bounds`, solver)
}


#' Get Constraint Bounds
#'
#' This function retrieves the bounds for all constraints in the model.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return A list containing lower and upper bounds for all constraints.
#'
#' @examples
#' solver <- example_solver()
#' bounds <- solver_get_constraint_bounds(solver)
#'
#' @export
solver_get_constraint_bounds <- function(solver) {
    .Call(`_highs_solver_get_constraint_bounds`, solver)
}


#' Get Constraint Matrix
#'
#' This function retrieves the constraint matrix of the optimization model.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return A sparse matrix representing the constraints.
#'
#' @examples
#' solver <- example_solver()
#' matrix <- solver_get_constraint_matrix(solver)
#'
#' @export
solver_get_constraint_matrix <- function(solver) {
    .Call(`_highs_solver_get_constraint_matrix`, solver)
}


#' Get Variable Types
#'
#' This function retrieves the type (continuous, integer, etc.) of all variables.
#'
#' @param solver An object of class "highs_solver".
#'
#' @return A character vector of variable types.
#'
#' @examples
#' solver <- example_solver()
#' types <- solver_get_vartype(solver)
#'
#' @export
solver_get_vartype <- function(solver) {
    .Call(`_highs_solver_get_vartype`, solver)
}
