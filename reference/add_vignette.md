# Create a vignette document

This function adds a vignette in the folder `vignettes/`. It also adds
dependencies [`knitr`](https://yihui.org/knitr/) and
[`rmarkdown`](https://rmarkdown.rstudio.com/) in the field `Suggests` of
the `DESCRIPTION` file (if not already present in fields `Imports`).

## Usage

``` r
add_vignette(
  filename = NULL,
  title = NULL,
  open = TRUE,
  overwrite = FALSE,
  quiet = FALSE
)
```

## Arguments

- filename:

  A character of length 1. The name of the `.Rmd` file to be created. If
  `NULL` (default ) the `.Rmd` file will be named `pkg.Rmd` where `pkg`
  is your package name.

- title:

  A character of length 1. The title of the vignette. If `NULL`
  (default) the title will be `Get started`.

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

Other create files:
[`add_citation()`](https://frbcesab.github.io/rcompendium/reference/add_citation.md),
[`add_code_of_conduct()`](https://frbcesab.github.io/rcompendium/reference/add_code_of_conduct.md),
[`add_compendium()`](https://frbcesab.github.io/rcompendium/reference/add_compendium.md),
[`add_contributing()`](https://frbcesab.github.io/rcompendium/reference/add_contributing.md),
[`add_description()`](https://frbcesab.github.io/rcompendium/reference/add_description.md),
[`add_dockerfile()`](https://frbcesab.github.io/rcompendium/reference/add_dockerfile.md),
[`add_license()`](https://frbcesab.github.io/rcompendium/reference/add_license.md),
[`add_makefile()`](https://frbcesab.github.io/rcompendium/reference/add_makefile.md),
[`add_package_doc()`](https://frbcesab.github.io/rcompendium/reference/add_package_doc.md),
[`add_readme_rmd()`](https://frbcesab.github.io/rcompendium/reference/add_readme_rmd.md),
[`add_renv()`](https://frbcesab.github.io/rcompendium/reference/add_renv.md),
[`add_testthat()`](https://frbcesab.github.io/rcompendium/reference/add_testthat.md)

## Examples

``` r
if (FALSE) { # \dontrun{
## Default vignette ----
add_vignette()

## Default vignette ----
add_vignette(filename = "pkg", title = "Get started")
} # }
```
