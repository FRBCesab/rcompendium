# Setup GitHub Actions to render README

This function creates a configuration file (`.yaml`) to setup GitHub
Actions to automatically knit the `README.Rmd` after a push. This
workflow will be triggered only if the `README.Rmd` has been modified
since the last commit. This workflow is derived from
<https://github.com/r-lib/actions/tree/v2-branch/examples>. This file
will be written as `.github/workflows/render-README.yaml`.

## Usage

``` r
add_github_actions_render(open = FALSE, overwrite = FALSE, quiet = FALSE)
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
[`add_github_actions_pkgdown()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_pkgdown.md),
[`add_r_depend()`](https://frbcesab.github.io/rcompendium/reference/add_r_depend.md),
[`add_to_buildignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_buildignore.md),
[`add_to_gitignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_gitignore.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_github_actions_render()
} # }
```
