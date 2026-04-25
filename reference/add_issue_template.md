# Set up an Issue Template file

This function creates an Issue template file (`md`) in the directory
`.github/ISSUE_TEMPLATE`. These files preformat a GitHub Issue.
Contributors can use these templates when they open new issues. For
instance, you can format issue related to bug report, feature request,
etc.

## Usage

``` r
add_issue_template(name, open = FALSE, overwrite = FALSE, quiet = FALSE)
```

## Arguments

- name:

  A character of length 1. The name of the Issue Template to add. Run
  [`get_available_issue_templates()`](https://frbcesab.github.io/rcompendium/reference/get_available_issue_templates.md)
  to list available Issue Templates.

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
[`add_dependabot()`](https://frbcesab.github.io/rcompendium/reference/add_dependabot.md),
[`add_dependencies()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies.md),
[`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md),
[`add_r_depend()`](https://frbcesab.github.io/rcompendium/reference/add_r_depend.md),
[`add_to_buildignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_buildignore.md),
[`add_to_gitignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_gitignore.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_issue_template(name = "feature_request")
} # }
```
