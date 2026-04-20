# Add a Repository Status badge

This function adds or updates the **Repository Status** badge of the
project to the `README.Rmd`. It is based on the standard defined by the
<https://www.repostatus.org> project.

Make sure that 1) a `README.Rmd` file exists at the project root and 2)
it contains a block starting with the line `<!-- badges: start -->` and
ending with the line `<!-- badges: end -->`.

Don't forget to re-render the `README.md`.

## Usage

``` r
add_repostatus_badge(status = "concept", quiet = FALSE)
```

## Arguments

- status:

  A character of length 1. Accepted status are: `'concept'` (default),
  `'wip'`, `'suspended'`, `'abandoned'`, `'active'`, `'inactive'`, or
  `'unsupported'`.

- quiet:

  A logical value. If `TRUE` messages are deleted. Default is `FALSE`.

## Value

A badge as a markdown expression.

## Details

The project can have the following status:

- **Concept** - Minimal or no implementation has been done yet, or the
  repository is only intended to be a limited example, demo, or
  proof-of-concept.

- **WIP** - Initial development is in progress, but there has not yet
  been a stable, usable release suitable for the public.

- **Suspended** - Initial development has started, but there has not yet
  been a stable, usable release; work has been stopped for the time
  being but the author(s) intend on resuming work.

- **Abandoned** - Initial development has started, but there has not yet
  been a stable, usable release; the project has been abandoned and the
  author(s) do not intend on continuing development.

- **Active** - The project has reached a stable, usable state and is
  being actively developed.

- **Inactive** - The project has reached a stable, usable state but is
  no longer being actively developed; support/maintenance will be
  provided as time allows.

- **Unsupported** - The project has reached a stable, usable state but
  the author(s) have ceased all work on it. A new maintainer may be
  desired.

## See also

Other adding badges:
[`add_codecov_badge()`](https://frbcesab.github.io/rcompendium/reference/add_codecov_badge.md),
[`add_cran_badge()`](https://frbcesab.github.io/rcompendium/reference/add_cran_badge.md),
[`add_dependencies_badge()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies_badge.md),
[`add_github_actions_check_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_check_badge.md),
[`add_github_actions_codecov_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_codecov_badge.md),
[`add_github_actions_pkgdown_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_pkgdown_badge.md),
[`add_license_badge()`](https://frbcesab.github.io/rcompendium/reference/add_license_badge.md),
[`add_lifecycle_badge()`](https://frbcesab.github.io/rcompendium/reference/add_lifecycle_badge.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_repostatus_badge()
add_repostatus_badge(status = "active")
} # }
```
