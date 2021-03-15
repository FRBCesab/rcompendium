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
* Automatically check dependencies in vignettes/ (remove argument `suggest`)
* Detect dependencies in `tests/`
* Add new internal function `path_proj()`
* Use `usethis::proj_get()` instead of `here::here()`
* Rename `add_github_badge()` in `add_github_check_badge()`
* Add new function `add_github_pkgdown_badge()`
* Badge functions return now Markdown badges
* Badges are added at the new (adding a commit)
* Change default license in `new_package()` (MIT)
* Improve inputs checks
* Change files templates (GH Actions names)


# rcompendium 0.1

* First release of the package.
