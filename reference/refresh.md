# Refresh a package/research compendium

**This function is about to be removed from `rcompendium`.**

This function refreshes a package/research compendium. It will:

- Update `.Rd` files and `NAMESPACE` by using
  [`devtools::document()`](https://devtools.r-lib.org/reference/document.html);

- Update external packages (in `DESCRIPTION` file) by using
  [`add_dependencies()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies.md);

- Update badges in `README.Rmd` (if already present);

- Re-knitr the `README.Rmd` by using
  [`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html);

- Check package integrity by using
  [`devtools::check()`](https://devtools.r-lib.org/reference/check.html);

- Run analysis by sourcing `make.R` (only for compendium).

## Usage

``` r
refresh(compendium = NULL, make = FALSE, check = FALSE, quiet = FALSE)
```

## Arguments

- compendium:

  A character of length 1. The name of the folder to recursively detect
  dependencies to be added to the `Imports` field of `DESCRIPTION` file.
  It can be `'analysis/'` (if additional folders, i.e. `data/`,
  `outputs/`, `figures/`, etc. have been created in this folder), `'.'`
  (if folders `data/`, `outputs/`, `figures/`, etc. have been created at
  the root of the project), etc. See
  [`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md)
  for further information.

  Default is `compendium = NULL` (i.e. no additional folder are
  inspected but `R/`, `NAMESPACE`, `vignettes/`, and `tests/` are still
  inspected).

- make:

  A logical value. If `TRUE` the Make-like R file `make.R` is sourced.
  Only for research compendium created with
  [`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md).
  Default is `FALSE`.

- check:

  A logical value. If `TRUE` package integrity is checked using
  [`devtools::check()`](https://devtools.r-lib.org/reference/check.html).
  Default is `FALSE`.

- quiet:

  A logical value. If `TRUE` (default) message are deleted.

## Value

No return value.

## See also

Other setup functions:
[`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md),
[`new_package()`](https://frbcesab.github.io/rcompendium/reference/new_package.md),
[`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)

## Examples

``` r
if (FALSE) { # \dontrun{
library(rcompendium)

## Create an R package ----
new_package()

## Start developing functions ----
## ...

## Update package (documentation, dependencies, README) ----
refresh()
} # }
```
