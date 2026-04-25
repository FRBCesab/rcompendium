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
[`add_dependabot()`](https://frbcesab.github.io/rcompendium/reference/add_dependabot.md),
[`add_dependencies()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies.md),
[`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md),
[`add_issue_template()`](https://frbcesab.github.io/rcompendium/reference/add_issue_template.md),
[`add_to_buildignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_buildignore.md),
[`add_to_gitignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_gitignore.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_r_depend()
} # }
```
