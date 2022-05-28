library("highs")

ls(getNamespace("highs"))
attach(getNamespace("highs"))


HighsModel <- R6::R6Class("highs_model",
    public = list(
        nvars = NULL,
        ncons = NULL,
        model = NULL,
        initialize = function() {
            self$model <- new_model()
        },
        objective = function(Q = NULL, L) {
            assert_numeric(L, any.missing = FALSE)
            model_set_ncol(self$model, length(L))
            model_set_objective(model, L)
        },
        constraints = function(A, lhs, rhs) {
            model_set_nrow(model, ncons)

        },
        types = function() {

        },
        bounds = function(lower, upper) {

        },
        maximum = function(sense = FALSE) {
            model_set_sense(self$model, sense)
        }
    )
)


m <- HighsModel$new()






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
    solver <- new_solver(model)
    solver_set_options(solver, control)
    run_status <- solver_run(solver)
    status <- solver_status(solver)
    solution <- solver_solution(solver)
    info <- solver_info(solver)
    list(primal_solution = solution[["col_value"]], objective_value = info[["objective_function_value"]],
         status = status, solver_msg = solution, info = info)



