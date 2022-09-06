
highs_options_file <- "../inst/HiGHS/src/lp_data/HighsOptions.h"
src  <- readLines(highs_options_file)

i <- grep("struct\\s+HighsOptionsStruct", src)
src <- src[seq(i + 1L, length(src))]
j <- head(grep("}", src), 1L)
src <- src[seq_len(j - 1L)]
# this can't handle nested stuff
istart <- grep("#ifdef", src)
iend <- grep("#endif", src)
idx <- unlist(mapply(seq.int, istart, iend, SIMPLIFY = FALSE), FALSE, FALSE)
src <- src[-idx]
src <- trimws(src)
src <- src[nchar(src) > 0L]
src


d <- data.frame(src = src)
b <- startsWith(d$src, "//")
d$category <- ifelse(b, d$src, NA)
d$category <- gsub("//\\s*", "", d$category)
d$category[grep("advanced", d$category, ignore.case = TRUE)] <- "advanced"
d$category[grep("file", d$category, ignore.case = TRUE)] <- "file"
d$category[grep("highs log", d$category, ignore.case = TRUE)] <- "logging"
d$category[grep("mip", d$category, ignore.case = TRUE)] <- "mip"
d$category[grep("icrash", d$category, ignore.case = TRUE)] <- "icrash"
d$category[grep("run-time", d$category, ignore.case = TRUE)] <- "run-time"
d$category <- zoo::na.locf0(d$category)
d$type <- ifelse(!b, sapply(strsplit(d$src, "\\s+"), "[[", 1L), NA)
d$type <- dplyr::recode(d$type, "std::string" = "string", "HighsInt" = "integer")
d$option <- ifelse(!b, sapply(strsplit(d$src, "\\s+"), "[[", 2L), NA)
d$option <- gsub(";", "", d$option)
d[is.na(d$type), ]
d <- d[!is.na(d$type), ]
d[!d$type %in% c("bool", "integer", "double", "string"),]
d <- d[d$type %in% c("bool", "integer", "double", "string"),]

d <- d[, c("option", "type", "category")]
d

v <- apply(unname(d), 1, as.list)
names(v) <- NULL
con <- textConnection("data", "w")
writeLines(deparse(v), con)
close(con)
s <- paste(data, collapse = "  ")
s <- gsub("\\s+", " ", s)
s <- gsub("^list", "rbind", s)
s <- gsub("list", "c", s)
writeLines(gsub("\\), ", "),\n    ", s))




