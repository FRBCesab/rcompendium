# Changelog

## rcompendium 1.4.0

- **New features**

  - [`add_github_actions_codemeta()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_codemeta.md)
    creates a `codemeta.json` file at the root of the project and adds a
    GH action to automatically update this file by GitHub servers.

- **Bug fixes**

  - [`get_all_functions()`](https://frbcesab.github.io/rcompendium/reference/get_all_functions.md)
    better detects functions (e.g. `function ()`)
  - [`get_all_functions()`](https://frbcesab.github.io/rcompendium/reference/get_all_functions.md)
    ignores `julia_library()` functions
  - [`get_all_functions()`](https://frbcesab.github.io/rcompendium/reference/get_all_functions.md)
    screens Quarto files
  - `add_sticker()` copies the sticker template in `figures/readme/` and
    no more in `man/figures/` (listed in the `.gitignore`)
  - Fix CRAN note about cross-references for external packages

- **Minor changes**

  - Remove dependency to `crayon` and `clisymbols` in favor of `cli`
  - Improve templates
  - [`add_compendium()`](https://frbcesab.github.io/rcompendium/reference/add_compendium.md)
    does not create subfolders in `data/`

## rcompendium 1.3

CRAN release: 2023-10-26

- **Bug fixes**

  - `get_deps_*()` better detects project dependencies and does not
    delete packages called w/
    [`library("pkg")`](https://rdrr.io/r/base/library.html) or
    [`library('pkg')`](https://rdrr.io/r/base/library.html)
  - `add_sticker()` now copies the sticker template for compendium

- **Minor changes**

  - Provide instructions for installing V8 engine on Unix systems

## rcompendium 1.2

CRAN release: 2023-10-24

- **New features**

  - `get_git_branch_name()` detects git branch name
  - [`add_contributing()`](https://frbcesab.github.io/rcompendium/reference/add_contributing.md)
    adds a `CONTRIBUTING.md` file and issue templates
  - [`add_code_of_conduct()`](https://frbcesab.github.io/rcompendium/reference/add_code_of_conduct.md)
    adds a `CODE_OF_CONDUCT.md` file
  - [`add_github_actions_citation()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_citation.md)
    adds a new GitHub action to update the `CITATION.cff` file
  - [`add_github_actions_document()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_document.md)
    adds a new GitHub action to update `Rd` files, the `NAMESPACE` and
    the `DESCRIPTION` files

- **Improvements**

  - `get_deps_*()` better detects project dependencies
  - [`add_compendium()`](https://frbcesab.github.io/rcompendium/reference/add_compendium.md)
    allows now the user to choose its own compendium structure

- **Minor changes**

  - Update GitHub Actions templates (`yaml` files)
  - Update README templates
  - The `man/` folder and `NAMESPACE` are now untracked by git (for
    compendium only)
  - Remove dependencies badge in README
  - Change default values of `lifecycle` and `status` arguments in
    [`new_package()`](https://frbcesab.github.io/rcompendium/reference/new_package.md)
  - Change commit messages in `new_*()` functions (conventional commits)

- **Deprecated**

  - [`refresh()`](https://frbcesab.github.io/rcompendium/reference/refresh.md)
    is now deprecated and will be deleted in the new version

## rcompendium 1.1

CRAN release: 2023-04-24

- Update GitHub Actions templates (`yaml` files)
- Detect current git branch name in
  [`add_readme_rmd()`](https://frbcesab.github.io/rcompendium/reference/add_readme_rmd.md)
- Ignore `renv` files (R build and GitHub) in
  [`add_renv()`](https://frbcesab.github.io/rcompendium/reference/add_renv.md)

## rcompendium 1.0

CRAN release: 2022-04-06

- New feature:
  [`add_dockerfile()`](https://frbcesab.github.io/rcompendium/reference/add_dockerfile.md)
  creates a basic `Dockerfile` in compendium (new argument `dokerfile`
  in
  [`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md))
  based on `rocker/rstudio`.
- New feature:
  [`add_renv()`](https://frbcesab.github.io/rcompendium/reference/add_renv.md)
  initialize `renv` environment in compendium (new argument `renv` in
  [`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md))
- New feature:
  [`add_github_actions_render()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_render.md)
  will automatically render the `README.md` on GitHub server after each
  push. This action is triggered only if the `README.Rmd` has been
  modified since the last commit. Also add new argument `gh_render` in
  `new_*()` functions.
- New vignette: developing an R package
- New vignette: working with a compendium
- Function
  [`add_dependencies()`](https://frbcesab.github.io/rcompendium/reference/add_dependencies.md)
  allows now missing `R/` folder and improves the detection of
  dependencies in vignettes.
- Function
  [`add_lifecycle_badge()`](https://frbcesab.github.io/rcompendium/reference/add_lifecycle_badge.md)
  does not copy badge SVG in the project anymore. The image badge is now
  created using <https://shields.io/>.
- Update GHA templates. They are now derived from:
  <https://github.com/r-lib/actions/tree/v2-branch/examples>
- Rename default vignette title (title is now *Get Started*)
- Add `cph` (copyright holder) tag in `DESCRIPTION` file
- Change default package hexSticker and add R script in
  `inst/package-sticker/` to easily change the hexSticker
- Rename commits messages (and remove emoji)
- For compendium: arguments `gh_check` and `website` are now `FALSE` by
  default
- For compendium: rename `rscripts/` folder to `analyses/`
- For compendium: delete `paper/` folder
- Review and improve documentation
- Rename templates file names
- Fix bug: detection of nested RStudio projects

## rcompendium 0.5.1

CRAN release: 2021-03-24

After first submission to CRAN:

- `DESCRIPTION` file: replace “The aim of the package ‘rcompendium’ is
  to make easier…” by “Makes easier…”
- Function
  [`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)
  does not write the `.Rprofile` file anymore (not allowed by CRAN
  policies). Instead this function opens this file and users need to
  manually paste the content of the clipboard.
- Replace
  [`utils::installed.packages()`](https://rdrr.io/r/utils/installed.packages.html)
  by [`find.package()`](https://rdrr.io/r/base/find.package.html)

## rcompendium 0.5

- Check for valid package name
- Add new features:
  [`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md)
  and
  [`add_compendium()`](https://frbcesab.github.io/rcompendium/reference/add_compendium.md)
- Allow adding to `.gitignore` and `.Rbuildignore` several names
- Improve console messages
- Modify templates

## rcompendium 0.4.1

- Improve documentation

## rcompendium 0.4

- New features:
  [`add_testthat()`](https://frbcesab.github.io/rcompendium/reference/add_testthat.md),
  [`add_github_actions_codecov()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_codecov.md),
  [`add_github_actions_codecov_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_codecov_badge.md),
  and
  [`add_codecov_badge()`](https://frbcesab.github.io/rcompendium/reference/add_codecov_badge.md)
- New arguments in
  [`new_package()`](https://frbcesab.github.io/rcompendium/reference/new_package.md):
  `test` and `codecov`
- Add a demo R function to pass test and show good practices in writing
  functions

## rcompendium 0.3

- Improve dependencies detection in `@examples` sections
- Keep packages versions in `DESCRIPTION` fields
- Retrieve GitHub pseudo with
  [`gh::gh_whoami()`](https://gh.r-lib.org/reference/gh_whoami.html) (no
  more `github` argument)

## rcompendium 0.2

- Rename `import` argument into `compendium`
- Automatically check dependencies in `vignettes/` (remove argument
  `suggest`)
- Detect dependencies in `tests/`
- Add new internal function `path_proj()`
- Use
  [`usethis::proj_get()`](https://usethis.r-lib.org/reference/proj_utils.html)
  instead of `here::here()`
- Rename `add_github_badge()` in
  [`add_github_actions_check_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_check_badge.md)
- Add new function
  [`add_github_actions_pkgdown_badge()`](https://frbcesab.github.io/rcompendium/reference/add_github_actions_pkgdown_badge.md)
- Badge functions return now Markdown badges (if assigned to a variable)
- Badges are added at the end of the process (adding a additional
  commit)
- Change default license in
  [`new_package()`](https://frbcesab.github.io/rcompendium/reference/new_package.md)
- Improve inputs checks
- Change files templates (GH Actions names)

## rcompendium 0.1

- First release of the package.
