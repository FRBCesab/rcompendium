# Add code of conduct

This function creates a `CODE_OF_CONDUCT.md` file adapted from the
Contributor Covenant, version 2.1 available at
<https://www.contributor-covenant.org/version/2/1/code_of_conduct.html>.

## Usage

``` r
add_code_of_conduct(
  email = NULL,
  open = TRUE,
  overwrite = FALSE,
  quiet = FALSE
)
```

## Arguments

- email:

  A character of length 1. The email address of the project maintainer.

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
[`add_compendium()`](https://frbcesab.github.io/rcompendium/reference/add_compendium.md),
[`add_contributing()`](https://frbcesab.github.io/rcompendium/reference/add_contributing.md),
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
add_code_of_conduct()
} # }
```
