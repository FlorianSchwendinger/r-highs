R ?= R
Rclang ?= R412-clang

readme:
	$(R) -e 'rmarkdown::render("README.Rmd", clean = FALSE)'
	pandoc README.md -s --highlight-style=pygments -o README.html
	# pandoc README.md -o README.html

compile_attributes:
	$(R) -e 'Rcpp::compileAttributes(".")'

docs:
	$(R) -e 'library("roxygen2"); roxygenize(".", c("rd", "namespace"), load_source)'

build: compile_attributes docs
	$(R) CMD build .

inst: build
	$(R) CMD INSTALL highs*.tar.gz
	
check: build
	$(R) CMD check highs*.tar.gz

check_as_cran: build
	$(R) CMD check --as-cran highs*.tar.gz


clang_compile_attributes:
	$(Rclang) -e 'Rcpp::compileAttributes(".")'

clang_build: clang_compile_attributes
	$(Rclang) CMD build .

clang_inst: clang_build
	$(Rclang) CMD INSTALL highs*.tar.gz

clang_check: build
	$(Rclang) CMD check highs*.tar.gz

clang_check_as_cran: build
	$(Rclang) CMD check --as-cran highs*.tar.gz


manual: clean
	$(R) CMD Rd2pdf --output=Manual.pdf .

clean:
	rm -f Manual.pdf README.knit.md README.html
	rm -rf .Rd2pdf*
	rm -rf highs.Rcheck

check_all: build
	$(R) -e "rhub::check(dir(pattern = 'highs_.*.tar.gz'), platforms = c('macos-highsierra-release-cran', 'debian-clang-devel', 'windows-x86_64-devel', 'fedora-clang-devel'))"

check_fedora: build
	$(R) -e "rhub::check(dir(pattern = 'highs_.*.tar.gz'), platforms = 'fedora-clang-devel')"

check_win: build
	$(R) -e "rhub::check(dir(pattern = 'highs_.*.tar.gz'), platforms = 'windows-x86_64-devel')"

check_old_win: build
	$(R) -e "rhub::check(dir(pattern = 'highs_.*.tar.gz'), platforms = 'windows-x86_64-devel')"

devcheck_win_devel: build
	$(R) -e "devtools::check_win_devel(email = 'FlorianSchwendinger@gmx.at')"

devcheck_win_release: build
	$(R) -e "devtools::check_win_release(email = 'FlorianSchwendinger@gmx.at')"

devcheck_win_oldrelease: build
	$(R) -e "devtools::check_win_oldrelease(email = 'FlorianSchwendinger@gmx.at')"

devcheck_mac_release: build
	$(R) -e "devtools::check_win_release(email = 'FlorianSchwendinger@gmx.at')"

check_mac: build
	$(R) -e "rhub::check(dir(pattern = 'highs_.*.tar.gz'), platforms = 'macos-highsierra-release-cran')"

check_linux_san: build
	$(R) -e "rhub::check(dir(pattern = 'highs_.*.tar.gz'), platforms = 'linux-x86_64-rocker-gcc-san')"

check_debian:
	$(R) -e "rhub::check(dir(pattern = 'highs_.*.tar.gz'), platforms = 'debian-clang-devel')"
