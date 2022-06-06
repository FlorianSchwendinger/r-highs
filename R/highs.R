#' @import checkmate
#' @importFrom Rcpp evalCpp
#' @importFrom R6 R6Class
#' @importFrom stats setNames
#' @importFrom utils modifyList
#' @useDynLib highs, .registration=TRUE
NULL


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


HighsSolver <- R6::R6Class("highs_model",
    public = list(
        model = NULL,
        solver = NULL,
        initialize = function(model) {
            self$model <- model
        },
        variables_constraints = function() {

        },
        add_constraints = function() {

        },
        solve = function(control = list()) {

        },
        info = function() {

        },
        solution = function() {

        },
        status = function() {

        }
    )
)

highs_model <- function() {
    env <- new.env()

}


highs_solver <- function(model, ...) {

}


csc_to_matrix <- function(start, index, value, nrow = max(index + 1L), ncol = length(start) - 1L) {
    stopifnot(length(index) == length(value))
    ind <- index + 1L
    M <- matrix(0, nrow, ncol)
    i <- 3L
    for (i in seq_along(index)) {
        row_id <- ind[i]
        col_id <- min(which(start >= i) - 1L)
        M[row_id, col_id] <- value[i]
    }
    M
}



#' Solve an Optimization Problems
#'
#' Solve linear and quadratic mixed integer optimization problems.
#'
#' @param Q a numeric symatric matrix giving the quadratic part of the objective.
#' @param L a numeric vector giving the linear part of the objective function.
#' @param lower a numeric vector giving the lower bounds of the variables.
#' @param upper a numeric vector giving the upper bounds of the variables.
#' @param A a numeric matrix giving the quadratic part of the objective.
#' @param lhs a numeric vector giving the left hand-side of the linear constraints.
#' @param rhs a numeric vector giving the right hand-side of the linear constraints.
#' @param types a integer vector or character vector giving the variable types.
#'      \code{"C"} or \code{"1"} for continuous,
#'      \code{"I"} or \code{"2"} for integer,
#'      \code{"SC"} or \code{"3"} for semi continuous,
#'      \code{"SI"} or \code{"4"} for semi integer and
#'      \code{"II"} or \code{"5"} for implicit integer.
#' @param maximum TODO
#' @param offset a numeric value giving the offset.
#' @param control a list giving additional options for the solver
#' @param dry_run a logical if true only the model is returned.
#' @examples
#' # Min    f  =  x_0 +  x_1 + 3
#' # s.t.                x_1 <= 7
#' #        5 <=  x_0 + 2x_1 <= 15
#' #        6 <= 3x_0 + 2x_1
#' # 0 <= x_0 <= 4; 1 <= x_1
#' A <- rbind(c(0, 1), c(1, 2), c(3, 2))
#' s <- highs_solve(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf),
#'                  A = A, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf),
#'                  offset = 3)
#' s[["objective_value"]]
#' @export
highs_solve <- function(Q = NULL, L, lower, upper, A, lhs, rhs, types, maximum = FALSE,
                        offset = 0, control = list(), dry_run = FALSE) {
    assert_numeric(L, any.missing = FALSE)
    nvars <- length(L)
    if (missing(A)) {
        A <- lhs <- rhs <- NULL
        ncons <- 0L
    } else {
        stopifnot(is.vector(L), !(missing(lhs) & missing(rhs)))
        cscA <- as_csc(A)
        ncons <- cscA[["nrow"]]
    }
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
}
