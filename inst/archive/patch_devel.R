# git reset --hard origin/latest
# git pull origin latest


files <- dir("HiGHS", pattern = "\\.([ch]|cc|cpp|hpp)$", recursive = TRUE, full.names = TRUE)
grep("\\.h$", files, value = TRUE)


# File ‘highs/libs/highs.so’:
#   Found ‘abort’, possibly from ‘abort’ (C)
#     Object: ‘highslib/lib/libhighs.a’
#   Found ‘exit’, possibly from ‘exit’ (C)
#     Object: ‘highslib/lib/libhighs.a’
#   Found ‘printf’, possibly from ‘printf’ (C)
#     Object: ‘highslib/lib/libhighs.a’
#   Found ‘putchar’, possibly from ‘putchar’ (C)
#     Object: ‘highslib/lib/libhighs.a’
#   Found ‘puts’, possibly from ‘printf’ (C), ‘puts’ (C)
#     Object: ‘highslib/lib/libhighs.a’
#   Found ‘stdout’, possibly from ‘stdout’ (C)
#     Object: ‘highslib/lib/libhighs.a’




pattern <- "\\s*std::cout.*?;"
pattern <- ".*abort\\(.*\\).*"
pattern <- ".*exit\\(.*\\).*"
pattern <- ".*printf\\(.*\\).*"

vec <- vector("list", length(files))
for (i in seq_along(files)) {
  file <- files[i]
  src <- readLines(file)
  src <- paste(src, collapse = "\n")
  m <-  regexpr(pattern, src, perl = TRUE)
  if (any(m > 0)) {
    vec[[i]] <- data.frame(file = file, match = regmatches(src, m))
  }
}

x <- dplyr::bind_rows(vec)
x
open_files <- grep("\\.h$", unique(x$file), value = TRUE)
system(sprintf("subl %s", paste(unique(open_files), collapse = " ")))

for (i in seq_along(files)) {
  file <- files[i]
  src <- readLines(file)
  src <- paste(src, collapse = "\n")
  src <- gsub("\\s*(|using)\\s*std::cout.*?;", "", src)
  src <- gsub("\\s*(|using)\\s+cout.*?;", "", src)
  writeLines(src, file)
}




i <- 1L
for (i in seq_along(files)) {
  file <- files[i]
  src <- readLines(file)
  # C replacements
  if (grepl("\\.c$", file)) {
    src <- gsub("exit\\(.*?\\)", 'error("Something went wrong!")', src, perl = TRUE)
    if (!"#include <R.h>" %in% src) {
      src <- c("#include <R.h>", src)  
    }
  }
  # C++ replacements
  src <- gsub("std::cout", "Rcpp::Rcout", src, fixed = TRUE)
  src <- gsub("std::abort", "Rcpp::stop", src, fixed = TRUE)
  src <- gsub("abort()", "", src, fixed = TRUE)
  # Note: Exit is also used in one header but this is a C++ header.
  src <- gsub("exit\\(.*?\\)", 'Rcpp::stop("Something went wrong!")', src, perl = TRUE)
  if (any(grepl("Rcpp", src, fixed = TRUE))) {
    if (!"#include <Rcpp.h>" %in% src) {
      src <- c("#include <Rcpp.h>", src)  
    }
  }
  writeLines(src, file)
}
