# Add minimal R version to DESCRIPTION

This function adds the minimal R version to the `Depends` field of the
`DESCRIPTION` file. This version corresponds to the higher version of R
among all dependencies. If no dependencies mentions minimal R version,
the `DESCRIPTION` is not modified.

## Usage

``` r
add_r_depend()
```

## Value

No return value.

## See also

Other development functions:
[`add_dependencies()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies.md),
[`add_github_actions_check()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_check.md),
[`add_github_actions_citation()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_citation.md),
[`add_github_actions_codecov()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_codecov.md),
[`add_github_actions_codemeta()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_codemeta.md),
[`add_github_actions_document()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_document.md),
[`add_github_actions_pkgdown()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_pkgdown.md),
[`add_github_actions_render()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_render.md),
[`add_to_buildignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_buildignore.md),
[`add_to_gitignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_gitignore.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_r_depend()
} # }
```
