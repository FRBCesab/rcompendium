# Add to the .gitignore file

This function creates a `.gitignore` file at the root of the project
based on a template (specific to R). If a `.gitignore` is already
present, files to be untracked by **git** are just added to this file.

## Usage

``` r
add_to_gitignore(x, open = FALSE, quiet = FALSE)
```

## Arguments

- x:

  A character vector. One or several files/folders names to be added to
  the `.gitignore`.

- open:

  A logical value. If `TRUE` the `.gitignore` file is opened in the
  editor. Default is `FALSE`.

- quiet:

  A logical value. If `TRUE` messages are deleted. Default is `FALSE`.

## Value

No return value.

## See also

Other development functions:
[`add_dependabot()`](https://frbcesab.github.io/rcompendium/reference/add_dependabot.md),
[`add_dependencies()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies.md),
[`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md),
[`add_issue_template()`](https://frbcesab.github.io/rcompendium/reference/add_issue_template.md),
[`add_r_depend()`](https://frbcesab.github.io/rcompendium/reference/add_r_depend.md),
[`add_to_buildignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_buildignore.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_to_gitignore(open = TRUE)
add_to_gitignore(".DS_Store")
} # }
```
