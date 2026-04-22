# Add dependencies in DESCRIPTION

This function detects external dependencies used in `R/`, `NAMESPACE`,
and `@examples` sections of `roxygen2` headers and automatically adds
these dependencies in the `Imports` section of the `DESCRIPTION` file.

In the `NAMESPACE` this function detects dependencies mentioned as
`import(pkg)` and `importFrom(pkg,fun)`.

In the `R/` folder it detects functions called as `pkg::fun()` in the
code of each R files. In `@examples` sections it also detects packages
attached by [`library()`](https://rdrr.io/r/base/library.html) or
[`require()`](https://rdrr.io/r/base/library.html).

The `vignettes/` folder is also inspected and detected dependencies
(`pkg::fun()`, [`library()`](https://rdrr.io/r/base/library.html) or
[`require()`](https://rdrr.io/r/base/library.html)) are added to the
`Suggests` field of the `DESCRIPTION` file (in addition to the packages
[`knitr`](https://yihui.org/knitr/) and
[`rmarkdown`](https://rmarkdown.rstudio.com/)).

If the project is a research compendium user can also inspect additional
folder(s) with the argument `compendium` to add dependencies to the
`Imports` section of the `DESCRIPTION` file. The detection process is
the same as the one used for `vignettes/`.

The `tests/` folder is also inspected and detected dependencies
(`pkg::fun()`, [`library()`](https://rdrr.io/r/base/library.html) or
[`require()`](https://rdrr.io/r/base/library.html)) are added to the
`Suggests` field of the `DESCRIPTION` file (in addition to the package
[`testthat`](https://testthat.r-lib.org)).

## Usage

``` r
add_dependencies(compendium = NULL)
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

## Value

No return value.

## See also

Other development functions:
[`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md),
[`add_r_depend()`](https://frbcesab.github.io/rcompendium/reference/add_r_depend.md),
[`add_to_buildignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_buildignore.md),
[`add_to_gitignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_gitignore.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_dependencies()
} # }
```
