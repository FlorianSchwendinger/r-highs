q("no")
R


library("highs")
ls("package:highs")

#
# Linear Problem
#
attach(getNamespace("highs"))

## Setup Model
model <- new_model()
model_set_ncol(model, 2L)
model_set_nrow(model, 3L)
model_set_sense(model, FALSE)
model_set_offset(model, 3)
model_set_objective(model, c(1, 1))
model_set_lower(model, c(0.0, 1.0))
model_set_upper(model, c(4.0, 1.0e30))
model_set_constraint_matrix_(model, "colwise",
    as.integer(c(0, 2, 5)),
    as.integer(c(1, 2, 0, 1, 2)),
    c(1.0, 3.0, 1.0, 2.0, 2.0)
)
model_set_lhs(model, c(-1.0e30, 5.0, 6.0))
model_set_rhs(model, c(7.0, 15.0, 1.0e30))


## Inspect Model
model_get_nvars(model)
model_get_ncons(model)
model_get_vartype(model)

## Solve Model
solver <- hi_new_solver(model)
solver_run(solver)
solver_status(solver)
str(solver_info(solver))
solver_solution(solver)


solver_set_integrality(solver, 1L, 0L)
solver_run(solver)
solver_solution(solver)


# Add integrality constraints
model_set_vartype(model, c(1L, 1L))
model_get_vartype(model)

solver <- hi_new_solver(model)
solver_run(solver)
solver_status(solver)
solver_info(solver)
solver_solution(solver)


#
# Quadratic Problem
#
# minimize -x_2 - 3x_3 + (1/2)(2x_1^2 - 2x_1x_3 + 0.2x_2^2 + 2x_3^2)
#
model <- new_model()
model_set_ncol(model, 3L)
model_set_nrow(model, 0L)
model_set_sense(model, FALSE)
model_set_offset(model, 0)
model_set_objective(model, c(0.0, -1.0, -3.0))
model_set_lower(model, c(-1.0e30, -1.0e30, -1.0e30))
model_set_upper(model, c(1.0e30, 1.0e30, 1.0e30))
model_set_hessian(model, "triangular", dim = model_get_nvars(model),
    as.integer(c(0, 2, 3, 4)),
    as.integer(c(0, 2, 1, 2)),
    c(2.0, -1.0, 0.2, 2.0)
)

## Inspect Model
model_get_nvars(model)
model_get_ncons(model)
model_get_vartype(model)

## Solve Model
solver <- hi_new_solver(model)
solver_run(solver)
solver_status(solver)
solver_info(solver)
solver_info(solver)[["objective_function_value"]] # -5.5
solver_solution(solver)

#
# Add Constraint
# minimize -x_2 - 3x_3 + (1/2)(2x_1^2 - 2x_1x_3 + 0.2x_2^2 + 2x_3^2)
# subject to x_1 + x_3 <= 2; x>=0
#
model_set_lower(model, c(0, 0, 0))
model_set_nrow(model, 1L)
model_set_constraint_matrix(model, "colwise",
    as.integer(c(0, 1, 1, 2)),
    as.integer(c(0, 0)),
    c(1.0, 1.0)
)
model_set_lhs(model, c(-1.0e30, -1.0e30, -1.0e30))
model_set_rhs(model, c(2, 2, 2))

## Solve Model
solver <- hi_new_solver(model)
solver_run(solver)
solver_status(solver)
solver_info(solver)
solver_info(solver)[["objective_function_value"]] # -5.25
solver_solution(solver)


#
# Options
#
available_solver_options <- function() {
    option_names <- rbind(
        c("write_solution_to_file", "bool", "file"),
        c("output_flag", "bool", "logging"),
        c("log_to_console", "bool", "logging"),
        c("run_crossover", "bool", "advanced"),
        c("allow_unbounded_or_infeasible", "bool", "advanced"),
        c("use_implied_bounds_from_presolve", "bool", "advanced"),
        c("lp_presolve_requires_basis_postsolve", "bool", "advanced"),
        c("mps_parser_type_free", "bool", "advanced"),
        c("simplex_initial_condition_check", "bool", "advanced"),
        c("no_unnecessary_rebuild_refactor", "bool", "advanced"),
        c("less_infeasible_DSE_check", "bool", "advanced"),
        c("less_infeasible_DSE_choose_row", "bool", "advanced"),
        c("use_original_HFactor_logic", "bool", "advanced"),
        c("mip_detect_symmetry", "bool", "mip"),
        c("log_dev_level", "integer", "advanced"),
        c("random_seed", "integer", "file"),
        c("threads", "integer", "file"),
        c("highs_debug_level", "integer", "file"),
        c("highs_analysis_level", "integer", "file"),
        c("simplex_strategy", "integer", "file"),
        c("simplex_scale_strategy", "integer", "file"),
        c("simplex_crash_strategy", "integer", "file"),
        c("simplex_dual_edge_weight_strategy", "integer", "file"),
        c("simplex_primal_edge_weight_strategy", "integer", "file"),
        c("simplex_iteration_limit", "integer", "file"),
        c("simplex_update_limit", "integer", "file"),
        c("simplex_min_concurrency", "integer", "file"),
        c("simplex_max_concurrency", "integer", "file"),
        c("ipm_iteration_limit", "integer", "file"),
        c("write_solution_style", "integer", "file"),
        c("keep_n_rows", "integer", "advanced"),
        c("cost_scale_factor", "integer", "advanced"),
        c("allowed_matrix_scale_factor", "integer", "advanced"),
        c("allowed_cost_scale_factor", "integer", "advanced"),
        c("simplex_dualise_strategy", "integer", "advanced"),
        c("simplex_permute_strategy", "integer", "advanced"),
        c("max_dual_simplex_cleanup_level", "integer", "advanced"),
        c("max_dual_simplex_phase1_cleanup_level", "integer", "advanced"),
        c("simplex_price_strategy", "integer", "advanced"),
        c("simplex_unscaled_solution_strategy", "integer", "advanced"),
        c("presolve_substitution_maxfillin", "integer", "advanced"),
        c("mip_max_nodes", "integer", "mip"),
        c("mip_max_stall_nodes", "integer", "mip"),
        c("mip_max_leaves", "integer", "mip"),
        c("mip_lp_age_limit", "integer", "mip"),
        c("mip_pool_age_limit", "integer", "mip"),
        c("mip_pool_soft_limit", "integer", "mip"),
        c("mip_pscost_minreliable", "integer", "mip"),
        c("mip_report_level", "integer", "mip"),
        c("time_limit", "double", "run-time"),
        c("infinite_cost", "double", "file"),
        c("infinite_bound", "double", "file"),
        c("small_matrix_value", "double", "file"),
        c("large_matrix_value", "double", "file"),
        c("primal_feasibility_tolerance", "double", "file"),
        c("dual_feasibility_tolerance", "double", "file"),
        c("ipm_optimality_tolerance", "double", "file"),
        c("objective_bound", "double", "file"),
        c("objective_target", "double", "file"),
        c("simplex_initial_condition_tolerance", "double", "advanced"),
        c("rebuild_refactor_solution_error_tolerance", "double", "advanced"),
        c("dual_steepest_edge_weight_log_error_threshold", "double", "advanced"),
        c("dual_simplex_cost_perturbation_multiplier", "double", "advanced"),
        c("primal_simplex_bound_perturbation_multiplier", "double", "advanced"),
        c("dual_simplex_pivot_growth_tolerance", "double", "advanced"),
        c("presolve_pivot_threshold", "double", "advanced"),
        c("factor_pivot_threshold", "double", "advanced"),
        c("factor_pivot_tolerance", "double", "advanced"),
        c("start_crossover_tolerance", "double", "advanced"),
        c("mip_feasibility_tolerance", "double", "mip"),
        c("mip_heuristic_effort", "double", "mip"),
        c("presolve", "string", "run-time"),
        c("solver", "string", "run-time"),
        c("parallel", "string", "run-time"),
        c("ranging", "string", "run-time"),
        c("solution_file", "string", "file"),
        c("log_file", "string", "file")
    )
    colnames(option_names) <- c("option", "type", "category")
    option_names <- as.data.frame(option_names)
    option_names[order(option_names[["category"]], option_names[["option"]], option_names[["type"]]), ]
}

.available__solver__options_ <- function() {
    option_names <- list(
        bool = c("write_solution_to_file", "output_flag", "log_to_console",
                 "run_crossover", "allow_unbounded_or_infeasible",
                 "use_implied_bounds_from_presolve", "lp_presolve_requires_basis_postsolve",
                 "mps_parser_type_free", "simplex_initial_condition_check",
                 "no_unnecessary_rebuild_refactor", "less_infeasible_DSE_check",
                 "less_infeasible_DSE_choose_row", "use_original_HFactor_logic",
                 "mip_detect_symmetry"),
        integer = c("log_dev_level", "random_seed", "threads", "highs_debug_level",
                    "highs_analysis_level", "simplex_strategy", "simplex_scale_strategy",
                    "simplex_crash_strategy", "simplex_dual_edge_weight_strategy",
                    "simplex_primal_edge_weight_strategy", "simplex_iteration_limit",
                    "simplex_update_limit", "simplex_min_concurrency", "simplex_max_concurrency",
                    "ipm_iteration_limit", "write_solution_style", "keep_n_rows",
                    "cost_scale_factor", "allowed_matrix_scale_factor", "allowed_cost_scale_factor",
                    "simplex_dualise_strategy", "simplex_permute_strategy",
                    "max_dual_simplex_cleanup_level", "max_dual_simplex_phase1_cleanup_level",
                    "simplex_price_strategy", "simplex_unscaled_solution_strategy",
                    "presolve_substitution_maxfillin", "mip_max_nodes", "mip_max_stall_nodes",
                    "mip_max_leaves", "mip_lp_age_limit", "mip_pool_age_limit",
                    "mip_pool_soft_limit", "mip_pscost_minreliable", "mip_report_level"),
        double = c("time_limit", "infinite_cost", "infinite_bound", "small_matrix_value",
                   "large_matrix_value", "primal_feasibility_tolerance",
                   "dual_feasibility_tolerance", "ipm_optimality_tolerance",
                   "objective_bound", "objective_target", "simplex_initial_condition_tolerance",
                   "rebuild_refactor_solution_error_tolerance",
                   "dual_steepest_edge_weight_log_error_threshold",
                   "dual_simplex_cost_perturbation_multiplier",
                   "primal_simplex_bound_perturbation_multiplier",
                   "dual_simplex_pivot_growth_tolerance", "presolve_pivot_threshold",
                   "factor_pivot_threshold", "factor_pivot_tolerance", "start_crossover_tolerance",
                   "mip_feasibility_tolerance", "mip_heuristic_effort"),
        string = c("presolve", "solver", "parallel", "ranging", "solution_file", "log_file")
    )
    option_names
}

hi_solver_get_options <- function(solver) {
    option_names <- available_solver_options()
    getters <- list(bool = solver_get_bool_option, integer = solver_get_int_option,
                    double = solver_get_dbl_option, string = solver_get_str_option)
    opts <- vector("list", NROW(opts_names))
    names(opts) <- option_names[["option"]]
    for (i in seq_len(NROW(option_names))) {
        row <- option_names[i,]
        solver_get_option <- getters[[row[["type"]]]]
        key <- row[["option"]]
        opts[[key]] <- solver_get_option(solver, key)
    }
    opts
}

solver_options <- solver_get_options(solver)
str(solver_options[1:38])
str(solver_options[39:77])


library("checkmate")

solver_get_options(solver)[c("log_to_console", "output_flag")]
kwargs <- list(log_to_console = FALSE, output_flag = FALSE)


solver_set_options <- function(solver, ...) {
    kwargs <- list(...)
    option_names <- available_solver_options()
    assert_character(names(kwargs), min.len = 1L, any.missing = FALSE)
    forcers <- list(bool = as.logical, integer = as.integer,
                    double = as.double, string = as.character)
    m <- match(names(kwargs), option_names[["option"]])
    if (anyNA(m)) {
        stop("unknown option")
    }
    option_names <- option_names[m,]
    option_types <- setNames(option_names[["type"]], option_names[["option"]])
    for (i in seq_along(kwargs)) {
        key <- names(kwargs)[i]
        value <- kwargs[[i]]
        force_type <- forcers[[option_types[key]]]
        solver_set_option(solver, key, force_type(value))
    }
}

solver_get_options(solver)[c("log_to_console", "output_flag")]
solver_set_options(solver, log_to_console = FALSE, output_flag = FALSE)
solver_get_options(solver)[c("log_to_console", "output_flag")]
solver_set_options(solver, log_to_console = TRUE, output_flag = 1)
solver_get_options(solver)[c("log_to_console", "output_flag")]

