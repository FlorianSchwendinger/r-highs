
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
	rm -f Manual.pdf
	rm -rf .Rd2pdf*
