#
# Patch the code so it passes the CRAN checks.
#
if (dir.exists("inst/HiGHS")) {
  src_dir <- normalizePath("inst/HiGHS")
} else if (dir.exists("HiGHS")) {
  src_dir <- normalizePath("HiGHS")
} else {
  stop("Please run this script from the package root directory.")
}
writeLines(sprintf("Using source directory: %s", src_dir))


# 1. Remove deprecation message
file <- normalizePath(file.path(src_dir, "highs/lp_data/HighsDeprecated.cpp"))
src <- paste(readLines(file), collapse = "\n")
new_src <- gsub("deprecationMessage\\(.*?\\);", "", src, perl = TRUE)
writeLines(new_src, file)

# 2. Change C++ std
files <- normalizePath(file.path(src_dir, c("CMakeLists.txt", "cmake/cpp-highs.cmake")))
for (file in files) {
  src <- readLines(file)
  src <- gsub("CMAKE_CXX_STANDARD 11", "CMAKE_CXX_STANDARD 17", src, fixed = TRUE)
  src <- gsub("c++11", "c++17", src, fixed = TRUE)
  writeLines(src, file)
}

# 3. Remove app and examples
files <- dir(src_dir, pattern = "CMakeLists.txt", recursive = TRUE, full.names = TRUE)
remove_us <- c(
  "add_subdirectory(app)",
  "add_subdirectory(examples)",
  "add_subdirectory(check)"
)

for (file in files) {
  src <- paste(readLines(file), collapse = "\n")
  for (remove_u in remove_us) {
    src <- gsub(remove_u, "", src, fixed = TRUE)
  }
  writeLines(src, file)
}


#
# Overwrite not necessary files with an empty file so the Makefiles don't have to be changed.
#
code_chunk_template <- "
#ifndef DELETE_%i_H_
#define DELETE_%i_H_
// ISO C forbids an empty translation unit [-Wpedantic]
int silly_pedantic_rules = 0;
#endif
"

it <- 1L
files <- dir("inst/HiGHS/highs/pdlp", pattern = "\\.(h|c|cpp)$", recursive = TRUE, full.names = TRUE)
for (file in files) {
  writeLines(sprintf(code_chunk_template, it, it), file)
  it <- it + 1
}

files <- dir("inst/HiGHS/check", recursive = TRUE, full.names = TRUE)
for (file in files) {
  writeLines(sprintf(code_chunk_template, it, it), file)
  it <- it + 1
}

files <- dir("inst/HiGHS/examples", recursive = TRUE, full.names = TRUE)
for (file in files) {
  writeLines(sprintf(code_chunk_template, it, it), file)
  it <- it + 1
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



file <- normalizePath("inst/HiGHS/highs/io/HighsIO.cpp")
src <- paste(readLines(file), collapse = "\n")
src <- gsub("highsLogUser\\(.*Running HiGHS.*?\\);", "", src)
writeLines(src, file)


#
# FIX bazel files
#
files <- dir(src_dir, pattern = "(.bazel|.build|cmake)$", recursive = TRUE, full.names = TRUE)
remove_us <- c(
  "(\\s+|)(\"|'|)(highs/|)interfaces/highs_c_api.cpp(\"|'|)(,|)",
  "(\\s+|)(\"|'|)(highs/|)interfaces/highs_c_api.h(\"|'|)(,|)"
)

for (file in files) {
  src <- paste(readLines(file), collapse = "\n")
  for (remove_u in remove_us) {
    src <- gsub(remove_u, "", src, perl = TRUE)
  }
  writeLines(src, file)
}
