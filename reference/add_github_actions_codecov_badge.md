# Add a Test coverage badge

This function adds a **Test coverage** badge to the `README.Rmd`. This
function must be run after
[`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md)
which will setup GitHub Actions to report the percentage of code cover
by units tests.

Make sure that 1) a `README.Rmd` file exists at the project root and 2)
it contains a block starting with the line `<!-- badges: start -->` and
ending with the line `<!-- badges: end -->`.

Don't forget to re-render the `README.md`.

## Usage

``` r
add_github_actions_codecov_badge(organisation = NULL, quiet = FALSE)
```

## Arguments

- organisation:

  A character of length 1. The name of the GitHub organisation to host
  the package. If `NULL` (default) the GitHub account will be used.

- quiet:

  A logical value. If `TRUE` messages are deleted. Default is `FALSE`.

## Value

A badge as a markdown expression.

## See also

Other adding badges:
[`add_codecov_badge()`](https://frbcesab.github.io/rcompendium/reference/add_codecov_badge.md),
[`add_cran_badge()`](https://frbcesab.github.io/rcompendium/reference/add_cran_badge.md),
[`add_dependencies_badge()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies_badge.md),
[`add_github_actions_check_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_check_badge.md),
[`add_github_actions_pkgdown_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_pkgdown_badge.md),
[`add_license_badge()`](https://frbcesab.github.io/rcompendium/reference/add_license_badge.md),
[`add_lifecycle_badge()`](https://frbcesab.github.io/rcompendium/reference/add_lifecycle_badge.md),
[`add_repostatus_badge()`](https://frbcesab.github.io/rcompendium/reference/add_repostatus_badge.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_github_actions_codecov_badge()
} # }
```
