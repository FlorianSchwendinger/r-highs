library("rhub")

# rhub_setup()
rc_new_token()

rhub_platforms()

path <- normalizePath(dir("..", pattern = "highs.*tar.gz", full.names = TRUE))

platforms <- c("linux", "macos", "macos-arm64", "windows", "clang-asan", "clang18")
email <- "FlorianSchwendinger@gmx.at"
rc_submit(path, platforms = platforms, email = email)

