: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
    echo "'R_HOME' could not be found!"
    exit 1
fi


CXX11STD=`"${R_HOME}/bin/R" CMD config CXX11STD`
CXX14STD=`"${R_HOME}/bin/R" CMD config CXX14STD`
CXX17STD=`"${R_HOME}/bin/R" CMD config CXX17STD`
CXX20STD=`"${R_HOME}/bin/R" CMD config CXX20STD`
CXX23STD=`"${R_HOME}/bin/R" CMD config CXX23STD`
CXX11STD=$(echo ${CXX11STD} | sed 's/ERROR.*//')
CXX14STD=$(echo ${CXX14STD} | sed 's/ERROR.*//')
CXX17STD=$(echo ${CXX17STD} | sed 's/ERROR.*//')
CXX20STD=$(echo ${CXX20STD} | sed 's/ERROR.*//')
CXX23STD=$(echo ${CXX23STD} | sed 's/ERROR.*//')


export CC=`"${R_HOME}/bin/R" CMD config CC`
export CXX=`"${R_HOME}/bin/R" CMD config CXX`
export CXX11=`"${R_HOME}/bin/R" CMD config CXX11`
export CXX14=`"${R_HOME}/bin/R" CMD config CXX14`
export CXX17=`"${R_HOME}/bin/R" CMD config CXX17`
export CXX22=`"${R_HOME}/bin/R" CMD config CXX20`
export CXX23=`"${R_HOME}/bin/R" CMD config CXX23`
export CXXFLAGS=`"${R_HOME}/bin/R" CMD config CXXFLAGS`
export CFLAGS=`"${R_HOME}/bin/R" CMD config CFLAGS`
export CPPFLAGS=`"${R_HOME}/bin/R" CMD config CPPFLAGS`
export LDFLAGS=`"${R_HOME}/bin/R" CMD config LDFLAGS`


CPLUSPLUS=`${CXX} -dM -E -x c++ - < /dev/null | grep __cplusplus`
CXX_STD_NUM=$(echo $CPLUSPLUS | sed 's/[^0-9]//g' | cut -c 3-4)

CXX_STD_NUM=""
CXX_STD='-std=gnu++117'

if test -z "${CXX_STD}"; then
    CPLUSPLUS=`${CXX} -dM -E -x c++ - < /dev/null | grep __cplusplus`
    CXX_STD_NUM=$(echo $CPLUSPLUS | sed 's/[^0-9]//g' | cut -c 3-4)
else
    CXX_STD_NUM=$(echo $CXX_STD | sed 's/[^0-9]//g')
fi


echo "CXX11STD: '${CXX11STD}'"
echo "CXX14STD: '${CXX14STD}'"
echo "CXX17STD: '${CXX17STD}'"
echo "CXX20STD: '${CXX20STD}'"
echo "CXX23STD: '${CXX23STD}'"


echo "CPLUSPLUS: '${CPLUSPLUS}'"
echo "CXX_STD: '${CXX_STD}'"
echo "CXX_STD_NUM: '${CXX_STD_NUM}'"





