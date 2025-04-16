#
# Patch the code so it passes the CRAN checks.
#
src_dir <- "inst/HiGHS"


#
# Overwrite not necessary files with an empty file so the Makefiles don't have to be changed.
#
files <- dir("inst/HiGHS/highs/pdlp", pattern = "\\.(h|c|cpp)$", recursive = TRUE, full.names = TRUE)
for (file in files) {
  writeLines("", file)
}

files <- dir("inst/HiGHS/check", recursive = TRUE, full.names = TRUE)
for (file in files) {
  writeLines("", file)
}

files <- dir("inst/HiGHS/examples", recursive = TRUE, full.names = TRUE)
for (file in files) {
  writeLines("", file)
}


#
# Remove the pdlp solver.
#
src <- readLines("inst/HiGHS/highs/lp_data/HighsSolve.cpp")
src <- gsub("call_status = solveLpCupdlp(solver_object);", "call_status = HighsStatus::kError;", src, fixed = TRUE)
writeLines(src, "inst/HiGHS/highs/lp_data/HighsSolve.cpp")


#
# Remove stdout
#
src <- readLines("inst/HiGHS/highs/Highs.h")
src <- gsub("assert(log_stream != stdout);", "NULL;", src, fixed = TRUE)
writeLines(src, "inst/HiGHS/highs/Highs.h")

# stdout_replacement <- 'Rcpp::stop("CRAN does not allow to use STDOUT!");'
stdout_replacement <- "NULL;"
files <- c("highs/lp_data/HighsRanging.cpp", "highs/io/HighsIO.cpp")
files <- file.path(src_dir, files)
for (file in files) {
  src <- paste(readLines(file), collapse = "\n")
  src <- gsub("(writeRangingFile|vfprintf|fprintf)\\(stdout.*?\\);", stdout_replacement, src)
  writeLines(src, file)
}


#
# Fix C++ files
#
files <- dir("inst/HiGHS", pattern = "\\.(h|cc|cpp|hpp)$", recursive = TRUE, full.names = TRUE)
i <- grep("lp/reader.cpp", files)
for (i in seq_along(files)) {
  src <- readLines(files[i])
  src <- gsub("std::cout", "Rcpp::Rcout", src, fixed = TRUE)
  src <- gsub(" cout <<", " Rcout <<", src, fixed = TRUE)
  src <- gsub(" printf(", " Rprintf(", src, fixed = TRUE)
  src <- gsub("std::abort", "Rcpp::stop", src, fixed = TRUE)
  src <- gsub("abort()", "", src, fixed = TRUE)
  src <- gsub("exit\\(.*?\\)", 'Rcpp::stop("Something went wrong!")', src, perl = TRUE)
  src <- gsub("fflush(stdout);", "NULL;", src, fixed = TRUE)
  src <- gsub("file != stdout", "1", src, fixed = TRUE)
  src <- gsub("file == stdout", "0", src, fixed = TRUE)
  src <- gsub("log_options_.log_stream != stdout", "1", src, fixed = TRUE)
  src <- gsub("log_options.log_stream = stdout;", "NULL;", src, fixed = TRUE)
  src <- gsub("file = stdout;", stdout_replacement, src, fixed = TRUE)
  if (endsWith(files[i], "catch.hpp")) {
    src <- gsub("#ifndef CATCH_CONFIG_NOSTDOUT", "#if 1", src, fixed = TRUE)
    src <- gsub("std::cerr", "Rcpp::Rcerr", src, fixed = TRUE)
    src <- gsub("std::clog", "Rcpp::Rcout", src, fixed = TRUE)
  }
  if (any(grepl("(Rcpp|Rcout|Rprintf)", src))) {
    if (!"#include <Rcpp.h>" %in% src) {
      src <- c("#include <Rcpp.h>", src)  
    }
  }
  writeLines(src, files[i])
}


#
# Fix C-files
#
files <- dir("inst/HiGHS", pattern = "\\.([ch]|cc|cpp|hpp)$", recursive = TRUE, full.names = TRUE)
for (i in seq_along(files)) {
  src <- paste(readLines(files[i]), collapse = "\n")
  m <- gregexpr("\\s+printf\\(.*?\\)\\s*;", src)
  if (any(m[[1]] > 0)) {
    writeLines(files[i])
  }
}

