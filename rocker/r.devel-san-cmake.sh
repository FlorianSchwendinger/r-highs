#
# Script interactively sent to the terminal.
#
# docker.io/rocker/r-devel-san bash
HDIR=$(realpath ..)
docker run -it -v ${HDIR}:/home/docker/highs rocker/r-devel-san:latest bash

apt-get install -y libhighs-dev
R -e "install.packages(c('Rcpp', 'checkmate', 'tinytest'))"


cd /home/docker/highs
ls
RD CMD build .
RD CMD INSTALL highs_*.tar.gz
RD CMD check --use-valgrind highs_*.tar.gz

RD --valgrid -f ./tests/runtime_error.R

exit 0
