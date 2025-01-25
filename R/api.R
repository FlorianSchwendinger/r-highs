
#' Create new Highs Model
#'
#' @description
#' Create a new highs model object.
#' @return an object of class \code{"highs_model"}.
#' @export 
hi_new_model <- function() {
    model <- new_model()
    class(model) <- c("highs_model", class(model))
    model
}


#' Sets the number of columns in the model
#' 
#' This function sets the number of columns in the given model.
#'
#' @param model an object of class \code{"highs_model"}.
#' @param ncol an integer giving the number of columns (variables) to set in the model
#' @return \code{NULL}
#' 
#' @examples
#' model <- hi_new_model()
#' hi_model_set_ncol(model, 10) # Sets the model to have 10 columns
#' @export
hi_model_set_ncol <- function(model, ncol) {
    checkmate::assert_class(model, classes = "highs_model")
    checkmate::assert_integer(ncol, lower = 0, any.missing = FALSE, len = 1)
    model_set_ncol(model, ncol)
}


#' Set the number of rows in the model
#'
#' This function sets the number of rows in the given model.
#'
#' @param model an object of class \code{"highs_model"}.
#' @param nrow an integer giving the number of rows (variables) to set in the model
#' @return \code{NULL}
#' 
#' @examples
#' model <- hi_new_model()
#' hi_model_set_nrow(model, 5) # Sets the model to have 5 rows
#' @export
hi_model_set_nrow <- function(model, nrow) {
    checkmate::assert_class(model, classes = "highs_model")
    checkmate::assert_integer(nrow, lower = 0, any.missing = FALSE, len = 1)
    model_set_nrow(model, nrow)
}


#' Set the sense of the optimization model
#'
#' This function sets the sense of the optimization model to either maximization or minimization.
#'
#' @param model an object of class \code{"highs_model"}.
#' @param maximum a boolean value indicating whether the model should be set to maximization (`TRUE`) or minimization (`FALSE`).
#' @return \code{NULL}
#'
#' @examples
#' model <- hi_new_model() # Assuming a function to create a highs_model
#' model <- hi_model_set_sense(model, TRUE) # Set the model to maximization
#' model <- hi_model_set_sense(model, FALSE) # Set the model to minimization
#'
#' @export
hi_model_set_sense <- function(model, maximum) {
    checkmate::assert_class(model, classes = "highs_model")
    checkmate::assert_boolean(maximum, len = 1)
    model_set_sense(model, maximum)
}



#' Set Offset for Highs Model
#'
#' This function sets the offset for a given Highs model.
#'
#' @param model an object of class \code{"highs_model"}.
#' @param offset a numeric value of length 1. The offset value to be set for the model.
#'
#' @return \code{NULL}
#'
#' @examples
#' \dontrun{
#' model <- hi_new_model()
#' hi_model_set_offset(model, 10)
#' }
#'
#' @export
hi_model_set_offset <- function(model, offset) {
    checkmate::assert_class(model, classes = "highs_model")
    checkmate::assert_numeric(offset, len = 1)
    model_set_offset(model, offset)
}



#' Set Objective for Highs Model
#'
#' This function sets the objective for a given Highs model.
#'
#' @param model an object of class \code{"highs_model"}.
#' @param objective a numeric vector giving the objective values to be set for the model.
#'
#' @return \code{NULL}
#'
#' @examples
#' \dontrun{
#' model <- hi_new_model()
#' objective <- c(1, 2, 3)
#' hi_model_set_objective(model, objective)
#' }
#'
#' @export
hi_model_set_objective <- function(model, objective) {
    checkmate::assert_class(model, classes = "highs_model")
    checkmate::assert_numeric(objective, any.missing = FALSE)
    model_set_objective(model, objective)
}


#' Set Lower Bounds for Highs Model
#'
#' This function sets the lower bounds for a given Highs model.
#'
#' @param model an object of class \code{"highs_model"}.
#' @param lower a numeric vector giving the lower bounds.
#'
#' @return \code{NULL}
#'
#' @examples
#' \dontrun{
#' model <- hi_new_model()
#' lower_bounds <- c(0, 1, 2)
#' hi_model_set_lower(model, lower_bounds)
#' }
#'
#' @export
hi_model_set_lower <- function(model, lower) {
    checkmate::assert_class(model, classes = "highs_model")
    checkmate::assert_numeric(lower, any.missing = FALSE)
    model_set_lower(model, lower)
}


#' Set Upper Bounds for a Highs Model
#'
#' This function sets the upper bounds for a given Highs model.
#'
#' @param model an object of class \code{"highs_model"}.
#' @param upper a numeric vector giving the upper bounds.
#'
#' @return \code{NULL}
#'
#' @examples
#' \dontrun{
#' model <- hi_new_model()
#' upper_bounds <- c(10, 20, 30)
#' hi_model_set_upper(model, upper_bounds)
#' }
#'
#' @export
hi_model_set_upper <- function(model, upper) {
    checkmate::assert_class(model, classes = "highs_model")
    checkmate::assert_numeric(upper, any.missing = FALSE)
    model_set_upper(model, upper)
}


#' Set Constraint Matrix for Highs Model
#'
#' This function sets the constraint matrix for a given Highs model.
#'
#' @param model an object of class \code{"highs_model"}.
#' @param format a character string specifying the format of the constraint matrix. 
#'               Must be one of "colwise", "rowwise", or "rowwise_partitioned".
#' @param start an integer vector giving the start positions of the constraints.
#' @param index an integer vector giving the indices of the constraints.
#' @param value a numeric vector giving the values of the constraints.
#'
#' @return \code{NULL}
#'
#' @examples
#' \dontrun{
#' model <- hi_new_model()
#' format <- "colwise"
#' start <- c(0, 2, 4)
#' index <- c(1, 2, 3, 4)
#' value <- c(1.0, 2.0, 3.0, 4.0)
#' hi_model_set_constraint_matrix(model, format, start, index, value)
#' }
#'
#' @export
hi_model_set_constraint_matrix <- function(model, format, start, index, value) {
    checkmate::assert_class(model, classes = "highs_model")
    checkmate::assert_choice(format, choices = c("colwise", "rowwise", "rowwise_partitioned"), len = 1)
    checkmate::assert_integer(start, any.missing = FALSE)
    checkmate::assert_integer(index, any.missing = FALSE)
    checkmate::assert_numeric(value, any.missing = FALSE)
    model_set_constraint_matrix(model, format, start, index, value)
}


#' Set Left Hand Side for a Highs Model
#'
#' This function sets the left hand side for a given Highs model.
#'
#' @param model an object of class \code{"highs_model"}.
#' @param lhs a numeric vector giving the left hand side values.
#'
#' @return \code{NULL}
#'
#' @examples
#' model <- hi_new_model()
#' model <- hi_model_set_lhs(model, c(0, 1, 2))
#'
#' @export
hi_model_set_lhs <- function(model, lhs) {
    checkmate::assert_class(model, classes = "highs_model")
    checkmate::assert_numeric(lower, any.missing = FALSE)
    model_set_lhs(model, lower)
}
model_set_lhs <- function(mpt, lower) {
    .Call(`_highs_model_set_lhs`, mpt, lower)
}

model_set_rhs <- function(mpt, upper) {
    .Call(`_highs_model_set_rhs`, mpt, upper)
}

model_set_hessian_ <- function(mpt, format, dim, start, index, value) {
    .Call(`_highs_model_set_hessian_`, mpt, format, dim, start, index, value)
}

model_set_vartype <- function(mpt, type) {
    .Call(`_highs_model_set_vartype`, mpt, type)
}

model_get_nvars <- function(mpt) {
    .Call(`_highs_model_get_nvars`, mpt)
}

model_get_ncons <- function(mpt) {
    .Call(`_highs_model_get_ncons`, mpt)
}

new_solver <- function(mpt) {
    .Call(`_highs_new_solver`, mpt)
}

highs_pass_model <- function(hi, num_col, num_row, num_nz, a_format, sense, offset, col_cost, col_lower, col_upper, row_lower, row_upper, a_start, a_index, a_value, integrality) {
    .Call(`_highs_highs_pass_model`, hi, num_col, num_row, num_nz, a_format, sense, offset, col_cost, col_lower, col_upper, row_lower, row_upper, a_start, a_index, a_value, integrality)
}

solver_pass_hessian <- function() {
    .Call(`_highs_solver_pass_hessian`)
}

solver_pass_constraints <- function() {
    .Call(`_highs_solver_pass_constraints`)
}

solver_get_sense <- function(hi) {
    .Call(`_highs_solver_get_sense`, hi)
}

solver_set_sense <- function(hi, maximum) {
    .Call(`_highs_solver_set_sense`, hi, maximum)
}

solver_set_offset <- function(hi, ext_offset) {
    .Call(`_highs_solver_set_offset`, hi, ext_offset)
}

solver_set_integrality <- function(hi, index, type) {
    .Call(`_highs_solver_set_integrality`, hi, index, type)
}

solver_set_objective <- function(hi, index, obj) {
    .Call(`_highs_solver_set_objective`, hi, index, obj)
}

solver_set_variable_bounds <- function(hi, index, lower, upper) {
    .Call(`_highs_solver_set_variable_bounds`, hi, index, lower, upper)
}

solver_set_constraint_bounds <- function(hi, index, lower, upper) {
    .Call(`_highs_solver_set_constraint_bounds`, hi, index, lower, upper)
}

solver_set_coeff <- function(hi, row, col, val) {
    .Call(`_highs_solver_set_coeff`, hi, row, col, val)
}

solver_add_vars <- function(hi, lower, upper) {
    .Call(`_highs_solver_add_vars`, hi, lower, upper)
}

solver_set_option <- function(hi, key, value) {
    .Call(`_highs_solver_set_option`, hi, key, value)
}

solver_clear <- function(hi) {
    .Call(`_highs_solver_clear`, hi)
}

solver_clear_model <- function(hi) {
    .Call(`_highs_solver_clear_model`, hi)
}

solver_clear_solver <- function(hi) {
    .Call(`_highs_solver_clear_solver`, hi)
}

solver_run <- function(hi) {
    .Call(`_highs_solver_run`, hi)
}

solver_get_model <- function(hi) {
    .Call(`_highs_solver_get_model`, hi)
}

solver_get_num_col <- function(hi) {
    .Call(`_highs_solver_get_num_col`, hi)
}

solver_get_num_row <- function(hi) {
    .Call(`_highs_solver_get_num_row`, hi)
}

solver_write_model <- function(hi, filename) {
    .Call(`_highs_solver_write_model`, hi, filename)
}

solver_write_basis <- function(hi, filename) {
    .Call(`_highs_solver_write_basis`, hi, filename)
}

solver_status_message <- function(hi) {
    .Call(`_highs_solver_status_message`, hi)
}

solver_status <- function(hi) {
    .Call(`_highs_solver_status`, hi)
}

solver_infinity <- function() {
    .Call(`_highs_solver_infinity`)
}

reset_global_scheduler <- function(blocking) {
    .Call(`_highs_reset_global_scheduler`, blocking)
}

solver_info <- function(hi) {
    .Call(`_highs_solver_info`, hi)
}

solver_solution <- function(hi) {
    .Call(`_highs_solver_solution`, hi)
}

solver_get_bool_option <- function(hi, key) {
    .Call(`_highs_solver_get_bool_option`, hi, key)
}

solver_get_int_option <- function(hi, key) {
    .Call(`_highs_solver_get_int_option`, hi, key)
}

solver_get_dbl_option <- function(hi, key) {
    .Call(`_highs_solver_get_dbl_option`, hi, key)
}

solver_get_str_option <- function(hi, key) {
    .Call(`_highs_solver_get_str_option`, hi, key)
}

solver_change_variable_bounds <- function(hi, idx, lower, upper) {
    .Call(`_highs_solver_change_variable_bounds`, hi, idx, lower, upper)
}

solver_change_constraint_bounds <- function(hi, idx, lhs, rhs) {
    .Call(`_highs_solver_change_constraint_bounds`, hi, idx, lhs, rhs)
}

solver_add_rows <- function(hi, lhs, rhs, start, index, value) {
    .Call(`_highs_solver_add_rows`, hi, lhs, rhs, start, index, value)
}

solver_add_cols <- function(hi, costs, lower, upper, start, index, value) {
    .Call(`_highs_solver_add_cols`, hi, costs, lower, upper, start, index, value)
}

solver_get_lp_costs <- function(hi) {
    .Call(`_highs_solver_get_lp_costs`, hi)
}

solver_get_variable_bounds <- function(hi) {
    .Call(`_highs_solver_get_variable_bounds`, hi)
}

solver_get_constraint_bounds <- function(hi) {
    .Call(`_highs_solver_get_constraint_bounds`, hi)
}

solver_get_constraint_matrix <- function(hi) {
    .Call(`_highs_solver_get_constraint_matrix`, hi)
}

solver_get_vartype <- function(hi) {
    .Call(`_highs_solver_get_vartype`, hi)
}



