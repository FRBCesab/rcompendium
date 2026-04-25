# List available ISSUE TEMPLATE

This function returns a list of the name of all available Issue
Templates. This is particularly useful to get the right spelling of the
Issue Templates to be passed to
[`add_issue_template()`](https://frbcesab.github.io/rcompendium/reference/add_issue_template.md).

## Usage

``` r
get_available_issue_templates()
```

## Value

A `character` vector with the name of the available Issue Templates in
`rcompendium`.

## See also

Other utilities functions:
[`get_all_dependencies()`](https://frbcesab.github.io/rcompendium/reference/get_all_dependencies.md),
[`get_all_functions()`](https://frbcesab.github.io/rcompendium/reference/get_all_functions.md),
[`get_available_gh_actions()`](https://frbcesab.github.io/rcompendium/reference/get_available_gh_actions.md),
[`get_licenses()`](https://frbcesab.github.io/rcompendium/reference/get_licenses.md),
[`get_minimal_r_version()`](https://frbcesab.github.io/rcompendium/reference/get_minimal_r_version.md)

## Examples

``` r
get_available_issue_templates()
#> [1] "bug_report"      "feature_request"
```
