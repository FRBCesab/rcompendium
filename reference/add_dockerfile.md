# Create a Dockerfile

This function creates a `Dockerfile` at the root of the project based on
a template. The Docker image is based on
[rocker/rstudio](https://hub.docker.com/r/rocker/rstudio). The whole
project will be copied in the image and R packages will be installed
(using
[`renv::restore()`](https://rstudio.github.io/renv/reference/restore.html)
or `remotes::install_deps()`).

In addition a `.dockerignore` file is added to ignore some files/folders
while building the image.

User can customize this `Dockerfile` (e.g. system dependencies). He/she
can also use a different default Docker image (i.e. `tidyverse`,
`verse`, `geospatial`, etc.). For more information:
https://github.com/rocker-org/rocker-versioned2

By default the versions of R and `renv` (if applicable) specified in the
`Dockerfile` are the same as the local system.

Once the project is ready to be released, user must build the Docker
image by running: `docker build -t "image_name" .`

Then to run a container, user must run:
`docker run --rm -p 127.0.0.1:8787:8787 -e DISABLE_AUTH=true image_name`

A new instance of RStudio Server is available on the Web browser at the
URL: `127.0.0.1:8787`.

## Usage

``` r
add_dockerfile(
  given = NULL,
  family = NULL,
  email = NULL,
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

- open:

  A logical value. If `TRUE` (default) the `Dockerfile` is opened in the
  editor.

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
[`add_codeowners()`](https://frbcesab.github.io/rcompendium/reference/add_codeowners.md),
[`add_compendium()`](https://frbcesab.github.io/rcompendium/reference/add_compendium.md),
[`add_contributing()`](https://frbcesab.github.io/rcompendium/reference/add_contributing.md),
[`add_description()`](https://frbcesab.github.io/rcompendium/reference/add_description.md),
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
add_dockerfile()
} # }
```
