
check <- environment(tools:::.check_packages)
ls(check, all.names = TRUE, pattern = "^check_src")

for (name in ls(check, all.names = TRUE)) {
	env <- environment(check[[name]])
	if (is.null(env)) {
		next
	}
	keys <- ls(env, pattern = "check_src")
	if (length(keys) > 0) {
		print(name)
	}
}

ls(environment(check$check_packages_in_dir), pattern = "check_src")