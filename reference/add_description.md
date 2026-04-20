# Create a DESCRIPTION file

This function creates a `DESCRIPTION` file at the root of the project.
This file contains metadata of the project. Some information (title,
description, version, etc.) must be edited by hand. For more
information: <https://r-pkgs.org/description.html>. User credentials can
be passed as arguments but it is recommended to store them in the
`.Rprofile` file with
[`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md).

## Usage

``` r
add_description(
  given = NULL,
  family = NULL,
  email = NULL,
  orcid = NULL,
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

- email:

  A character of length 1. The email address of the project maintainer.

- orcid:

  A character of length 1. The ORCID of the project maintainer.

- organisation:

  A character of length 1. The name of the GitHub organisation to host
  the package. If `NULL` (default) the GitHub account will be used.

- open:

  A logical value. If `TRUE` (default) the file is opened in the editor.

- overwrite:

  A logical value. If a `DESCRIPTION` is already present and
  `overwrite = TRUE`, this file will be erased and replaced. Default is
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
add_description(organisation = "MySociety")
} # }
```
