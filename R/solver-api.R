new_solver <- function(mpt) {
    .Call(`_highs_new_solver`, mpt)
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



