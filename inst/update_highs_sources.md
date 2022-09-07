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
  On one of the CRAN Windows machines CMAKE can not detect ZLIB which