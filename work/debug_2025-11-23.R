library("highs")
library("Matrix")


cntrl <- list()
cntrl$log_to_console <- TRUE
cntrl$solver <- "choose" # necessary to use QP solver


L <- c(0, -1, -3)
Q <- rbind(c(2, 0.0, -1), c(0, 0.2, 0), c(-1, 0.0, 2))
A <- rbind(c(1, 0, 1))
s <- highs_solve(Q = Q, L = L, lower = 0, A = A, rhs = 2, control = cntrl)
s



L <- c(0, -1, -3)
Q <- rbind(c(2, 0.0, -1), c(0, 0.2, 0), c(-1, 0.0, 2))
Q <- as(Q, "dgCMatrix")
Q
A <- rbind(c(1, 0, 1))
s <- highs_solve(Q = Q, L = L, lower = 0, A = A, rhs = 2, control = cntrl, offset = 4)
str(s)


file <- dir("~/Downloads", pattern = "model.rds", full.names = TRUE)
model <- readRDS(file)
str(model)

model$A[abs(model$A) < 1e-8] <- 0

cntrl <- list()
cntrl$log_to_console <- TRUE
cntrl$solver <- "choose" # necessary to use QP solver
result <- highs::highs_solve(
  Q = model$Q,
  L = model$obj,
  A = model$A,
  lhs = model$rhs,
  rhs = model$rhs,
  lower = model$lb,
  upper = model$ub,
  offset = model$alpha,
  control = cntrl
)


Q = model$Q
L = model$obj
A = model$A
lhs = model$rhs
rhs = model$rhs
lower = model$lb
upper = model$ub
offset = model$alpha
control = cntrl

types = rep.int(1L, length(L))
maximum = FALSE

attach(getNamespace("highs"))

checkmate::assert_list(control)
if (!inherits(control, "highs_control")) {
    control <- do.call(highs_control, control)
}
str(control)

model <- highs_model(Q = Q, L = L, lower = lower, upper = upper, 
    A = A, lhs = lhs, rhs = rhs, types = types, maximum = maximum, 
    offset = offset)
set_number_of_threads(control$threads)

solver <- hi_new_solver(model)

init_msg <- capture.output(solver <- hi_new_solver(model))
if (is.null(solver)) {
    stop(paste(tail(init_msg, -3), collapse = "\n"))
}
hi_solver_set_options(solver, control)
run_status <- hi_solver_run(solver)
status <- solver_status(solver)
status_message <- solver_status_message(solver)
solution <- solver_get_solution(solver)
info <- solver_info(solver)
list(primal_solution = solution[["col_value"]], objective_value = info[["objective_function_value"]], 
    status = status, status_message = status_message, solver_msg = solution, 
    info = info)



