# List all functions in the package

This function returns a list of all the functions (exported and
internal) available with the package. As this function scans the
`NAMESPACE` and the `R/` folder, it is recommended to run
[`devtools::document()`](https://devtools.r-lib.org/reference/document.html)
before.

## Usage

``` r
get_all_functions()
```

## Value

A list of two vectors:

- `external`, a vector of exported functions name;

- `internal`, a vector of internal functions name.

## See also

Other utilities functions:
[`get_all_dependencies()`](https://frbcesab.github.io/rcompendium/reference/get_all_dependencies.md),
[`get_available_gh_actions()`](https://frbcesab.github.io/rcompendium/reference/get_available_gh_actions.md),
[`get_licenses()`](https://frbcesab.github.io/rcompendium/reference/get_licenses.md),
[`get_minimal_r_version()`](https://frbcesab.github.io/rcompendium/reference/get_minimal_r_version.md)

## Examples

``` r
if (FALSE) { # \dontrun{
## Update NAMESPACE ----
devtools::document()

## List all implemented functions ----
get_all_functions()
} # }
```
