# Initialize renv

This function initializes an `renv` environment for the project by
running
[`renv::init()`](https://rstudio.github.io/renv/reference/init.html).
See <https://rstudio.github.io/renv/> for further detail.

## Usage

``` r
add_renv(quiet = FALSE)
```

## Arguments

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
[`add_license()`](https://frbcesab.github.io/rcompendium/reference/add_license.md),
[`add_makefile()`](https://frbcesab.github.io/rcompendium/reference/add_makefile.md),
[`add_package_doc()`](https://frbcesab.github.io/rcompendium/reference/add_package_doc.md),
[`add_readme_rmd()`](https://frbcesab.github.io/rcompendium/reference/add_readme_rmd.md),
[`add_testthat()`](https://frbcesab.github.io/rcompendium/reference/add_testthat.md),
[`add_vignette()`](https://frbcesab.github.io/rcompendium/reference/add_vignette.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_renv()
} # }
```
