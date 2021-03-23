## Test environments

* local macOS 11.2.3 install, R 4.0.4
* Mac OS X 10.15 (on GitHub Actions), r-release (R 4.0.4)
* Windows Server 2019 (on GitHub Actions), r-release (R 4.0.4)
* Ubuntu 18.04 (on GitHub Actions), r-devel, r-release (R 4.0.4), r-oldrel


## R CMD check results

0 error | 0 warning | 1 note

* checking CRAN incoming feasibility ... NOTE

  Maintainer: ‘Nicolas Casajus <nicolas.casajus@fondationbiodiversite.fr>’
  New submission


## Downstream dependencies

There are currently no downstream dependencies for this package.


## Resubmit comments

* `DESCRIPTION` file: replace "The aim of the package 'rcompendium' is to make 
easier..." by "Makes easier..."

* Function `set_credentials()` does not write the `.Rprofile` file anymore 
(not allowed by CRAN policies). Instead this function opens this file and users 
need to manually paste the content of the clipboard.

* Replace `utils::installed.packages()` by `find.package()`

* Increase version (patch) number: v 0.5.1
