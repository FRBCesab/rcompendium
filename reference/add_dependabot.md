# Add a DEPENDABOT file

This function creates a `dependabot.yaml` file (configuration file) in
the `.github/` directory. This GitHub Action will be triggered once a
week to check for dependency updates (used by any GitHub Action of the
repository). If an update is available, this bot will open a Pull
Request and user will be invited to review changes.

This function is called by
[`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md)
to automatically create this configuration file if any GitHub Action is
used.

## Usage

``` r
add_dependabot(overwrite = FALSE, quiet = FALSE)
```

## Arguments

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
[`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md),
[`add_r_depend()`](https://frbcesab.github.io/rcompendium/reference/add_r_depend.md),
[`add_to_buildignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_buildignore.md),
[`add_to_gitignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_gitignore.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_dependabot()
} # }
```
