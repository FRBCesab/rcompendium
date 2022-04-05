
# rcompendium <img src="man/figures/hexsticker.png" align="right" style="float:right; height:120px;"/>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rcompendium)](https://CRAN.R-project.org/package=rcompendium/)
[![R CMD
check](https://github.com/FRBCesab/rcompendium/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/FRBCesab/rcompendium/actions/workflows/R-CMD-check.yaml)
[![Website
deployment](https://github.com/FRBCesab/rcompendium/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/FRBCesab/rcompendium/actions/workflows/pkgdown.yaml)
[![Test
coverage](https://github.com/FRBCesab/rcompendium/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/FRBCesab/rcompendium/actions/workflows/test-coverage.yaml)
[![codecov](https://codecov.io/gh/FRBCesab/rcompendium/branch/main/graph/badge.svg)](https://app.codecov.io/gh/FRBCesab/rcompendium)
[![License: GPL (\>=
2)](https://img.shields.io/badge/License-GPL%20%28%3E%3D%202%29-blue.svg)](https://choosealicense.com/licenses/gpl-2.0/)
[![LifeCycle](https://img.shields.io/badge/lifecycle-stable-green)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![Project Status:
Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Dependencies](https://img.shields.io/badge/dependencies-12/69-red?style=flat)](#)
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
-   Setting the units tests process in `tests/`.
-   Creation of a `README.Rmd` with HexSticker (template) and badges.
-   Autocompletion of maintainer information.
-   Creation of a GitHub repository.
-   Configuration of GitHub Actions to automatically:
    -   check and test package (`R CMD Check`);
    -   report the code coverage (`covr`);
    -   build and deploy website (`pkgdown`);
    -   render `README.md`.

This package heavily relies on the R packages
[`devtools`](https://devtools.r-lib.org) and
[`usethis`](https://usethis.r-lib.org) and follows recommendations made
by [Hadley Wickham & Jenny Bryan](https://r-pkgs.org) and [Ben
Marwick](https://peerj.com/preprints/3192/).

## Installation

You can install the stable version from
[CRAN](https://cran.r-project.org/) with:

``` r
## Install stable version of < rcompendium > from CRAN ----
install.packages("rcompendium")
```

Or you can install the development version from
[GitHub](https://github.com/) with:

``` r
## Install < remotes > package (if not already installed) ----
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

## Install dev version of < rcompendium > from GitHub ----
remotes::install_github("FRBCesab/rcompendium")
```

## Usage

Please read the [Get
started](https://frbcesab.github.io/rcompendium/articles/rcompendium.html)
vignette and pay attention to the sections
[Prerequisites](https://frbcesab.github.io/rcompendium/articles/rcompendium.html#prerequisites)
and
[Usage](https://frbcesab.github.io/rcompendium/articles/rcompendium.html#usage)

Others available vignettes:

-   [Developing a
    Package](https://frbcesab.github.io/rcompendium/articles/developing_a_package.html)
-   [Working with a
    Compendium](https://frbcesab.github.io/rcompendium/articles/working_with_a_compendium.html)

## Examples

:boom: This [package](https://github.com/ahasverus/demo.package) was set
up by running `rcompendium::new_package()`

:boom: This [research
compendium](https://github.com/ahasverus/demo.compendium) was set up by
running `rcompendium::new_compendium()`

## Citation

Please cite this package as:

> Casajus N. (2022) rcompendium: An R package to create a package or
> research compendium structure. Version 1.0,
> <https://github.com/FRBCesab/rcompendium>.

You can also run:

``` r
citation("rcompendium")

## A BibTeX entry for LaTeX users is:
## 
## @Manual{,
##   title  = {{rcompendium}: {An} {R} package to create a package or research compendium structure},
##   author = {{Casajus N.}},
##   year   = {2022},
##   note   = {R package version 1.0},
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
