
# docker.io/rocker/r-devel-san bash
podman run -it \
	-v ${HOME}/TEMP/pkg_checks:/home/docker/checks \
	-v ${HOME}/gitlab/roigrp/solvers/highs:/home/docker/highs \
	-v ${HOME}/github/FlorianSchwendinger/highs.checks:/home/docker/highs.checks \
	localhost/r-devel-san-cmake:latest bash


cd /home/docker/highs
RD CMD INSTALL highs_*.tar.gz


cd /home/docker/highs.checks
RD CMD build .
RD CMD INSTALL highs.check_*.tar.gz
RD CMD check --use-valgrid highs.check_*.tar.gz


RD --valgrid -f highs.checks/tests/runtime_error.R


q("no")
