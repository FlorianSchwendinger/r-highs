
test_CRLF <- function(file) {
    contents <- readChar(file, file.size(file), useBytes = TRUE)
    grepl("\r", contents, fixed = TRUE, useBytes = TRUE)
}


test_strict_prototypes <- function(file) {
    # g++ -fsyntax-only -Wstrict-prototypes -w HiGHS/app/cxxopts.hpp
    # cmd <- sprintf("clang -fsyntax-only -Wstrict-prototypes %s", file)
    # contents <- readChar(file, file.size(file), useBytes = TRUE)
    # grepl("void.*\\(\\s*\\)", contents)
    cmd <- sprintf("gcc -fsyntax-only -Wstrict-prototypes %s", file)
    system(cmd)
}


test_terminated_newline <- function(file) {
    contents <- readChar(file, file.size(file), useBytes = TRUE)
    grepl("\n$", contents, fixed = FALSE, useBytes = TRUE)
}


files <- dir("HiGHS", pattern = "\\.([cfh]|cc|cpp|hpp)$", recursive = TRUE, full.names = TRUE)
crlf_files <- files[as.logical(lapply(files, test_CRLF))]
crlf_files
for (file in crlf_files) {
    writeLines(readLines(file), file)
}


nnl_files <- files[!as.logical(lapply(files, test_terminated_newline))]
nnl_files
for (file in nnl_files) {
    writeLines(readLines(file), file)
}


c_files <- dir("HiGHS", pattern = "\\.([c])$", recursive = TRUE, full.names = TRUE)
h_files <- dir("HiGHS", pattern = "\\.([h])$", recursive = TRUE, full.names = TRUE)
h_files <- h_files[gsub("\\.h$", "", h_files) %in% gsub("\\.c$", "", c_files)]
c_files <- c(c_files, h_files)
c_files
file <- c_files[1]


fix_prototypes <- list(
    list(files = c("HiGHS/src/pdlp/cupdlp/cupdlp_utils.h", "HiGHS/src/pdlp/cupdlp/cupdlp_utils.c"),
         prototypes = c("void PDHG_PrintHugeCUPDHG(%s)", "void PDHG_PrintUserParamHelper(%s)"))
)


for (fix in fix_prototypes) {
    for (file in fix$files) {
        src <- readChar(file, file.size(file), useBytes = TRUE)
        for (prototype in fix$prototypes) {
            src <- gsub(sprintf(prototype, ""), sprintf(prototype, "void"), src, fixed = TRUE)
        }
        writeLines(src, con = file)
    }
}


# out <- lapply(c_files, test_strict_prototypes)
# out <- lapply(c_files[!as.logical(out)], test_strict_prototypes)
