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
