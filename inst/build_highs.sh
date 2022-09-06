#!/bin/bash

if test -z "${MAKE}"; then MAKE=`which make` 2> /dev/null; fi
if test -z "${MAKE}"; then MAKE=`which /Applications/Xcode.app/Contents/Developer/usr/bin/make` 2> /dev/null; fi


if test -z "${CMAKE_EXE}"; then CMAKE_EXE=`which cmake4` 2> /dev/null; fi
if test -z "${CMAKE_EXE}"; then CMAKE_EXE=`which cmake3` 2> /dev/null; fi
if test -z "${CMAKE_EXE}"; then CMAKE_EXE=`which cmake2` 2> /dev/null; fi
if test -z "${CMAKE_EXE}"; then CMAKE_EXE=`which cmake` 2> /dev/null; fi
if test -z "${CMAKE_EXE}"; then CMAKE_EXE=`which /Applications/CMake.app/Contents/bin/cmake` 2> /dev/null; fi


if test -z "${CMAKE_EXE}"; then
    echo "Could not find 'cmake'!"
    exit 1
fi


: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
    echo "'R_HOME' could not be found!"
    exit 1
fi

: ${R_CC=`"${R_HOME}/bin/R" CMD config CC`}
R_MACHINE=`"${R_HOME}/bin/Rscript" -e 'cat(Sys.info()["machine"])'`


R_HIGHS_PKG_HOME=`pwd`
HIGHS_SRC_DIR=${R_HIGHS_PKG_HOME}/inst/HiGHS
R_HIGHS_BUILD_DIR=${HIGHS_SRC_DIR}/build
R_HIGHS_LIB_DIR=${R_HIGHS_PKG_HOME}/src/highslib

mkdir -p ${R_HIGHS_BUILD_DIR}
mkdir -p ${R_HIGHS_LIB_DIR}
cd ${R_HIGHS_BUILD_DIR}


export CC=`"${R_HOME}/bin/R" CMD config CC`
export CXX=`"${R_HOME}/bin/R" CMD config CXX`
export CXX11=`"${R_HOME}/bin/R" CMD config CXX11`
export CXXFLAGS=`"${R_HOME}/bin/R" CMD config CXXFLAGS`
export CFLAGS=`"${R_HOME}/bin/R" CMD config CFLAGS`
export CPPFLAGS=`"${R_HOME}/bin/R" CMD config CPPFLAGS`
export LDFLAGS=`"${R_HOME}/bin/R" CMD config LDFLAGS`


echo ""
echo "arch: '$(arch)'"
echo "R_MACHINE: '${R_MACHINE}'"
echo "R_CC: '${R_CC}'"
echo "CC: '${CC}'"
echo "CXX: '${CXX}'"
echo "CXX11: '${CXX11}'"
echo ""
 

if test "$(uname -s)" = "Darwin"; then
    if test "${R_MACHINE}" = "arm64"; then
        echo "Detected 'darwin' with 'M1'"
        OSX_ARM64_OPTS='-DCMAKE_OSX_ARCHITECTURES="arm64"'
    fi
fi


${CMAKE_EXE} .. -DCMAKE_INSTALL_PREFIX=${R_HIGHS_LIB_DIR} -DCMAKE_POSITION_INDEPENDENT_CODE:bool=ON -DFAST_BUILD:bool=ON -DSHARED:bool=OFF -DBUILD_TESTING:bool=OFF ${OSX_ARM64_OPTS}

${MAKE} install
