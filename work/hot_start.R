q("no")
R

library("highs")

attach(getNamespace("highs"))

solver <- new_solver(NULL)
highs_pass_model(
    solver,
    num_col = 2L,
    num_row
)

const int32_t , const int32_t num_row,
                   const int32_t num_nz, const int32_t a_format,
                   const int32_t sense, const double_t offset,
                   NumericVector col_cost, NumericVector col_lower,
                   NumericVector col_upper, NumericVector row_lower,
                   NumericVector row_upper, IntegerVector a_start,
                   IntegerVector a_index, NumericVector a_value,
                   IntegerVector integrality

model_set_ncol(model, 2L)
model_set_nrow(model, 3L)
model_set_sense(model, FALSE)
model_set_offset(model, 3)
model_set_objective(model, c(1, 1))
model_set_lower(model, c(0.0, 1.0))
model_set_upper(model, c(4.0, 1.0e30))
model_set_constraint_matrix(model, "colwise",
    as.integer(c(0, 2, 5)),
    as.integer(c(1, 2, 0, 1, 2)),
    c(1.0, 3.0, 1.0, 2.0, 2.0)
)
model_set_lhs(model, c(-1.0e30, 5.0, 6.0))
model_set_rhs(model, c(7.0, 15.0, 1.0e30))
