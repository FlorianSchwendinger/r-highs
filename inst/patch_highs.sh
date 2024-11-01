#!/bin/bash

# Found the following sources/headers with CR or CRLF line endings:
dos2unix ./HiGHS/extern/filereaderlp/reader.hpp

# Found the following sources/headers not terminated with a newline:
# echo "" >> ./HiGHS/src/parallel/HighsBinarySemaphore.h
# echo "" >> ./HiGHS/src/parallel/HighsCacheAlign.h
# echo "" >> ./HiGHS/src/parallel/HighsCombinable.h
# echo "" >> ./HiGHS/src/parallel/HighsMutex.h
# echo "" >> ./HiGHS/src/parallel/HighsRaceTimer.h
# echo "" >> ./HiGHS/src/parallel/HighsSchedulerConstants.h
# echo "" >> ./HiGHS/src/presolve/ICrashUtil.h

# function declaration isn't a prototype

sed -i 's/PDHG_PrintHugeCUPDHG()/PDHG_PrintHugeCUPDHG(void)/' ./HiGHS/src/pdlp/cupdlp/cupdlp_utils.h
sed -i 's/PDHG_PrintHugeCUPDHG() /PDHG_PrintHugeCUPDHG(void) /' ./HiGHS/src/pdlp/cupdlp/cupdlp_utils.c

sed -i 's/PDHG_PrintUserParamHelper()/PDHG_PrintUserParamHelper(void)/' ./HiGHS/src/pdlp/cupdlp/cupdlp_utils.h
sed -i 's/PDHG_PrintUserParamHelper() /PDHG_PrintUserParamHelper(void) /' ./HiGHS/src/pdlp/cupdlp/cupdlp_utils.c


  
