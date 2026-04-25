# Set up a GitHub Action workflow

This function sets up a continuous integration (CI) for an R project
hosted on GitHub. It creates a configuration file (`.yaml`) to setup a
specific GitHub Action (see below).

Available workflows are derived from
<https://github.com/r-lib/actions/tree/v2-branch/examples> and are
hosted on a different repository
<https://github.com/FRBCesab/r-templates/tree/main/actions>.

Configuration files will be written in `.github/workflows/`.

## Usage

``` r
add_github_action(name, open = FALSE, overwrite = FALSE, quiet = FALSE)
```

## Arguments

- name:

  A character of length 1. The name of the GitHub Action to set up. Run
  [`get_available_gh_actions()`](https://frbcesab.github.io/rcompendium/reference/get_available_gh_actions.md)
  to list available GitHub Actions.

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

## Details

Here is a list of commonly used GitHub Actions that will be triggered
after each push or pull request:

- `R-CMD-check`: check the package integrity on three major operating
  systems (Ubuntu, macOS, and Windows) using the latest release of R.
  The package is also checked on Ubuntu (latest version) using the
  development and previous versions of R.

- `test-coverage`: compute and report the code coverage (i.e. the
  proportion of R code covered by unit tests) to
  <https://about.codecov.io/>.

- `pkgdown`: build and publish the `pkgdown` website of the package on a
  dedicated **gh-pages** branch. The repository may need further
  configuration (see
  [`usethis::use_pkgdown_github_pages()`](https://usethis.r-lib.org/reference/use_pkgdown.html)).

- `check-format`: set up the Air formatter for R and check the code
  format. This action will fail if any files need to be reformatted with
  Air.

- `render-README`: render the `README.Rmd` only if it has been modified.
  This action will commit and push the updated `README.md` to the main
  branch. User need to fetch the new version.

- `update-Rd-files`: update the package documentation files (`Rd` files
  and `NAMESPACE`). This action will commit and push the updated files
  to the main branch. User need to fetch the new version.

- `update-citation-cff`: update the `CITATION.cff`, a human- and
  machine-readable citation information file. This action is triggered
  if the `DESCRIPTION` file and/or the `inst/CITATION` file is modified.
  This action will commit and push the updated `CITATION.cff` to the
  main branch. User need to fetch the new version.

- `update-codemeta`: update the `codemeta.json`, a standardized metadata
  file for software (not only R packages). This action is triggered if
  the `DESCRIPTION` file and/or the `inst/CITATION` file and/or the
  `README.md` is modified. This action will commit and push the updated
  `codemeta.json` to the main branch. User need to fetch the new
  version.

If one of these GitHub Actions is added to the project, this function
will also create a `dependabot.yaml` file in `.github/`. This action
will be triggered once a week to check for dependency updates (used by
any GitHub Action of the repository). If an update is available, this
bot will open a Pull Request and user will be invited to review changes.

## See also

Other development functions:
[`add_dependabot()`](https://frbcesab.github.io/rcompendium/reference/add_dependabot.md),
[`add_dependencies()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies.md),
[`add_r_depend()`](https://frbcesab.github.io/rcompendium/reference/add_r_depend.md),
[`add_to_buildignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_buildignore.md),
[`add_to_gitignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_gitignore.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_github_action(name = "R-CMD-check")
} # }
```
