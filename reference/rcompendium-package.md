# Create a package or research compendium structure

`rcompendium` makes easier the creation of R packages or research
compendia (i.e. a predefined files/folders structure) so that users can
focus on the code/analysis instead of wasting time organizing files. A
full ready-to-work structure is set up with some additional features:
version control, remote repository creation, CI/CD configuration (check
package integrity under several OS, test code with 'testthat', and build
and deploy website using 'pkgdown').

## Recommended workflow

1.  Store your credentials (given and family names, email, ORCID, etc.)
    with
    [`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)
    (if not already done);

2.  Create an new empty RStudio project;

3.  Run
    [`new_package()`](https://frbcesab.github.io/rcompendium/reference/new_package.md)
    to create a new package structure or
    [`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md)
    to create a new research compendium structure;

4.  Edit some metadata in `DESCRIPTION`, `CITATION`, and `README.Rmd`;

5.  Start working (add data, write and document R functions, etc.);

6.  And do not forget to commit your changes.

## Managing credentials

You can use the arguments `given`, `family`, `email`, and `orcid`
directly with the functions `new_*()` and `add_*()`. But if you create a
lot a projects (packages and/or compendia) it can be frustrating in the
long run.

An alternative way is to use **ONCE AND FOR ALL** the function
[`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md)
to permanently store this information in the `~/.Rprofile` file. If
these arguments are set to `NULL` while calling any function of the
package, `rcompendium` will search their values in this file. It will
save your time (it's the purpose of this package).

Even if you have stored your credentials in the `~/.Rprofile` file you
will always be able to modify them on-the-fly (i.e. by using credentials
arguments in the functions `new_*()` and `add_*()`) or permanently by
re-running
[`set_credentials()`](https://frbcesab.github.io/rcompendium/reference/set_credentials.md).

## Configuring git

To see if **git** is correctly configured on your laptop, run
[`gh::gh_whoami()`](https://gh.r-lib.org/reference/gh_whoami.html). You
should see something like:

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
a client to the GitHub REST API. The interaction with this API required
an authentication method: a **GITHUB PAT** (Personal Access Token).

If you don't have a **GITHUB PAT** locally stored, you must:

1.  Visit the page <https://github.com/settings/tokens> and create a new
    token;

2.  Store it in the `~/.Renviron` file by using
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
      "scopes": "repo, workflow",
      "token": "ghp_...z99Z"
    }

## Resources

- Developing an R package:
  <https://frbcesab.github.io/rcompendium/articles/developing_a_package.html>

- Working with a compendium:
  <https://frbcesab.github.io/rcompendium/articles/working_with_a_compendium.html>

## See also

Useful links:

- <https://github.com/FRBCesab/rcompendium>

- <https://frbcesab.github.io/rcompendium/>

- Report bugs at <https://github.com/FRBCesab/rcompendium/issues>

## Author

**Maintainer**: Nicolas Casajus
<nicolas.casajus@fondationbiodiversite.fr>
([ORCID](https://orcid.org/0000-0002-5537-5294)) \[copyright holder\]
