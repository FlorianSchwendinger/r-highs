library(highs)

A <- rbind(c(0, 1), c(1, 2), c(3, 2))
s <- highs_solve(L = c(1.0, 1), lower = c(0, 1), upper = c(4, Inf), A = A,
				 lhs = c(-Inf, 5, 6), rhs = c(7, 15, Inf), control = list(mip_rel_gap = 0.1))

examples