# Add a LICENSE

This function adds a license to the project. It will add the license
name in the `License` field of the `DESCRIPTION` file and write the
content of the license in the `License.md` file.

## Usage

``` r
add_license(license = NULL, given = NULL, family = NULL, quiet = FALSE)
```

## Arguments

- license:

  A character of length 1. The chosen license. Run
  [`get_licenses()`](https://frbcesab.github.io/rcompendium/reference/get_licenses.md))
  to select an appropriate one.

- given:

  A character of length 1. The given name of the copyright holder. Only
  required if `license = 'MIT'`. If is `NULL` (default) and
  `license = 'MIT'`, this function will try to retrieve the value of
  this parameter from the `.Rprofile` file (edited with
  [`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)).

- family:

  A character of length 1. The family name of the copyright holder. Only
  required if `license = 'MIT'`. If is `NULL` (default) and
  `license = 'MIT'`, this function will try to retrieve the value of
  this parameter from the `.Rprofile` file (edited with
  [`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)).

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
[`add_contributing()`](https://frbcesab.github.io/rcompendium/reference/add_contributing.md),
[`add_description()`](https://frbcesab.github.io/rcompendium/reference/add_description.md),
[`add_dockerfile()`](https://frbcesab.github.io/rcompendium/reference/add_dockerfile.md),
[`add_makefile()`](https://frbcesab.github.io/rcompendium/reference/add_makefile.md),
[`add_package_doc()`](https://frbcesab.github.io/rcompendium/reference/add_package_doc.md),
[`add_readme_rmd()`](https://frbcesab.github.io/rcompendium/reference/add_readme_rmd.md),
[`add_renv()`](https://frbcesab.github.io/rcompendium/reference/add_renv.md),
[`add_testthat()`](https://frbcesab.github.io/rcompendium/reference/add_testthat.md),
[`add_vignette()`](https://frbcesab.github.io/rcompendium/reference/add_vignette.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_license(license = "MIT")
add_license(license = "GPL (>= 2)")
} # }
```
