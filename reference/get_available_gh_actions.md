# List available GitHub Actions

This function returns a list of the name of all available GitHub
Actions. This is particularly useful to get the right spelling of the
GitHub Action to be passed to
[`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md).

## Usage

``` r
get_available_gh_actions()
```

## Value

A `character` vector with the name of the available GitHub Actions in
`rcompendium`.

## See also

Other utilities functions:
[`get_all_dependencies()`](https://frbcesab.github.io/rcompendium/reference/get_all_dependencies.md),
[`get_all_functions()`](https://frbcesab.github.io/rcompendium/reference/get_all_functions.md),
[`get_licenses()`](https://frbcesab.github.io/rcompendium/reference/get_licenses.md),
[`get_minimal_r_version()`](https://frbcesab.github.io/rcompendium/reference/get_minimal_r_version.md)

## Examples

``` r
get_available_gh_actions()
#> [1] "R-CMD-check"         "check-format"        "dependabot"         
#> [4] "pkgdown"             "render-README"       "test-coverage"      
#> [7] "update-Rd-files"     "update-citation-cff" "update-codemeta"    
```
