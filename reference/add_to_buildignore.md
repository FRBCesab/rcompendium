# Add to the .Rbuildignore file

This function adds files/folders to the `.Rbuildignore` file. If a
`.Rbuildignore` is already present, files to be ignored while checking
package are just added to this file. Otherwise a new file is created.

## Usage

``` r
add_to_buildignore(x, open = FALSE, quiet = FALSE)
```

## Arguments

- x:

  A character vector. One or several files/folders names to be added to
  the `.Rbuildignore`. This argument is mandatory.

- open:

  A logical value. If `TRUE` the `.Rbuildignore` file is opened in the
  editor. Default is `FALSE`.

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
[`add_github_actions_render()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_render.md),
[`add_r_depend()`](https://frbcesab.github.io/rcompendium/reference/add_r_depend.md),
[`add_to_gitignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_gitignore.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_to_buildignore(open = TRUE)
add_to_buildignore(".DS_Store")
} # }
```
