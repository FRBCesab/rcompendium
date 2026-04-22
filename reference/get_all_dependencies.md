# Get all external dependencies

This function gets all the external packages that the project needs. It
is used the generate the *Dependencies* badge
([`add_dependencies_badge()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies_badge.md)).

## Usage

``` r
get_all_dependencies(pkg = NULL)
```

## Arguments

- pkg:

  A character of length 1. The name of a CRAN package or `NULL`
  (default). If `NULL` get dependencies of the local (uninstalled)
  project (package or compendium).

## Value

A list of three vectors:

- `base_deps`, a vector of base packages;

- `direct_deps`, a vector of direct packages;

- `all_deps`, a vector of all dependencies (recursively obtained).

## See also

Other utilities functions:
[`get_all_functions()`](https://frbcesab.github.io/rcompendium/reference/get_all_functions.md),
[`get_available_gh_actions()`](https://frbcesab.github.io/rcompendium/reference/get_available_gh_actions.md),
[`get_licenses()`](https://frbcesab.github.io/rcompendium/reference/get_licenses.md),
[`get_minimal_r_version()`](https://frbcesab.github.io/rcompendium/reference/get_minimal_r_version.md)

## Examples

``` r
if (FALSE) { # \dontrun{
## Update dependencies ----
add_dependencies()

## Get all dependencies ----
deps <- get_all_dependencies()
unlist(lapply(deps, length))

## Can be used for a CRAN package ----
deps <- get_all_dependencies("usethis")
unlist(lapply(deps, length))
} # }
```
