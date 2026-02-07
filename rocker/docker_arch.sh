#!/bin/bash

docker pull archlinux:latest


HDIR=$(realpath ..)
docker run -it -v ${HDIR}:/home/docker/highs archlinux:latest bash


# install R
cd /home/docker/highs

pacman -Syy
pacman -S --needed base-devel
pacman -S --needed r
pacman -S --needed highs
pacman -S --needed pandoc

R -e "install.packages(c('Rcpp', 'checkmate', 'tinytest'))"
