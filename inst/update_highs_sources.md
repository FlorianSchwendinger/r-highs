# HiGHS patched

CRAN requires me to do some changes which the HiGHS authors are not willing to do.
This file documents the changes and the update.

## Upstream
The upstream repo to which I apply the patches required by CRAN is located at 
`https://gitlab.com/schwe/highs-patched`.

## Necessary fixes
- **Windows line endings** (`grep -lUPr '\r$' .`)    
  CRAN-checks detect windows line endings and message
  ```
    Found the following sources/headers with CR or CRLF line endings:
      inst/HiGHS/extern/filereaderlp/reader.cpp
      inst/HiGHS/extern/filereaderlp/reader.hpp
    Some Unix compilers require LF line endings.
  ```

- CRAN uses `-Wbitwise-instead-of-logical` flag    
  The checks find 
  ```
          numBin += ((mipsolver.model_->col_lower_[i] == 0.0) &
                     (mipsolver.model_->col_upper_[i] == 1.0));
  ```
  in `HiGHS/src/mip/HighsMipSolverData.cpp` line 586 to 587
  which triggers a waring which CRAN requires to fix.

- ZLIB not available on CRAN Windows machine
  On one of the CRAN Windows machines CMAKE can not detect ZLIB which causes an error.
  Since the read capabilities are not used, `find_package(ZLIB 1.2.3)` is removed from
  `CMakeLists.txt` this causes an error since `strdup` is than no longer found,
  which can be resolved by adding an the following else statement to `extern/filereaderlp/reader.cpp`.
  ```
    #include "HConfig.h"  // for ZLIB_FOUND
    #ifdef ZLIB_FOUND
    #include "zstr.hpp"
    #else
    #define _POSIX_C_SOURCE 200809L
    #include <string.h>
    #endif
   ```

- Headers not terminated with a newline
  ```
  Found the following sources/headers not terminated with a newline:
    src/highslib/include/highs/parallel/HighsBinarySemaphore.h
    src/highslib/include/highs/parallel/HighsCacheAlign.h
    src/highslib/include/highs/parallel/HighsCombinable.h
    src/highslib/include/highs/parallel/HighsMutex.h
    src/highslib/include/highs/parallel/HighsParallel.h
    src/highslib/include/highs/parallel/HighsSchedulerConstants.h
    src/highslib/include/highs/parallel/HighsSpinMutex.h
    src/highslib/include/highs/presolve/ICrash.h
    src/highslib/include/highs/presolve/ICrashUtil.h
  Some compilers warn on such files.
  ```

