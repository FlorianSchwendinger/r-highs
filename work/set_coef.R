q("no")
R

library("highs")
sessionInfo()

L <- c(2, 4, 3)
A <- matrix(c(3, 4, 2, 2, 1, 2, 1, 3, 2), nrow = 3, byrow = TRUE)
rhs <- c(60, 40, 80)
solution <- highs_solve(L = L, lower = 0, A = A, rhs = rhs, maximum = TRUE)
# primal_solution: num [1:3] 0 6.67 16.67
str(solution)

model <- highs_model(L = L, lower = 0, A = A, rhs = rhs, maximum = TRUE)
solver <- highs:::new_solver(model)

control <- list(log_to_console = FALSE, threads = 1L, parallel = "off")
highs:::solver_set_options(solver, control)

run_status <- highs:::solver_run(solver)
status <- highs:::solver_status(solver)
status_message <- highs:::solver_status_message(solver)

solution <- highs:::solver_solution(solver)
info <- highs:::solver_info(solver)

highs:::solver_set_coeff(solver, row, col, val)
highs:::solver_set_objective(solver, index, value)

class(model) <- c("highs_model", class(model))
model




highs_control(time_limit = Inf)


set_number_of_threads()


highs_solver <- function(model, control = highs_control()) {
    checkmate::assert_class(model, classes = "highs_model")
    checkmate::assert_class(control, classes = "highs_control")
    highs:::set_number_of_threads(control$threads)
    init_msg <- capture.output(solver <- highs:::new_solver(model))
    if (is.null(solver)) {
        stop(paste(tail(init_msg, -3), collapse = "\n"))
    } else {
        rm(init_msg)
    }
    highs:::solver_set_options(solver, control)
    options <- function(...) {
        cntrl <- list(...)
        if (length(cntrl) == 0L) {
            highs:::hi_solver_get_options(solver)
        } else {
            highs:::solver_set_options(solver, cntrl)
        }
    }
    run <- function() {
        highs:::solver_run(solver)
    }
    status <- function() {
        highs:::solver_status(solver)
    }
    status_message <- function() {
        highs:::solver_status_message(solver)
    }
    solution <- function() {
        highs:::solver_solution(solver)
    }
    info <- function() {
        highs:::solver_info(solver)
    }
    structure(environment(), class = "highs_solver")
}


q("no")
R

library("highs")


L <- c(2, 4, 3)
A <- matrix(c(3, 4, 2, 2, 1, 2, 1, 3, 2), nrow = 3, byrow = TRUE)
rhs <- c(60, 40, 80)

model <- highs_model(L = L, lower = 0, A = A, rhs = rhs, maximum = TRUE)
solver <- highs_solver(model)

highs:::solver_get_vartype(solver$solver)



# highs:::solver_set_sense(solver$solver, FALSE)
highs:::solver_get_sense(solver$solver)


highs:::solver_get_lp_costs(solver$solver)

vbnd <- highs:::solver_get_variable_bounds(solver$solver)


matrix(highs:::solver_get_constraint_bounds(solver$solver), ncol = 2)



str(solver$options())
solver$run()
solver$status()
solver$status_message()
solver$solution()
solver$info()