options(warn = 1)
library('highs')

solver <- example_solver()
value <- hi_solver_get_bool_option(solver, "mip_detect_symmetry")


highs:::solver_get_str_option(solver, "parallel")


x <- highs_available_solver_options()
head(x)
class(x)

x$option

meta_data <- highs_available_solver_options()
keys <- c("parallel", "abc")


highs:::solver_set_option(solver, "abc", 3)
highs:::solver_set_option(solver, "parallel", 3)


solver <- example_solver()
hi_solver_set_option(solver, "output_flag", "FALSE")
hi_solver_set_option(solver, "solver", "simplex", type = "string")



solver <- example_solver()
hi_solver_set_options(solver, list(output_flag = FALSE, solver = "simplex"))

control <- list(
  presolve = "on",
  solver = "simplex",
  parallel = "on",
  ranging = "off",
  time_limit = 100.0,
  
  primal_feasibility_tolerance = 1e-7,
  dual_feasibility_tolerance = 1e-7,
  random_seed = 1234,
  threads = 4,
  
  output_flag = TRUE,
  log_to_console = TRUE,
  
  run_crossover = "on",
  allow_unbounded_or_infeasible = FALSE,
  
  mip_detect_symmetry = TRUE,
  mip_max_nodes = 10000,
  mip_max_leaves = 5000,
  mip_feasibility_tolerance = 1e-6
)
hi_solver_set_options(solver, control)


highs:::solver_set_option(solver, "run_crossover", "on")
highs:::solver_set_option(solver, "run_crossover", 3)
