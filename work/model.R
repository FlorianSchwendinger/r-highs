q("no")
R

library("highs")

ls(getNamespace("highs"))
attach(getNamespace("highs"))


HighsModel <- R6::R6Class("HighsModel",
    public = list(
        model = NULL,
        initialize = function() {
            self$model <- new_model()
        },
        objective = function(L, Q = NULL, offset = 0) {
            checkmate::assert_numeric(L, any.missing = FALSE)
            model_set_ncol(self$model, length(L))
            model_set_objective(self$model, L)
            if (!is.null(Q)) {
                model_set_hessian(self$model, Q)
            }
            if (offset != 0) {
                model_set_offset(self$model, offset)
            }
            invisible(NULL)
        },
        constraints = function(A, lhs, rhs) {
            ncons <- NROW(A)
            INF <- highs_infinity()
            model_set_nrow(self$model, ncons)
            model_set_constraint_matrix(self$model, A)
            if (missing(lhs) || length(lhs) == 0L) {
                lhs <- rep.int(-INF, ncons)
            }
            if (missing(rhs) || length(rhs) == 0L) {
                rhs <- rep.int(INF, ncons)
            }
            lhs <- replace(lhs, lhs == -Inf, -INF)
            rhs <- replace(rhs, rhs ==  Inf, INF)
            model_set_lhs(self$model, lhs)
            model_set_rhs(self$model, rhs)
            invisible(NULL)
        },
        types = function(types) {
                if (missing(types) || length(types) == 0L) {
            if (is.character(types)) {
                types <- match(types, c("C", "I", "SC", "SI", "II")) - 1L
            } else {
                types <- types - 1L
            }
            assert_integerish(types, lower = 0, upper = 4L, any.missing = FALSE)
            model_set_vartype(self$model, as.integer(types))
            invisible(NULL)
        }
        },
        bounds = function(lower, upper) {
            INF <- highs_infinity()
            if (missing(lower) || length(lower) == 0L) {
                lower <- rep.int(-INF, nvars)
            } else if (length(lower) == 1L) {
                lower <- rep.int(lower, nvars)
            }
            if (missing(upper) || length(upper) == 0L) {
                upper <- rep.int(INF, nvars)
            } else if (length(upper) == 1L) {
                upper <- rep.int(upper, nvars)
            }

            lower <- replace(lower, lower == -Inf, -INF)
            upper <- replace(upper, upper ==  Inf, INF)
            model_set_lower(self$model, lower)
            model_set_upper(self$model, upper)
            invisible(NULL)
        },
        maximum = function(sense = FALSE) {
            model_set_sense(self$model, sense)
            invisible(NULL)
        },
        show = function() {

        }
    )
)


A <- rbind(c(0, 1), c(1, 2), c(3, 2))

m <- HighsModel$new()
m$objective(L = c(1.0, 1), offset = 3)
m$constraints(A, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf))
m$bounds(lower = c(0, 1), upper = c(4, Inf))


HighsSolver <- R6::R6Class("HighsSolver",
    public = list(
        solver = NULL,
        initialize = function(model) {
            capture.output(self$solver <- hi_new_solver(model$model))
        },
        options = function(control) {
            if (length(control) > 0L) {
                solver_set_options(self$solver, control)
            }
        },
        solve = function(...) {
            self$options(list(...))
            solver_run(self$solver)
        },
        status = function() {
            solver_status(self$solver)
        },
        info = function() {
            solver_info(self$solver)
        },
        message = function() {
            solver_status_message(self$solver)
        },
        solution = function() {
            solver_solution(self$solver)
        },
        change_type = function(index, type) {
            solver_set_integrality(self$solver, index, type)
        }
    )
)


solver <- HighsSolver$new(m)
solver$solve()
solver$solution()
solver$status()
solver$info()
solver$message()


solver$change_type(1L, 2L)
solver$solve()
solver$solution()


model_get_nvars(solver_get_model(solver$solver))
model_get_ncons(solver_get_model(solver$solver))
model_get_vartype(solver_get_model(solver$solver))

library(Matrix)

A <- rbind(c(0, 1), c(1, 2), c(3, 2))

# solver <- HighsSolver$new()
solver <- hi_new_solver(NULL)
solver_add_vars(solver, c(0, 1), c(4, 100))
solver_set_objective(solver, c(0L, 1L), c(1.0, 1))
csc <- (A)
solver_add_rows(solver, lhs = c(-1000, 5, 6), rhs = c(7, 15, 1000),
                start = csc[["col_ptr"]], index = csc[["row_id"]], value = csc[["value"]])



s <- highs_solve(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf),
                 A = A, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf),
                 offset = 3)









    model <- new_model()
    model_set_ncol(model, nvars)
    model_set_nrow(model, ncons)
    model_set_sense(model, maximum)
    model_set_objective(model, L)
    if (!is.null(Q)) {
        cscQ <- as_csc(Q)
        model_set_hessian(model, format = "square", dim = nvars,
            start = cscQ[["col_ptr"]], index = cscQ[["row_id"]], value = cscQ[["value"]])
    }
    if (missing(types)) {
        types <- rep.int(0L, nvars)
    } else {
        if (is.character(types)) {
            types <- c("C", "I", "SI")
            types <- match(types, c("C", "I", "SC", "SI", "II")) - 1L
        } else {
            types <- types - 1L
        }
        assert_integerish(types, lower = 0, upper = 4L, any.missing = FALSE)
        model_set_vartype(model, as.integer(types))
    }
    if (missing(lower)) {
        lower <- rep.int(.Machine[["double.xmin"]], nvars)
    } else if (length(lower) == 1L) {
        lower <- rep.int(lower, nvars)
    }
    if (missing(upper)) {
        upper <- rep.int(.Machine[["double.xmax"]], nvars)
    } else if (length(upper) == 1L) {
        upper <- rep.int(upper, nvars)
    }
    lower <- replace(lower, lower == -Inf, .Machine[["double.xmin"]])
    upper <- replace(upper, upper ==  Inf, .Machine[["double.xmax"]])
    model_set_lower(model, lower)
    model_set_upper(model, upper)
    if (ncons > 0L) {
        model_set_constraint_matrix(model, "colwise",
            start = cscA[["col_ptr"]], index = cscA[["row_id"]], value = cscA[["value"]])
        if (missing(lhs)) {
            lhs <- rep.int(.Machine[["double.xmin"]], ncons)
        }
        if (missing(rhs)) {
            rhs <- rep.int(.Machine[["double.xmin"]], ncons)
        }
        lhs <- replace(lhs, lhs == -Inf, .Machine[["double.xmin"]])
        rhs <- replace(rhs, rhs ==  Inf, .Machine[["double.xmax"]])
        model_set_lhs(model, lhs)
        model_set_rhs(model, rhs)
    }
    if (offset != 0) {
        model_set_offset(model, offset)
    }
    if (dry_run) return(model)
    solver <- hi_new_solver(model)
    solver_set_options(solver, control)
    run_status <- solver_run(solver)
    status <- solver_status(solver)
    solution <- solver_solution(solver)
    info <- solver_info(solver)
    list(primal_solution = solution[["col_value"]], objective_value = info[["objective_function_value"]],
         status = status, solver_msg = solution, info = info)



