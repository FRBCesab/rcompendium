# Setup GitHub Actions to build and deploy package website

This function creates a configuration file (`.yaml`) to setup GitHub
Actions to automatically build and deploy the website using
[`pkgdown`](https://pkgdown.r-lib.org/index.html). This workflow is
derived from <https://github.com/r-lib/actions/tree/v2-branch/examples>.
This file will be written as `.github/workflows/pkgdown.yaml`. An
additional empty file (`_pkgdown.yaml`) will also be written: it can be
used to customize the website.

## Usage

``` r
add_github_actions_pkgdown(open = FALSE, overwrite = FALSE, quiet = FALSE)
```

## Arguments

- open:

  A logical value. If `TRUE` (default) the file is opened in the editor.

- overwrite:

  A logical value. If this file is already present and
  `overwrite = TRUE`, it will be erased and replaced. Default is
  `FALSE`.

- quiet:

  A logical value. If `TRUE` messages are deleted. Default is `FALSE`.

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
[`add_github_actions_render()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_render.md),
[`add_r_depend()`](https://frbcesab.github.io/rcompendium/reference/add_r_depend.md),
[`add_to_buildignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_buildignore.md),
[`add_to_gitignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_gitignore.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_github_actions_pkgdown()
} # }
```
