# Add a License badge

This function adds or updates the **License** badge to the `README.Rmd`.
This function reads the `License` field of the `DESCRIPTION` file.
Ensure that this field is correctly defined. See
[`add_license()`](https://frbcesab.github.io/rcompendium/reference/add_license.md)
for further detail.

This function requires the presence of a `DESCRIPTION` file at the
project root. See
[`add_description()`](https://frbcesab.github.io/rcompendium/reference/add_description.md)
for further detail.

Make sure that 1) a `README.Rmd` file exists at the project root and 2)
it contains a block starting with the line `<!-- badges: start -->` and
ending with the line `<!-- badges: end -->`.

Don't forget to re-render the `README.md`.

## Usage

``` r
add_license_badge(quiet = FALSE)
```

## Arguments

- quiet:

  A logical value. If `TRUE` messages are deleted. Default is `FALSE`.

## Value

A badge as a markdown expression.

## See also

Other adding badges:
[`add_codecov_badge()`](https://frbcesab.github.io/rcompendium/reference/add_codecov_badge.md),
[`add_cran_downloads_badge()`](https://frbcesab.github.io/rcompendium/reference/add_cran_downloads_badge.md),
[`add_cran_total_download_badge()`](https://frbcesab.github.io/rcompendium/reference/add_cran_total_download_badge.md),
[`add_cran_version_badge()`](https://frbcesab.github.io/rcompendium/reference/add_cran_version_badge.md),
[`add_dependencies_badge()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies_badge.md),
[`add_github_actions_check_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_check_badge.md),
[`add_github_actions_codecov_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_codecov_badge.md),
[`add_github_actions_pkgdown_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_pkgdown_badge.md),
[`add_lifecycle_badge()`](https://frbcesab.github.io/rcompendium/reference/add_lifecycle_badge.md),
[`add_repostatus_badge()`](https://frbcesab.github.io/rcompendium/reference/add_repostatus_badge.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_license_badge()
} # }
```
