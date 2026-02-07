#!/bin/bash

# docker pull fedora:latest

HDIR=$(realpath ..)
docker run -it -v ${HDIR}:/home/docker/highs fedora:latest bash


# install R
cd /home/docker/highs

dnf install -y R
dnf install -y coin-or-HiGHS-devel
dnf install -y pandoc


mkdir -p /usr/share/doc/R/html
touch /usr/share/doc/R/html/R.css
R -e "install.packages(c('Rcpp', 'checkmate', 'tinytest'))"
