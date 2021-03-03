# rcompendium <img src="man/figures/hexsticker.png" height="120" align="right"/>

<!-- badges: start -->

[![R-CMD-check](https://github.com/FRBCesab/rcompendium/workflows/R-CMD-check/badge.svg)](https://github.com/FRBCesab/rcompendium/actions)
[![CRAN
status](https://www.r-pkg.org/badges/version/rcompendium)](https://CRAN.R-project.org/package=rcompendium)
[![License: GPL (&gt;=
2)](https://img.shields.io/badge/License-GPL%20%28%3E%3D%202%29-blue.svg)](https://choosealicense.com/licenses/gpl-2.0)
[![LifeCycle](man/figures/lifecycle/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Project Status:
Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Dependencies](https://img.shields.io/badge/dependencies-15/80-red?style=flat)](#)
<!-- badges: end -->

The goal of `rcompendium` is to create a research compendium, i.e. a
predefined folder structure.

## Mea culpa

…

## Structure of the compendium

Here is the structure of the research compendium created by
`rcompendium`:

    compendium           # Project Root
    │
    ├── .git             # Automatically created (or not)
    ├── .Rbuildignore    # Contains make.R and analysis/
    ├── .gitignore       # Specific to R projects
    ├── compendium.Rproj # Created by user (optional)
    │
    ├── R/               # Contains R functions
    ├── man/             # Contains R functions helps (automatically updated)
    ├── DESCRIPTION      # Project metadata (author, date, dependencies, etc.)
    ├── NAMESPACE
    ├── LICENSE.md       # Content of the chosen license
    |
    ├── analysis/
    │   ├── data/        # Contains user raw data (.csv, .xlsx, .shp, etc.)
    │   ├── rscripts/    # Contains R scripts to run analyses
    │   ├── outputs/     # Contains outputs created by user
    │   └── figures/     # Contains figures created by user
    ├── make.R           # Master R scripts to run all analyses
    │
    ├── README.md        # GitHub README (automatically updated)
    └── README.Rmd       # GitHub README (to rmarkdown::render)

The package `rcompendium` can also be used to create an R package with
the following content:

    package              # Package Root
    │
    ├── .git/            # Automatically created (or not)
    ├── .github/         # GitHub Actions settings (check and deploy)
    ├── .Rbuildignore
    ├── .gitignore       # Specific to R projects
    ├── compendium.Rproj # Created by user (optional)
    ├── _pkgdown.yml     # Website settings
    │
    ├── R/               # Contains R functions
    ├── man/             # Contains R functions helps (automatically updated)
    ├── inst/            # (optional)
    ├── tests/           # (optional)
    ├── vignettes/       # (optional)
    ├── DESCRIPTION      # Project metadata (author, dependencies, etc.)
    ├── NAMESPACE
    ├── LICENSE.md       # Content of the chosen license
    │
    ├── README.md        # GitHub README (automatically updated)
    └── README.Rmd       # GitHub README (to rmarkdown::render)

**N.B. 1.** the research compendium can be built as an R package with
`devtools::install()` but only R functions stored in the **R/** folder
will be available (do not forget to edit R functions documentation and
to run `devtools::document()`). The content of the **analysis/** folder
must be run by sourcing the `make.R` file. All files created by user
must be saved in the subfolders of **analysis/**.

**N.B. 2.** the files `DESCRIPTION` and `make.R` are written from
templates and are specific to myself.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

    # install.packages("remotes")
    remotes::install_github("FRBCesab/rcompendium")

## Usage

Under RStudio, you first need to create a **New project** (with or
without initializing git versioning). If you do not use RStudio IDE, you
need to create a **New folder** and to open R in this directory (by
using `setwd()`).

**N.B.** the name of the compendium will be the same as the current
directory. Don’t worry you will be asked before any file is created.

Then you can create the compendium:

    rcompendium::new_compendium()

You can now start working!

## Citation

Please cite this package as:

> Casajus N. (2021) rcompendium: An R package to create a research
> compendium. Version 0.1, <https://github.com/FRBCesab/rcompendium>.

## Code of Conduct

Please note that the `rcompendium` project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
