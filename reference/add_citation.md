# Create a CITATION file

This function creates a `CITATION` file in the folder `inst/`. This file
contains a BiBTeX entry to cite the package as a manual. User will need
to edit by hand some information (title, version, etc.).

## Usage

``` r
add_citation(
  given = NULL,
  family = NULL,
  organisation = NULL,
  open = TRUE,
  overwrite = FALSE,
  quiet = FALSE
)
```

## Arguments

- given:

  A character of length 1. The given name of the project maintainer.

- family:

  A character of length 1. The family name of the project maintainer.

- organisation:

  A character of length 1. The name of the GitHub organisation to host
  the package. If `NULL` (default) the GitHub account will be used. This
  argument is used to set the URL of the package (hosted on GitHub).

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
[`add_testthat()`](https://frbcesab.github.io/rcompendium/reference/add_testthat.md),
[`add_vignette()`](https://frbcesab.github.io/rcompendium/reference/add_vignette.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add_citation()
readCitationFile("inst/CITATION")
citation("pkg")    # If you have installed your package <pkg>
} # }
```
