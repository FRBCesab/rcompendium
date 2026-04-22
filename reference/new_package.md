# Create an R package structure

This function creates a new R package structure according to the current
best practices. Essential features of an R package are created
(`DESCRIPTION` and `NAMESPACE` files, and `R/` and `man/` folders). The
project is also **versioned with git** and a generic R `.gitignore` is
added.

**IMPORTANT -** Before using this function user needs to create a new
folder (or a new project if using RStudio) and run this function inside
this folder (by using [`setwd()`](https://rdrr.io/r/base/getwd.html) or
by opening the `Rproj` in a new RStudio session). **The name of the
package will be the same as the name of this folder**. Some rules must
be respected: <https://r-pkgs.org/workflow101.html#name-your-package>.

Some fields of the `DESCRIPTION` file (maintainer information, package
name, license, URLs, and `roxygen2` version) are automatically filled
but others (like title and description) need to be edited manually.

Additional features are also created: a `CITATION` file, a `README.Rmd`,
and `tests/` and `vignettes/` folders (optional). See the vignette [Get
started](https://frbcesab.github.io/rcompendium/articles/rcompendium.html)
for a complete overview of the full structure.

A GitHub repository can also be created (default) following the "GitHub
last" workflow (<https://happygitwithr.com/existing-github-last.html>).
Configuration files for GitHub Actions to automatically 1) check the
package, 2) test and report code coverage, and 3) deploy the website
using [`pkgdown`](https://pkgdown.r-lib.org/index.html) will be added in
the `.github/` folder. See below the section **Creating a GitHub repo**.

## Usage

``` r
new_package(
  license = "GPL (>= 2)",
  status = NULL,
  lifecycle = NULL,
  contributing = TRUE,
  code_of_conduct = TRUE,
  vignette = TRUE,
  test = TRUE,
  create_repo = TRUE,
  private = FALSE,
  gh_check = TRUE,
  codecov = TRUE,
  website = TRUE,
  gh_render = TRUE,
  gh_citation = TRUE,
  gh_codemeta = TRUE,
  given = NULL,
  family = NULL,
  email = NULL,
  orcid = NULL,
  organisation = NULL,
  overwrite = FALSE,
  quiet = FALSE
)
```

## Arguments

- license:

  A character vector of length 1. The license to be used for this
  package. Run
  [`get_licenses()`](https://frbcesab.github.io/rcompendium/reference/get_licenses.md)
  to choose an appropriate one. Default is `license = 'GPL (>= 2)'`

  The license can be changed later by calling
  [`add_license()`](https://frbcesab.github.io/rcompendium/reference/add_license.md)
  (and
  [`add_license_badge()`](https://frbcesab.github.io/rcompendium/reference/add_license_badge.md)
  or
  [`refresh()`](https://frbcesab.github.io/rcompendium/reference/refresh.md)
  to update the corresponding badge in the README).

- status:

  A character vector of length 1. The status of the project according to
  the standard defined by the <https://www.repostatus.org> project. One
  among `'concept'`, `'wip'`, `'suspended'`, `'abandoned'`, `'active'`,
  `'inactive'`, or `'unsupported'`. See
  [`add_repostatus_badge()`](https://frbcesab.github.io/rcompendium/reference/add_repostatus_badge.md)
  for further information.

  This argument is used to add a badge to the `README.Rmd` to help
  visitors to better understand your project. If you don't want this
  badge use `status = NULL` (default).

  This status can be added/changed later by using
  [`add_repostatus_badge()`](https://frbcesab.github.io/rcompendium/reference/add_repostatus_badge.md).

- lifecycle:

  A character vector of length 1. The life cycle stage of the project
  according to the standard defined at
  <https://lifecycle.r-lib.org/articles/stages.html>. One among
  `'experimental'`, `'stable'`, `'deprecated'`, or `'superseded'`. See
  [`add_lifecycle_badge()`](https://frbcesab.github.io/rcompendium/reference/add_lifecycle_badge.md)
  for further information.

  This argument is used to add a badge to the `README.Rmd` to help
  visitors to better understand your project. If you don't want this
  badge use `lifecycle = NULL` (default).

  This stage can be added/changed later by using
  [`add_lifecycle_badge()`](https://frbcesab.github.io/rcompendium/reference/add_lifecycle_badge.md).

- contributing:

  A logical value. If `TRUE` (default) adds a `CONTRIBUTING.md` file and
  `ISSUE_TEMPLATES`. See
  [`add_contributing()`](https://frbcesab.github.io/rcompendium/reference/add_contributing.md)
  for further information.

- code_of_conduct:

  A logical value. If `TRUE` (default) adds a `CODE_OF_CONDUCT.md` file.
  See
  [`add_code_of_conduct()`](https://frbcesab.github.io/rcompendium/reference/add_code_of_conduct.md)
  for further information.

- vignette:

  A logical value. If `TRUE` (default) creates a vignette in
  `vignettes/`. Packages [`knitr`](https://yihui.org/knitr/) and
  [`rmarkdown`](https://rmarkdown.rstudio.com/) are also added to the
  `Suggests` field in the `DESCRIPTION` file.

- test:

  A logical value. If `TRUE` (default) initializes units tests by
  running
  [`usethis::use_testthat()`](https://usethis.r-lib.org/reference/use_testthat.html).
  Package [`testthat`](https://testthat.r-lib.org) is also added to the
  `Suggests` field in the `DESCRIPTION` file.

- create_repo:

  A logical value. If `TRUE` (default) creates a repository (public if
  `private = FALSE` or private if `private = TRUE`) on GitHub. See below
  the section **Creating a GitHub repo**.

- private:

  A logical value. If `TRUE` creates a private repository on user GitHub
  account (or organisation). Default is `private = FALSE`.

- gh_check:

  A logical value. If `TRUE` (default) configures GitHub Actions to
  automatically check and test the package after each push. This will
  run `R CMD check` on the three major operating systems (Ubuntu, macOS,
  and Windows) on the latest release of R. See
  [`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md)
  for further information.

  If `create_repo = FALSE` this argument is ignored.

- codecov:

  A logical value. If `TRUE` (default) configures GitHub Actions to
  automatically report the code coverage of units tests after each push.
  See
  [`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md)
  for further information.

  If `create_repo = FALSE` this argument is ignored.

- website:

  A logical value. If `TRUE` (default) configures GitHub Actions to
  automatically build and deploy the package website (using
  [`pkgdown`](https://pkgdown.r-lib.org/index.html)) after each push. A
  **gh-pages** branch will be created using
  [`usethis::use_github_pages()`](https://usethis.r-lib.org/reference/use_github_pages.html)
  and the GitHub repository will be automatically configured to deploy
  website.

  If `create_repo = FALSE` this argument is ignored.

- gh_render:

  A logical value. If `TRUE` (default) configures GitHub Actions to
  automatically knit the `README.Rmd` after each push. See
  [`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md)
  for further information.

  If `create_repo = FALSE` this argument is ignored.

- gh_citation:

  A logical value. If `TRUE` (default) configures GitHub Actions to
  automatically update the `CITATION.cff` file. See
  [`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md)
  for further information.

  If `create_repo = FALSE` this argument is ignored.

- gh_codemeta:

  A logical value. If `TRUE` (default) configures GitHub Actions to
  automatically update the `codemeta.json` file. See
  [`add_github_action()`](https://frbcesab.github.io/rcompendium/reference/add_github_action.md)
  for further information.

  If `create_repo = FALSE` this argument is ignored.

- given:

  A character vector of length 1. The given name of the maintainer of
  the package. If `NULL` (default) the function will try to get this
  value by reading the `.Rprofile` file.

  For further information see
  [`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)
  and below the section **Managing credentials**.

- family:

  A character vector of length 1. The family name of the maintainer of
  the package. If `NULL` (default) the function will try to get this
  value by reading the `.Rprofile` file.

  For further information see
  [`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)
  and below the section **Managing credentials**.

- email:

  A character vector of length 1. The email address of the maintainer of
  the package. If `NULL` (default) the function will try to get this
  value by reading the `.Rprofile` file.

  For further information see
  [`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)
  and below the section **Managing credentials**.

- orcid:

  A character vector of length 1. The ORCID of the maintainer of the
  package. If `NULL` (default) the function will try to get this value
  by reading the `.Rprofile` file.

  For further information see
  [`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)
  and below the section **Managing credentials**.

- organisation:

  A character vector of length 1. The GitHub organisation to host the
  repository. If defined it will overwrite the GitHub pseudo.

  Default is `organisation = NULL` (the GitHub pseudo will be used).

- overwrite:

  A logical value. If `TRUE` files written from templates and modified
  by user are erased. Default is `overwrite = FALSE`. **Be careful while
  using this argument**.

- quiet:

  A logical value. If `TRUE` messages are deleted. Default is `FALSE`.

## Value

No return value.

## Recommended workflow

The purpose of the package `rcompendium` is to make easier the creation
of R package/research compendium so that user can focus on the
code/analysis instead of wasting time organizing files.

The recommended workflow is:

1.  Create an empty RStudio project;

2.  Store your credentials with
    [`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)
    (if not already done);

3.  Run `new_package()` to create a new package structure (and the
    GitHub repository);

4.  Edit some metadata in `DESCRIPTION`, `CITATION`, and `README.Rmd`;

5.  Implement, document & test functions (the fun part);

6.  Update the project (update `.Rd` files, `NAMESPACE`, external
    dependencies in `DESCRIPTION`, re-knit `README.Rmd`, and check
    package integrity) with
    [`refresh()`](https://frbcesab.github.io/rcompendium/reference/refresh.md);

7.  Repeat steps 5 and 6 while developing the package.

## Managing credentials

You can use the arguments `given`, `family`, `email`, and `orcid`
directly with the function `new_package()` (and others). But if you
create a lot a projects (packages and/or compendiums) it can be
frustrating in the long run.

An alternative is to use **ONCE AND FOR ALL** the function
[`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)
to permanently store this information in the `.Rprofile` file. If these
arguments are set to `NULL` (default) each function of the package
`rcompendium` will search in this `.Rprofile` file. It will save your
time (it's the purpose of this package).

Even if you have stored your information in the `.Rprofile` file you
will always be able to modify them on-the-fly (i.e. by using arguments
of the `new_package()`) or permanently by re-running
[`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md).

## Configuring git

First run
[`gh::gh_whoami()`](https://gh.r-lib.org/reference/gh_whoami.html) to
see if your git is correctly configured. If so you should see something
like:

    {
      "name": "John Doe",
      "login": "jdoe",
      "html_url": "https://github.com/jdoe",
      ...
    }

Otherwise you might need to run:

    gert::git_config_global_set(name  = "user.name",
                                value = "John Doe")

    gert::git_config_global_set(name  = "user.email",
                                value = "john.doe@domain.com")

    gert::git_config_global_set(name  = "github.user",
                                value = "jdoe")

See
[`gert::git_config_global_set()`](https://docs.ropensci.org/gert/reference/git_config.html)
for further information.

## Creating a GitHub repo

To create the GitHub repository directly from R, the package
`rcompendium` uses the function
[`usethis::use_github()`](https://usethis.r-lib.org/reference/use_github.html),
an client to the GitHub REST API. The interaction with this API required
an authentication method: a **GITHUB PAT** (Personal Access Token).

If you don't have a **GITHUB PAT** locally stored, you must:

1.  Obtain a new one from your GitHub account. **Make sure to select at
    least the first two scopes (private repository and workflow)**

2.  Store it in the `~/.Renviron` file by using
    [`usethis::edit_r_environ()`](https://usethis.r-lib.org/reference/edit.html)
    and adding the following line: `GITHUB_PAT='ghp_99z9...z9'`

Run
[`usethis::gh_token_help()`](https://usethis.r-lib.org/reference/github-token.html)
for more information about getting and configuring a **GITHUB PAT**.

If everything is well configured you should see something like this
after calling
[`gh::gh_whoami()`](https://gh.r-lib.org/reference/gh_whoami.html):

    {
      "name": "John Doe",
      "login": "jdoe",
      "html_url": "https://github.com/jdoe",
      "scopes": "delete_repo, repo, workflow",
      "token": "ghp_99z9...z9"
    }

And you will be able to create a GitHub repository directly from R!

## See also

Other setup functions:
[`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md),
[`refresh()`](https://frbcesab.github.io/rcompendium/reference/refresh.md),
[`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)

## Examples

``` r
if (FALSE) { # \dontrun{
library(rcompendium)

## Define **ONCE FOR ALL** your credentials ----
set_credentials(given = "John", family = "Doe",
                email = "john.doe@domain.com",
                orcid = "9999-9999-9999-9999", protocol = "ssh")

## Create an R package ----
new_package()

## Start developing functions ----
## ...

## Update package (documentation, dependencies, README, check) ----
refresh()
} # }
```
