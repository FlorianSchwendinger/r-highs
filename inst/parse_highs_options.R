library("jsonlite")

options_file <- normalizePath("HiGHS/highs/lp_data/HighsOptions.h")
src <- paste(readLines(options_file), collapse = "\n")

m <- gregexpr("struct\\s+HighsOptionsStruct\\s+\\{.*?\\}\\s*;", src)
src <- unlist(regmatches(src, m))
patterns <- unlist(regmatches(src, gregexpr("#ifdef.*?#endif", src)))
for (pattern in unlist(patterns)) {
   src <- gsub(pattern, "", src, fixed = TRUE)
}

writeLines(src)

opts <- strsplit(src, "\n")[[1]]
opts <- gsub("//.*", "", opts)
opts <- trimws(opts)
opts <- opts[nchar(opts) > 0]


start_defaults <- grep("~HighsOptionsStruct", opts)
defaults <- opts[start_defaults:length(opts)]
defaults <- defaults[-grep("HighsOptionsStruct", defaults)]
defaults <- gsub("(^\\s*:|,\\s*$)", "", defaults)
defaults <- trimws(defaults)
defaults <- defaults[nchar(defaults) > 0]
default_values <- gsub("(.*\\(|\\).*)", "", defaults)
default_options <- data.frame(variable = gsub("\\(.*", "", defaults))
default_options$value <- lapply(default_values, fromJSON)
default_options$class <- sapply(default_options$value, class)
unique(default_options[, -1])



dtypes <- opts[1:(start_defaults - 2)]
dtypes <- dtypes[-grep("HighsOptionsStruct", dtypes)]
dtypes <- dtypes[nchar(dtypes) > 0]
dtypes <- as.data.frame(do.call(rbind, strsplit(dtypes, "\\s+")))
colnames(dtypes) <- c("type", "option")
dtypes$option <- trimws(gsub(";", "", dtypes$option))
# type_mapping <- c("bool", "double", "HighsInt", "std::string")
dtypes$type <- dplyr::recode(dtypes$type, "HighsInt" =  "integer", "std::string" = "string")
table(dtypes$type)

setdiff(dtypes$option, default_options$variable)
setdiff(default_options$variable, dtypes$option)

rownames(dtypes) <- NULL
dtypes <- dtypes[, c("option", "type")]
code <- paste(deparse(dtypes), collapse = "\n")
ofi <- normalizePath("../R/constants.R")
writeLines(sprintf("\nHIGHS_OPTIONS <- %s", code), ofi)
