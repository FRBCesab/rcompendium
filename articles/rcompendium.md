# Get started with rcompendium

`rcompendium` makes easier the creation of R packages or research
compendia (i.e. a predefined files/folders structure) so that users can
focus on the code/analysis instead of wasting time organizing files. A
full ready-to-work structure is set up with some additional features:
version control, remote repository creation, CI/CD configuration (check
package integrity under several OS, test code with `testthat`, and build
and deploy website using `pkgdown`).

  

## Prerequisites

Before using the package `rcompendium` you must follow these three
steps.

  

### GIT configuration

First ensure that **GIT** is correctly installed on your machine and
linked to RStudio. Read the Chapter 6 of [Happy Git and GitHub for the
useR](https://happygitwithr.com/install-git.html).

You also need to store your GIT credentials locally (i.e. for the
project) or globally (recommended). Run
[`gh::gh_whoami()`](https://gh.r-lib.org/reference/gh_whoami.html) to
see if your git and associated credentials are correctly configured. You
should see something like:

    {
      "name": "John Doe",
      "login": "jdoe",
      "html_url": "https://github.com/jdoe",
      ...
    }

Otherwise you might need to run:

``` r
gert::git_config_global_set(name = "user.name",   value = "John Doe")
gert::git_config_global_set(name = "user.email",  value = "john.doe@domain.com")
gert::git_config_global_set(name = "github.user", value = "jdoe")
```

See
[`?gert::git_config_global_set`](https://docs.ropensci.org/gert/reference/git_config.html)
for further information.

  

### Creating a GitHub repo

To create the GitHub repository directly from R, the package
`rcompendium` uses the function
[`usethis::use_github()`](https://usethis.r-lib.org/reference/use_github.html),
a client to the GitHub REST API. The interaction with this API required
an authentication method: a **GITHUB PAT** (Personal Access Token).

If you don’t have a **GITHUB PAT** locally stored, you must:

1.  visit the page <https://github.com/settings/tokens> and create a new
    token;
2.  store it in the `~/.Renviron` file by using
    [`usethis::edit_r_environ()`](https://usethis.r-lib.org/reference/edit.html)
    and adding the following line: `GITHUB_PAT='ghp_99z9...z9'`.

Run
[`usethis::gh_token_help()`](https://usethis.r-lib.org/reference/github-token.html)
for more information about getting and configuring a **GITHUB PAT**.

If everything is well configured, you should see something like this
after calling
[`gh::gh_whoami()`](https://gh.r-lib.org/reference/gh_whoami.html):

    {
      "name": "John Doe",
      "login": "jdoe",
      "html_url": "https://github.com/jdoe",
      "scopes": "delete_repo, repo, workflow",
      "token": "ghp_99z9...z9"
    }

Then you will be able to create a GitHub repository directly from R!

  

### Managing credentials

You can use the arguments `given`, `family`, `email`, and `orcid`
directly with the functions `new_*()` and `add_*()`. But if you create a
lot a projects (packages and/or compendia) it can be frustrating in the
long run.

An alternative way is to use **ONCE AND FOR ALL** the function
[`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)
to permanently store this information in the `~/.Rprofile` file. If
these arguments are set to `NULL` while calling any function of the
package, `rcompendium` will search their values in this file. It will
save your time (it’s the purpose of this package).

Even if you have stored your credentials in the `~/.Rprofile` file you
will always be able to modify them on-the-fly (i.e. by using credentials
arguments in the functions `new_*()` and `add_*()`) or permanently by
re-running
[`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md).

  

## Usage

The recommended workflow is:

1.  Store your credentials with
    [`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)
    (if not already done);
2.  **IMPORTANT -** Create an new empty RStudio project;
3.  Run
    [`new_package()`](https://frbcesab.github.io/rcompendium/reference/new_package.md)
    to create a new package structure or
    [`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md)
    to create a new research compendium structure;
4.  Edit some metadata in `DESCRIPTION`, `CITATION`, and `README.Rmd`;
5.  Start working (add data, write and document R functions, etc.);
6.  And do not forget to commit your changes.

  

In addition to these three setup functions
([`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md),
[`new_package()`](https://frbcesab.github.io/rcompendium/reference/new_package.md),
[`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md)),
the package `rcompendium` offers 29 other functions. These can be
grouped as:

- `add_*()`: functions to add/update/overwrite files, configuration
  settings, dependencies, badges, etc.;
- `get_*()`: functions to retrieve some information (available licenses,
  R version, etc.).

Visit the [Reference
page](https://frbcesab.github.io/rcompendium/reference/index.html) for
further details.

  

**To sum up**

``` r
## Define ONCE FOR ALL your credentials ----

rcompendium::set_credentials(given = "John", family = "Doe", 
                             email = "john.doe@domain.com", 
                             orcid = "9999-9999-9999-9999", protocol = "ssh")


## CREATE A NEW EMPTY RSTUDIO PROJECT ----


## Create an R package structure ----

rcompendium::new_package()


## Then... 
## ... edit metadata in DESCRIPTION, CITATION, README.Rmd, etc.
## ... implement and document R functions in R/


## Update functions documentation and NAMESPACE ----

devtools::document()


## Update list of dependencies in DESCRIPTION ----

rcompendium::add_dependencies()


## Check package ----

devtools::check()


## Example: use of an add_*() function ...
## ... update 'Number of Dependencies Badge' in README.Rmd ----

rcompendium::add_dependencies_badge()
```

**N.B.** Users can also use functions from the package
[`usethis`](https://usethis.r-lib.org/) to add some missing features
(e.g. `data/` and package release tools).

  

## Resources

- [Developing an R
  package](https://frbcesab.github.io/rcompendium/articles/developing_a_package.html)
- [Working with a
  compendium](https://frbcesab.github.io/rcompendium/articles/working_with_a_compendium.html)

  

## Contributing

You are welcome to contribute to the `rcompendium` project. Please read
our [Contribution
Guidelines](https://frbcesab.github.io/rcompendium/CONTRIBUTING.html).

Please note that the `rcompendium` project is released with a
[Contributor Code of
Conduct](https://frbcesab.github.io/rcompendium/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

  

## Colophon

This package is the result of intense discussions and feedback from the
training course [Data Toolbox for Reproducible Research in Computational
Ecology](https://rdatatoolbox.github.io/).

`rcompendium` is largely inspired by the package
[`rrtools`](https://github.com/benmarwick/rrtools) developed by [Ben
Marwick *et al.*](https://github.com/benmarwick) and tries to respect
the standard defined by the community. **Special thanks to these
developers!**
