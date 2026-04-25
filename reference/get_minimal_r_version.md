# Get required minimal R version

This function detects the minimal required R version for the project
based on minimal required R version of its dependencies. It can be used
to update the `Depends` field of the `DESCRIPTION` file.

## Usage

``` r
get_minimal_r_version(pkg = NULL)
```

## Arguments

- pkg:

  A character of length 1. The name of a CRAN package or `NULL`
  (default). If `NULL` get minimal required R version of the local
  (uninstalled) project (package or compendium).

## Value

A character with the minimal required R version.

## See also

Other utilities functions:
[`get_all_dependencies()`](https://frbcesab.github.io/rcompendium/reference/get_all_dependencies.md),
[`get_all_functions()`](https://frbcesab.github.io/rcompendium/reference/get_all_functions.md),
[`get_available_gh_actions()`](https://frbcesab.github.io/rcompendium/reference/get_available_gh_actions.md),
[`get_available_issue_templates()`](https://frbcesab.github.io/rcompendium/reference/get_available_issue_templates.md),
[`get_licenses()`](https://frbcesab.github.io/rcompendium/reference/get_licenses.md)

## Examples

``` r
if (FALSE) { # \dontrun{
## Update dependencies ----
add_dependencies()

## Minimal R version of a project ----
get_minimal_r_version()

## Minimal R version of a CRAN package ----
get_minimal_r_version("usethis")
} # }
```
