
# rcompendium <img src="man/figures/hexsticker.png" height="120" align="right"/>

<!-- badges: start -->

[![R CMD
check](https://github.com/FRBCesab/rcompendium/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/FRBCesab/rcompendium/actions/workflows/R-CMD-check.yaml)
[![Website
deployment](https://github.com/FRBCesab/rcompendium/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/FRBCesab/rcompendium/actions/workflows/pkgdown.yaml)
[![Test
coverage](https://github.com/FRBCesab/rcompendium/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/FRBCesab/rcompendium/actions/workflows/test-coverage.yaml)
[![codecov](https://codecov.io/gh/FRBCesab/rcompendium/branch/main/graph/badge.svg)](https://app.codecov.io/gh/FRBCesab/rcompendium)
[![License: GPL (&gt;=
2)](https://img.shields.io/badge/License-GPL%20%28%3E%3D%202%29-blue.svg)](https://choosealicense.com/licenses/gpl-2.0/)
[![LifeCycle](man/figures/lifecycle/lifecycle-stable.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![Project Status:
Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Dependencies](https://img.shields.io/badge/dependencies-12/76-red?style=flat)](#)
<!-- badges: end -->

In the area of open science, making reproducible analyses is a strong
prerequisite. But sometimes it is difficult 1) to find the good
structure to organize files and 2) to set up the whole project. The aim
of the package `rcompendium` is to make easier the creation of R
package/research compendium (i.e. a predefined files/folders structure)
so that users can focus on the code/analysis instead of wasting time
organizing files.

A full ready-to-work structure will be set up with the following
features:

-   Initialization of the [GIT](https://git-scm.com/) version control.
-   Creation of a minimal R package structure (`DESCRIPTION` and
    `NAMESPACE` files, and `R/` and `man/` folders).
-   Creation of additional files (`LICENSE.md`, `inst/CITATION`, etc.).
-   Creation of a *Get started* vignette in `vignettes/`.
-   Setting the units tests process.
-   Creation of a `README.Rmd` with HexSticker (template) and badges.
-   Autocompletion of maintainer information.
-   Creation of a GitHub repository.
-   Configuration of GitHub Actions to automatically:
    -   check and test package (`R CMD Check`);
    -   report the code coverage (`covr`);
    -   build and deploy website (`pkgdown`).

This package heavily relies on the R packages
[`devtools`](https://devtools.r-lib.org) and
[`usethis`](https://usethis.r-lib.org) and follows recommendations made
by [Hadley Wickham & Jenny Bryan](https://r-pkgs.org) and [Ben
Marwick](https://peerj.com/preprints/3192/).

## Overview

The strength of `rcompendium` is to create the whole structure in one
command line by using the function `new_package()` (or
`new_compendium()`). The default settings will produce the following
structure:

    .
    │
    ├── pkg.Rproj                   # (optional) Created by user 
    │
    ├── .git/                       # GIT tracking folder
    ├── .gitignore                  # Specific to R packages
    |
    ├── .github/                    # (optional) GitHub Actions settings
    │   └── workflows/
    │       ├── pkgdown.yaml        # Configuration file to build & deploy website
    │       ├── R-CMD-check.yaml    # Configuration file to check & test package
    │       └── test-coverage.yaml  # Configuration file to build & deploy website
    │
    ├── _pkgdown.yaml               # (optional) User website settings
    │
    ├── R/                          # R functions
    │   ├── fun-demo.R              # Example of an R function
    │   └── pkg-package.R           # Dummy R file for package-level documentation
    │
    ├── man/                        # R functions helps (automatically updated)
    │   ├── print_msg.Rd            # Documentation of the demo R function
    │   ├── pkg-package.Rd          # Package-level documentation
    │   └── figures/                # Figures for the README 
    │       └── hexsticker.png      # Template R package HexSticker
    │
    ├── tests/
    │   ├── testthat.R              # Units tests settings
    │   └── testthat/               # Units tests folder
    │       └── test-demo.R         # Units tests for the function print_msg()
    |
    ├── vignettes/
    │   └── pkg.Rmd                 # (optional) Package tutorial              [*]
    │
    ├── DESCRIPTION                 # Project metadata                         [*]
    ├── NAMESPACE                   # Automatically generated
    ├── .Rbuildignore               # List of files/folders to be ignored while 
    │                               # checking the package
    ├── inst/
    │   └── CITATION                # BiBTeX entry to cite the R package       [*]
    │
    ├── LICENSE                     # (optional) If License = MIT
    ├── LICENSE.md                  # Content of the chosen license
    │
    ├── README.md                   # GitHub README (automatically generated)
    ├── README.Rmd                  # GitHub README (to knit)                  [*]
    /
    /
    ├── data/                       # User raw data (.csv, .gpkg, etc.)        [¶]
    ├── rscripts/                   # R scripts (no functions) to run analyses [¶]
    ├── outputs/                    # Outputs created by R scripts             [¶]
    ├── figures/                    # Figures created by R scripts             [¶]
    └── paper/                      # Article based on analyses                [¶]
    │
    └── make.R                      # Master R scripts to run all analyses     [¶]


    [*] These files are automatically edited but user needs to add manually 
        some information.
    [¶] These folders/files are also created when using new_compendium().

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
## Install < remotes > package (if not already installed) ----
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

## Install dev version of < rcompendium > from GitHub ----
remotes::install_github("FRBCesab/rcompendium")
```

## Get started

Please read the
[Vignette](https://frbcesab.github.io/rcompendium/articles/rcompendium.html)
and pay attention to the sections
[Prerequisites](https://frbcesab.github.io/rcompendium/articles/rcompendium.html#prerequisites)
and
[Usage](https://frbcesab.github.io/rcompendium/articles/rcompendium.html#usage)

:boom: This [package](https://github.com/ahasverus/pkgtest) was created
by running:

``` r
rcompendium::new_package()
```

:boom: This [research compendium](https://github.com/ahasverus/comptest)
was created by running:

``` r
rcompendium::new_compendium()
```

**N.B.** Before running these commands, a new RStudio project needs to
be created.

## Citation

Please cite this package as:

> Casajus N. (2021) rcompendium: An R package to create a package or
> research compendium structure. Version 0.5.1,
> <https://github.com/FRBCesab/rcompendium>.

You can also run:

``` r
citation("rcompendium")

## A BibTeX entry for LaTeX users is:
## 
## @Manual{,
##   title  = {{rcompendium}: {An} {R} package to create a package or research compendium structure},
##   author = {{Casajus N.}},
##   year   = {2021},
##   note   = {R package version 0.5.1},
##   url    = {https://github.com/FRBCesab/rcompendium},
## }
```

## Contributing

You are welcome to contribute to the `rcompendium` project. Please read
our [Contribution
Guidelines](https://frbcesab.github.io/rcompendium/CONTRIBUTING.html).

Please note that the `rcompendium` project is released with a
[Contributor Code of
Conduct](https://frbcesab.github.io/rcompendium/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Colophon

This package is the result of intense discussions and feedback from the
training course [Data Toolbox for Reproducible Research in Computational
Ecology](https://github.com/FRBCesab/datatoolbox) (in French).

`rcompendium` is largely inspired by the package
[`rrtools`](https://github.com/benmarwick/rrtools) developed by [Ben
Marwick *et al.*](https://github.com/benmarwick) and tries to respect
the standard defined by the community. **Special thanks to these
developers!**
