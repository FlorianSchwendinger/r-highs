#
# Script interactively sent to the terminal.
#
# docker.io/rocker/r-devel-san bash
docker run -it \
	-v ${HOME}/gitlab/roigrp/solvers/highs:/home/docker/highs \
	localhost/r-devel-san-cmake:latest bash


cd /home/docker/highs
RD CMD build .
RD CMD INSTALL highs_*.tar.gz
RD CMD check --use-valgrind highs_*.tar.gz

RD --valgrid -f ./tests/runtime_error.R

exit 0
