# v0.1-3
On winbuilder R-release (R-4.2.1) and R-devel (R-4.3.0) I get the message
"Warning: this package has a non-empty 'configure.win' file, so building only the main architecture"
Which I guess is a false positive since Rtools 4.2 states "32-bit builds are no longer supported".

From the tests I can do on r-hub and winbuilder, it appears all the issues are fixed.
Note the compilation on "r-oldrel-windows-ix86+x86_64" is expected to fail,
CMAKE >= 3.16 is required and 3.15.5 is provided .
The winbuilder message says
'The C++ compiler "D:/Compiler/rtools40/mingw64/bin/g++.exe" is not able to compile a simple test program.'
https://win-builder.r-project.org/biGPzYmI2SiN/00install.out

