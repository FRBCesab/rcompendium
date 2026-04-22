# Package index

## Prerequisites

High level overview of the package

- [`rcompendium-package`](https://frbcesab.github.io/rcompendium/reference/rcompendium-package.md)
  [`rcompendium`](https://frbcesab.github.io/rcompendium/reference/rcompendium-package.md)
  : Create a package or research compendium structure

## Setup functions

These four functions are usually the only ones user needs to run. The
use of `set_credentials` is strongly recommended to permanently store
user information (name, email, orcid, etc.) in the `.Rprofile`. This
function must be run one time. The function `new_package` must be used
to create an R package structure whereas `new_compendium` creates a new
research compendium structure (i.e. R package structure with some
additional files/folders). After that user can start to develop his/her
project and run `refresh` to frequently update the package/compendium
components (`Rd` files, `NAMESPACE`, dependencies, badges, `README.md`,
etc.)

- [`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)
  : Store credentials to the .Rprofile
- [`new_package()`](https://frbcesab.github.io/rcompendium/reference/new_package.md)
  : Create an R package structure
- [`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md)
  : Create an R compendium structure
- [`refresh()`](https://frbcesab.github.io/rcompendium/reference/refresh.md)
  : Refresh a package/research compendium

## Create files

These function write files specific to R package and research compendium
(`add_makefile`). They are called by the main functions `new_package`,
`new_compendium`, and `refresh` but they also can be used to overwrite
files (with `overwrite = TRUE`) in case of broken code. When
`open = TRUE` and `overwrite = FALSE` (default) files are open in the
editor.

- [`add_description()`](https://frbcesab.github.io/rcompendium/reference/add_description.md)
  : Create a DESCRIPTION file
- [`add_license()`](https://frbcesab.github.io/rcompendium/reference/add_license.md)
  : Add a LICENSE
- [`add_package_doc()`](https://frbcesab.github.io/rcompendium/reference/add_package_doc.md)
  : Create a package-level documentation file
- [`add_citation()`](https://frbcesab.github.io/rcompendium/reference/add_citation.md)
  : Create a CITATION file
- [`add_code_of_conduct()`](https://frbcesab.github.io/rcompendium/reference/add_code_of_conduct.md)
  : Add code of conduct
- [`add_contributing()`](https://frbcesab.github.io/rcompendium/reference/add_contributing.md)
  : Add contribution guidelines
- [`add_testthat()`](https://frbcesab.github.io/rcompendium/reference/add_testthat.md)
  : Initialize units tests
- [`add_vignette()`](https://frbcesab.github.io/rcompendium/reference/add_vignette.md)
  : Create a vignette document
- [`add_readme_rmd()`](https://frbcesab.github.io/rcompendium/reference/add_readme_rmd.md)
  : Create a README file
- [`add_compendium()`](https://frbcesab.github.io/rcompendium/reference/add_compendium.md)
  : Create additional folders
- [`add_makefile()`](https://frbcesab.github.io/rcompendium/reference/add_makefile.md)
  : Create a Make-like R file
- [`add_renv()`](https://frbcesab.github.io/rcompendium/reference/add_renv.md)
  : Initialize renv
- [`add_dockerfile()`](https://frbcesab.github.io/rcompendium/reference/add_dockerfile.md)
  : Create a Dockerfile

## README badges

These functions add badges to the `README.Rmd`. They are called by the
main functions `new_package`, `new_compendium`, and `refresh` but they
also can be used to update badges if license, lifecycle, repository
status change or to update number of dependencies
(`add_dependencies_badge`).

- [`add_cran_badge()`](https://frbcesab.github.io/rcompendium/reference/add_cran_badge.md)
  : Add a CRAN Status badge
- [`add_dependencies_badge()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies_badge.md)
  : Add a Dependencies badge
- [`add_license_badge()`](https://frbcesab.github.io/rcompendium/reference/add_license_badge.md)
  : Add a License badge
- [`add_lifecycle_badge()`](https://frbcesab.github.io/rcompendium/reference/add_lifecycle_badge.md)
  : Add a Life Cycle badge
- [`add_repostatus_badge()`](https://frbcesab.github.io/rcompendium/reference/add_repostatus_badge.md)
  : Add a Repository Status badge
- [`add_github_actions_check_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_check_badge.md)
  : Add a R CMD Check badge
- [`add_github_actions_pkgdown_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_pkgdown_badge.md)
  : Add a Website badge
- [`add_github_actions_codecov_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_codecov_badge.md)
  : Add a Test coverage badge
- [`add_codecov_badge()`](https://frbcesab.github.io/rcompendium/reference/add_codecov_badge.md)
  : Add a Codecov badge

## Advanced functions

These functions update fields in `DESCRIPTION` (`add_dependencies` and
`add_r_depend`), edit files (`add_to_gitignore` and
`add_to_buildignore`), or write configuration files
(`add_github_actions_check`, `add_github_actions_pkgdown`,
`add_github_actions_codecov`, and `add_github_actions_render`).

- [`add_dependencies()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies.md)
  : Add dependencies in DESCRIPTION
- [`add_r_depend()`](https://frbcesab.github.io/rcompendium/reference/add_r_depend.md)
  : Add minimal R version to DESCRIPTION
- [`add_to_gitignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_gitignore.md)
  : Add to the .gitignore file
- [`add_to_buildignore()`](https://frbcesab.github.io/rcompendium/reference/add_to_buildignore.md)
  : Add to the .Rbuildignore file
- [`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md)
  : Set up a GitHub Action workflow

## Utilities functions

These functions return objects but do not edit any file.

- [`get_licenses()`](https://frbcesab.github.io/rcompendium/reference/get_licenses.md)
  : List all available licenses
- [`get_all_dependencies()`](https://frbcesab.github.io/rcompendium/reference/get_all_dependencies.md)
  : Get all external dependencies
- [`get_all_functions()`](https://frbcesab.github.io/rcompendium/reference/get_all_functions.md)
  : List all functions in the package
- [`get_available_gh_actions()`](https://frbcesab.github.io/rcompendium/reference/get_available_gh_actions.md)
  : List available GitHub Actions
- [`get_minimal_r_version()`](https://frbcesab.github.io/rcompendium/reference/get_minimal_r_version.md)
  : Get required minimal R version
