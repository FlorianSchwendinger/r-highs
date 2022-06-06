
readme:
	R -e 'rmarkdown::render("README.Rmd", clean = FALSE)'

compile_attributes:
	R -e 'Rcpp::compileAttributes(".")'

docs:
	R -e 'library("roxygen2"); roxygenize(".", c("rd", "namespace"), load_source)'

build: compile_attributes docs
	R CMD build .

inst: build
	R CMD INSTALL highs*.tar.gz
	
check: build
	R CMD check highs*.tar.gz

manual:
	R CMD Rd2pdf --output=Manual.pdf .

clean:
	rm -f Manual.pdf README.knit.md README.html
	rm -rf .Rd2pdf*


check_mac_m1: build
	R -e "rhub::check(dir(pattern = 'highs_.*.tar.gz'), platform = 'macos-m1-bigsur-release')"

check_mac_old: build
	R -e "rhub::check(dir(pattern = 'highs_.*.tar.gz'), platform = 'macos-highsierra-release-cran')"
