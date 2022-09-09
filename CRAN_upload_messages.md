# v0.1-3
On winbuilder R-release (R-4.2.1) and R-devel (R-4.3.0) I get the message
"Warning: this package has a non-empty 'configure.win' file, so building only the main architecture"
Which I guess is a false positive since Rtools 4.2 states "32-bit builds are no longer supported".

From the tests I can do on r-hub and winbuilder, it appears all the issues are fixed.
Note the compilation on "r-oldrel-windows-ix86+x86_64" will fail,
this seams to be related to differences in Rtools 4.0 and Rtools 4.2.
Since this issue will resolve it self when r-release becomes r-oldrel
I addressed that by adding "Rtools (>= 4.2) | Unix" to the SystemRequirements.

Changed e-mail address.
