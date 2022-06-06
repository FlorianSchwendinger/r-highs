
<!-- README.md is generated from README.Rmd. Please edit that file -->

# **R** HIGHS Interface

This repository contains an **R** interface to the **HiGHS** solver. The
[HiGHS](https://github.com/ERGO-Code/HiGHS) solver, is a
**high**-performance open-source **solver** for solving linear
programming (LP), mixed-integer programming (MIP) and quadratic
programming (QP) optimization problems.

## Installation

``` r
remotes::install_gitlab("roigrp/solver/highs")
```

## Basic usage

``` r
library("highs")

args(highs_solve)
#> function (Q = NULL, L, lower, upper, A, lhs, rhs, types, maximum = FALSE, 
#>     offset = 0, control = list(), dry_run = FALSE) 
#> NULL
```

### LP

``` r
# Minimize
#  x_0 +  x_1 + 3
# Subject to
#                 x_1 <= 7
#  5 <=   x_0 + 2 x_1 <= 15
#  6 <= 3 x_0 + 2 x_1
#  0 <=   x_0         <= 4
#  1 <=           x_1
A <- rbind(c(0, 1), c(1, 2), c(3, 2))
s <- highs_solve(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf),
                 A = A, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf),
                 offset = 3)
str(s)
#> List of 5
#>  $ primal_solution: num [1:2] 0.5 2.25
#>  $ objective_value: num 5.75
#>  $ status         : chr "Optimal"
#>  $ solver_msg     :List of 6
#>   ..$ value_valid: logi TRUE
#>   ..$ dual_valid : logi TRUE
#>   ..$ col_value  : num [1:2] 0.5 2.25
#>   ..$ col_dual   : num [1:2] 0 0
#>   ..$ row_value  : num [1:3] 2.25 5 6
#>   ..$ row_dual   : num [1:3] 0 0.25 0.25
#>  $ info           :List of 18
#>   ..$ valid                     : logi TRUE
#>   ..$ mip_node_count            : num -1
#>   ..$ simplex_iteration_count   : int 2
#>   ..$ ipm_iteration_count       : int 0
#>   ..$ qp_iteration_count        : int 0
#>   ..$ crossover_iteration_count : int 0
#>   ..$ primal_solution_status    : chr "Feasible"
#>   ..$ dual_solution_status      : chr "Feasible"
#>   ..$ basis_validity            : int 1
#>   ..$ objective_function_value  : num 5.75
#>   ..$ mip_dual_bound            : num 0
#>   ..$ mip_gap                   : num Inf
#>   ..$ num_primal_infeasibilities: int 0
#>   ..$ max_primal_infeasibility  : num 0
#>   ..$ sum_primal_infeasibilities: num 0
#>   ..$ num_dual_infeasibilities  : int 0
#>   ..$ max_dual_infeasibility    : num 0
#>   ..$ sum_dual_infeasibilities  : num 0
```

## QP

``` r
# Minimize
#  0.5 x^2 - 2 x + y
# Subject to
#  x <= 3
zero <- .Machine$double.eps * 100
Q <- rbind(c(1, 0), c(0, zero))
L <- c(-2, 1)
A <- t(c(1, 0))

s <- highs_solve(Q = Q, L = L, A = A, lhs = 0, rhs = 3)
str(s)
#> List of 5
#>  $ primal_solution: num [1:2] 2 0
#>  $ objective_value: num -2
#>  $ status         : chr "Optimal"
#>  $ solver_msg     :List of 6
#>   ..$ value_valid: logi TRUE
#>   ..$ dual_valid : logi TRUE
#>   ..$ col_value  : num [1:2] 2 0
#>   ..$ col_dual   : num [1:2] 0 1
#>   ..$ row_value  : num 2
#>   ..$ row_dual   : num 0
#>  $ info           :List of 18
#>   ..$ valid                     : logi TRUE
#>   ..$ mip_node_count            : num -1
#>   ..$ simplex_iteration_count   : int 0
#>   ..$ ipm_iteration_count       : int 0
#>   ..$ qp_iteration_count        : int 3
#>   ..$ crossover_iteration_count : int 0
#>   ..$ primal_solution_status    : chr "Feasible"
#>   ..$ dual_solution_status      : chr "Feasible"
#>   ..$ basis_validity            : int 0
#>   ..$ objective_function_value  : num -2
#>   ..$ mip_dual_bound            : num 0
#>   ..$ mip_gap                   : num Inf
#>   ..$ num_primal_infeasibilities: int 0
#>   ..$ max_primal_infeasibility  : num 0
#>   ..$ sum_primal_infeasibilities: num 0
#>   ..$ num_dual_infeasibilities  : int 0
#>   ..$ max_dual_infeasibility    : num 0
#>   ..$ sum_dual_infeasibilities  : num 0
```

## Options

The function `highs_available_solver_options` lists the available solver
options

``` r
highs_available_solver_options()
#>                                           option    type category
#> 5                  allow_unbounded_or_infeasible    bool advanced
#> 34                     allowed_cost_scale_factor integer advanced
#> 33                   allowed_matrix_scale_factor integer advanced
#> 32                             cost_scale_factor integer advanced
#> 63     dual_simplex_cost_perturbation_multiplier  double advanced
#> 65           dual_simplex_pivot_growth_tolerance  double advanced
#> 62 dual_steepest_edge_weight_log_error_threshold  double advanced
#> 67                        factor_pivot_threshold  double advanced
#> 68                        factor_pivot_tolerance  double advanced
#> 31                                   keep_n_rows integer advanced
#> 11                     less_infeasible_DSE_check    bool advanced
#> 12                less_infeasible_DSE_choose_row    bool advanced
#> 15                                 log_dev_level integer advanced
#> 7           lp_presolve_requires_basis_postsolve    bool advanced
#> 37                max_dual_simplex_cleanup_level integer advanced
#> 38         max_dual_simplex_phase1_cleanup_level integer advanced
#> 8                           mps_parser_type_free    bool advanced
#> 10               no_unnecessary_rebuild_refactor    bool advanced
#> 66                      presolve_pivot_threshold  double advanced
#> 41               presolve_substitution_maxfillin integer advanced
#> 64  primal_simplex_bound_perturbation_multiplier  double advanced
#> 61     rebuild_refactor_solution_error_tolerance  double advanced
#> 4                                  run_crossover    bool advanced
#> 35                      simplex_dualise_strategy integer advanced
#> 9                simplex_initial_condition_check    bool advanced
#> 60           simplex_initial_condition_tolerance  double advanced
#> 36                      simplex_permute_strategy integer advanced
#> 39                        simplex_price_strategy integer advanced
#> 40            simplex_unscaled_solution_strategy integer advanced
#> 69                     start_crossover_tolerance  double advanced
#> 6               use_implied_bounds_from_presolve    bool advanced
#> 13                    use_original_HFactor_logic    bool advanced
#> 56                    dual_feasibility_tolerance  double     file
#> 19                          highs_analysis_level integer     file
#> 18                             highs_debug_level integer     file
#> 52                                infinite_bound  double     file
#> 51                                 infinite_cost  double     file
#> 29                           ipm_iteration_limit integer     file
#> 57                      ipm_optimality_tolerance  double     file
#> 54                            large_matrix_value  double     file
#> 77                                      log_file  string     file
#> 58                               objective_bound  double     file
#> 59                              objective_target  double     file
#> 55                  primal_feasibility_tolerance  double     file
#> 16                                   random_seed integer     file
#> 22                        simplex_crash_strategy integer     file
#> 23             simplex_dual_edge_weight_strategy integer     file
#> 25                       simplex_iteration_limit integer     file
#> 28                       simplex_max_concurrency integer     file
#> 27                       simplex_min_concurrency integer     file
#> 24           simplex_primal_edge_weight_strategy integer     file
#> 21                        simplex_scale_strategy integer     file
#> 20                              simplex_strategy integer     file
#> 26                          simplex_update_limit integer     file
#> 53                            small_matrix_value  double     file
#> 76                                 solution_file  string     file
#> 17                                       threads integer     file
#> 30                          write_solution_style integer     file
#> 1                         write_solution_to_file    bool     file
#> 3                                 log_to_console    bool  logging
#> 2                                    output_flag    bool  logging
#> 14                           mip_detect_symmetry    bool      mip
#> 70                     mip_feasibility_tolerance  double      mip
#> 71                          mip_heuristic_effort  double      mip
#> 45                              mip_lp_age_limit integer      mip
#> 44                                mip_max_leaves integer      mip
#> 42                                 mip_max_nodes integer      mip
#> 43                           mip_max_stall_nodes integer      mip
#> 46                            mip_pool_age_limit integer      mip
#> 47                           mip_pool_soft_limit integer      mip
#> 48                        mip_pscost_minreliable integer      mip
#> 49                              mip_report_level integer      mip
#> 74                                      parallel  string run-time
#> 72                                      presolve  string run-time
#> 75                                       ranging  string run-time
#> 73                                        solver  string run-time
#> 50                                    time_limit  double run-time
```

for additional information see the [HiGHS homepage](https://highs.dev/).
