library("Matrix")
library(SparseM)

a <- rnorm(5*4)
a[abs(a)<0.7] <- 0
A <- matrix(a,5,4)

csc <- as.matrix.csc(A)
class(csc)
csc

csr <- as.matrix.csr(A)
class(csr)
str(csr)

dgc <- as(A, "dgCMatrix")
dgc

dgr <- as(A, "RsparseMatrix")


str(csc)
str(dgc)
#
str(dgr)
str(csr)


classes <- highs:::allowed_matrix_classes()

checkmate::assert_class(A, classes)
checkmate::assert_multi_class(A, classes)
checkmate::assert_multi_class(cars, classes)

