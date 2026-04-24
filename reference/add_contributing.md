# Add contribution guidelines

This function creates several files to help the user to learn how to
contribute to the project:

- `CONTRIBUTING.md`: general guidelines outlining the best way to
  contribute to the project (can be modified);

- `.github/ISSUE_TEMPLATE/bug_report.md`: an issue template to report a
  bug (can be modified);

- `.github/ISSUE_TEMPLATE/feature_request.md`: an issue template to
  suggest a new feature (can be modified);

- `.github/ISSUE_TEMPLATE/other_issue.md`: an issue template for all
  other types of issue (can be modified).

## Usage

``` r
add_contributing(
  email = NULL,
  organisation = NULL,
  open = TRUE,
  overwrite = FALSE,
  quiet = FALSE
)
```

## Arguments

- email:

  A character of length 1. The email address of the project maintainer.

- organisation:

  A character of length 1. The name of the GitHub organisation to host
  the package. If `NULL` (default) the GitHub account will be used. This
  argument is used to set the URL of the package (hosted on GitHub).

- open:

  A logical value. If `TRUE` (default) the `CONTRIBUTING.md` file is
  opened in the editor.

- overwrite:

  A logical value. If files are already present and `overwrite = TRUE`,
  they will be erased and replaced. Default is `FALSE`.

- quiet:

  A logical value. If `TRUE` messages are deleted. Default is `FALSE`.

## Value

No return value.

## See also

Other create files:
[`add_citation()`](https://frbcesab.github.io/rcompendium/reference/add_citation.md),
[`add_code_of_conduct()`](https://frbcesab.github.io/rcompendium/reference/add_code_of_conduct.md),
[`add_codeowners()`](https://frbcesab.github.io/rcompendium/reference/add_codeowners.md),
[`add_compendium()`](https://frbcesab.github.io/rcompendium/reference/add_compendium.md),
[`add_description()`](https://frbcesab.github.io/rcompendium/reference/add_description.md),
[`add_dockerfile()`](https://frbcesab.github.io/rcompendium/reference/add_dockerfile.md),
[`add_license()`](https://frbcesab.github.io/rcompendium/reference/add_license.md),
[`add_makefile()`](https://frbcesab.github.io/rcompendium/reference/add_makefile.md),
[`add_package_doc()`](https://frbcesab.github.io/rcompendium/reference/add_package_doc.md),
[`add_readme_rmd()`](https://frbcesab.github.io/rcompendium/reference/add_readme_rmd.md),
[`add_renv()`](https://frbcesab.github.io/rcompendium/reference/add_renv.md),
[`add_testthat()`](https://frbcesab.github.io/rcompendium/reference/add_testthat.md),
[`add_vignette()`](https://frbcesab.github.io/rcompendium/reference/add_vignette.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_contributing()
} # }
```
