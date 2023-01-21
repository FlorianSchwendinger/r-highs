library("highs")


A <- rbind(c(0, 1), c(1, 2), c(3, 2))
s <- highs_solve(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf),
                 A = A, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf),
                 offset = 3)


library("Matrix")

A <- rbind(c(0, 1), c(1, 2), c(3, 2))
csc <- as(A, "CsparseMatrix")  # dgCMatrix
s0 <- highs_solve(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf),
                  A = csc, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf),
                  offset = 3)

csr <- as(A, "RsparseMatrix")  # dgRMatrix
s1 <- highs_solve(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf),
                  A = csr, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf),
                  offset = 3)

library("SparseM")

csc <- as.matrix.csc(A)
s2 <- highs_solve(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf),
                  A = csc, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf),
                  offset = 3)

csr <- as.matrix.csr(A)
s3 <- highs_solve(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf),
                  A = csr, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf),
                  offset = 3)

library("slam")
stm <- as.simple_triplet_matrix(A)
s4 <- highs_solve(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf),
                  A = stm, lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf),
                  offset = 3)


