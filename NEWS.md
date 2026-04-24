# rcompendium 2.0.0.9000

* **BREAKING CHANGE**

  * Remove file templates and licenses from the package. These files are now hosted on <https://github.com/frbcesab/r-templates>, providing more flexibility in updating these files without releasing a new version of `rcompendium` ([#207ae09](https://github.com/FRBCesab/rcompendium/commit/207ae09ebcc6519258807014c9e9752ecd2f73bf)).
  * Remove all `add_github_actions_*()` functions. A new generic function `add_github_action()` has been implemented to set up any GitHub Action. This function downloads YAML files from the GitHub repository (see above), providing more flexibility in updating these files ([#87](https://github.com/FRBCesab/rcompendium/pull/87)).

* **Deprecated**

  * `refresh()` is no more available in this version ([#91](https://github.com/FRBCesab/rcompendium/pull/91))

* **New features**

  * Add a new internal function `download_template()` to download a file template from the GitHub repo <https://github.com/frbcesab/r-templates> ([#85](https://github.com/FRBCesab/rcompendium/pull/85))
  * `add_github_actions_*()` automatically creates a `.github/dependabot.yaml` file if one GitHub Action is set up ([#89](https://github.com/FRBCesab/rcompendium/pull/89))
  * `add_cran_downloads_badge()` & `add_cran_total_download_badge()` add CRAN downloads badge to the `README.Rmd` ([#96](https://github.com/FRBCesab/rcompendium/pull/96))

* **Bug fixes**

* **Minor changes**

  * Set up Air formatter for the repository ([#76](https://github.com/FRBCesab/rcompendium/pull/76))
  * Add dependabot for GitHub Actions([#77](https://github.com/FRBCesab/rcompendium/pull/77))
  * Add download badges in README ([#78](https://github.com/FRBCesab/rcompendium/pull/78))
  * Remove dependency to `cffr` and `codemetar` packages ([#87](https://github.com/FRBCesab/rcompendium/pull/87))
  * Rename `add_cran_badge()` in `add_cran_version_badge()` ([#96](https://github.com/FRBCesab/rcompendium/pull/96))

# rcompendium 1.4.0

* **New features**

  * `add_github_actions_codemeta()` creates a `codemeta.json` file at the root of the project and adds a GH action to automatically update this file by GitHub servers.

* **Bug fixes**

  * `get_all_functions()` better detects functions (e.g. `function ()`)
  * `get_all_functions()` ignores `julia_library()` functions
  * `get_all_functions()` screens Quarto files
  * `add_sticker()` copies the sticker template in `figures/readme/` and no more in `man/figures/` (listed in the `.gitignore`)
  * Fix CRAN note about cross-references for external packages

* **Minor changes**

  * Remove dependency to `crayon` and `clisymbols` in favor of `cli`
  * Improve templates
  * `add_compendium()` does not create subfolders in `data/`


# rcompendium 1.3

* **Bug fixes**

  * `get_deps_*()` better detects project dependencies and does not delete 
  packages called w/ `library("pkg")` or `library('pkg')`
  * `add_sticker()` now copies the sticker template for compendium

* **Minor changes**

  * Provide instructions for installing V8 engine on Unix systems


# rcompendium 1.2

* **New features**

  * `get_git_branch_name()` detects git branch name
  * `add_contributing()` adds a `CONTRIBUTING.md` file and issue templates
  * `add_code_of_conduct()` adds a `CODE_OF_CONDUCT.md` file
  * `add_github_actions_citation()` adds a new GitHub action to update the 
  `CITATION.cff` file
  * `add_github_actions_document()` adds a new GitHub action to update `Rd` files,
  the `NAMESPACE` and the `DESCRIPTION` files

* **Improvements**

  * `get_deps_*()` better detects project dependencies
  * `add_compendium()` allows now the user to choose its own compendium structure

* **Minor changes**

  * Update GitHub Actions templates (`yaml` files)
  * Update README templates
  * The `man/` folder and `NAMESPACE` are now untracked by git (for compendium only)
  * Remove dependencies badge in README
  * Change default values of `lifecycle` and `status` arguments in `new_package()`
  * Change commit messages in `new_*()` functions (conventional commits)

* **Deprecated**

  * `refresh()` is now deprecated and will be deleted in the new version


# rcompendium 1.1

* Update GitHub Actions templates (`yaml` files)
* Detect current git branch name in `add_readme_rmd()`
* Ignore `renv` files (R build and GitHub) in `add_renv()`


# rcompendium 1.0

* New feature: `add_dockerfile()` creates a basic `Dockerfile` in compendium (new 
argument `dokerfile` in `new_compendium()`) based on `rocker/rstudio`.
* New feature: `add_renv()` initialize `renv` environment in compendium (new 
argument `renv` in `new_compendium()`)
* New feature: `add_github_actions_render()` will automatically render
the `README.md` on GitHub server after each push. This action is triggered
only if the `README.Rmd` has been modified since the last commit. Also
add new argument `gh_render` in `new_*()` functions.
* New vignette: developing an R package
* New vignette: working with a compendium
* Function `add_dependencies()` allows now missing `R/` folder and improves the
detection of dependencies in vignettes.
* Function `add_lifecycle_badge()` does not copy badge SVG in the project 
anymore. The image badge is now created using https://shields.io/.
* Update GHA templates. They are now derived from:
https://github.com/r-lib/actions/tree/v2-branch/examples
* Rename default vignette title (title is now _Get Started_)
* Add `cph` (copyright holder) tag in `DESCRIPTION` file
* Change default package hexSticker and add R script in `inst/package-sticker/` 
to easily change the hexSticker
* Rename commits messages (and remove emoji)
* For compendium: arguments `gh_check` and `website` are now `FALSE` by default
* For compendium: rename `rscripts/` folder to `analyses/`
* For compendium: delete `paper/` folder
* Review and improve documentation
* Rename templates file names
* Fix bug: detection of nested RStudio projects


# rcompendium 0.5.1

After first submission to CRAN:

* `DESCRIPTION` file: replace "The aim of the package 'rcompendium' is to make 
easier..." by "Makes easier..."
* Function `set_credentials()` does not write the `.Rprofile` file anymore 
(not allowed by CRAN policies). Instead this function opens this file and users 
need to manually paste the content of the clipboard.
* Replace `utils::installed.packages()` by `find.package()`


# rcompendium 0.5

* Check for valid package name
* Add new features: `new_compendium()` and `add_compendium()`
* Allow adding to `.gitignore` and `.Rbuildignore` several names
* Improve console messages
* Modify templates


# rcompendium 0.4.1

* Improve documentation


# rcompendium 0.4

* New features: `add_testthat()`, `add_github_actions_codecov()`, 
`add_github_actions_codecov_badge()`, and `add_codecov_badge()`
* New arguments in `new_package()`: `test` and `codecov`
* Add a demo R function to pass test and show good practices in writing 
functions


# rcompendium 0.3

* Improve dependencies detection in `@examples` sections
* Keep packages versions in `DESCRIPTION` fields
* Retrieve GitHub pseudo with `gh::gh_whoami()` (no more `github` argument)


# rcompendium 0.2

* Rename `import` argument into `compendium`
* Automatically check dependencies in `vignettes/` (remove argument `suggest`)
* Detect dependencies in `tests/`
* Add new internal function `path_proj()`
* Use `usethis::proj_get()` instead of `here::here()`
* Rename `add_github_badge()` in `add_github_actions_check_badge()`
* Add new function `add_github_actions_pkgdown_badge()`
* Badge functions return now Markdown badges (if assigned to a variable)
* Badges are added at the end of the process (adding a additional commit)
* Change default license in `new_package()`
* Improve inputs checks
* Change files templates (GH Actions names)


# rcompendium 0.1

* First release of the package.
