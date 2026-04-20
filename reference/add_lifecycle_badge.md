# Add a Life Cycle badge

This function adds or updates the **Life Cycle** badge to the
`README.Rmd`. It is based on the standard defined at
<https://lifecycle.r-lib.org/articles/stages.html>.

Make sure that 1) a `README.Rmd` file exists at the project root and 2)
it contains a block starting with the line `<!-- badges: start -->` and
ending with the line `<!-- badges: end -->`.

Don't forget to re-render the `README.md`.

## Usage

``` r
add_lifecycle_badge(lifecycle = "experimental", quiet = FALSE)
```

## Arguments

- lifecycle:

  A character of length 1. Accepted stages are: `'experimental'`
  (default), `'stable'`, `'deprecated'`, or `'superseded'`.

- quiet:

  A logical value. If `TRUE` messages are deleted. Default is `FALSE`.

## Value

A badge as a markdown expression.

## Details

The project can have the following life cycle stage:

- **Experimental** - An experimental project is made available so user
  can try it out and provide feedback, but come with no promises for
  long term stability.

- **Stable** - A project is considered stable when the author is happy
  with its interface, does not see major issues, and is happy to share
  it with the world.

- **Superseded** - A superseded project has a known better alternative,
  and it is not going away. Superseded project will not receive new
  features, but will receive any critical bug fixes needed to keep it
  working.

- **Deprecated** - A deprecated project has a better alternative
  available and is scheduled for removal.

## See also

Other adding badges:
[`add_codecov_badge()`](https://frbcesab.github.io/rcompendium/reference/add_codecov_badge.md),
[`add_cran_badge()`](https://frbcesab.github.io/rcompendium/reference/add_cran_badge.md),
[`add_dependencies_badge()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies_badge.md),
[`add_github_actions_check_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_check_badge.md),
[`add_github_actions_codecov_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_codecov_badge.md),
[`add_github_actions_pkgdown_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_pkgdown_badge.md),
[`add_license_badge()`](https://frbcesab.github.io/rcompendium/reference/add_license_badge.md),
[`add_repostatus_badge()`](https://frbcesab.github.io/rcompendium/reference/add_repostatus_badge.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_lifecycle_badge()
add_lifecycle_badge(lifecycle = "stable")
} # }
```
