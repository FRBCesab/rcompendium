# Store user information in the .Rprofile

This function is used to store user credentials (given and family names,
email, ORCID, GitHub username, etc.) in the `.Rprofile` file. This
function is useful to store user credentials once for all especially if
the user creates a lot of R projects and/or if the user manually calls
the `add_*()` functions.

This function will create the `.Rprofile` file if it does not exist.
Then, the user needs to paste the content of the clipboard to this file
(open by the function).

## Usage

``` r
set_credentials(
  given = NULL,
  family = NULL,
  email = NULL,
  orcid = NULL,
  github_user = NULL,
  protocol = "https",
  open = TRUE
)
```

## Arguments

- given:

  a `character` of length 1. The given name of the user (considered as
  the maintainer and code owner of the project).

- family:

  a `character` of length 1. The family name of the user (considered as
  the maintainer and code owner of the project).

- email:

  a `character` of length 1. The email address of the user (considered
  as the maintainer and code owner of the project).

- orcid:

  a `character` of length 1. The ORCID of the user (considered as the
  maintainer and code owner of the project).

- github_user:

  a `character` of length 1. The GitHub account name of the user
  (considered as the maintainer and code owner of the project).

- protocol:

  a `character` of length 1. The GIT protocol used to communicate with
  GitHub. One of `'https'` or `'ssh'`. If you don't know, keep the
  default value (i.e. `https`).

- open:

  a `logical` value. If `TRUE` (default) the `.Rprofile` is opened in
  the default text editor (recommended).

## Value

No return value.

## See also

Other setup functions:
[`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md),
[`new_package()`](https://frbcesab.github.io/rcompendium/reference/new_package.md)

## Examples

``` r
if (FALSE) { # \dontrun{
set_credentials(
  given = "John",
  family = "Doe",
  email = "john.doe@domain.com",
  orcid = "9999-9999-9999-9999",
  github_user = "jdoe",
  protocol = "https",
  open = TRUE
)
} # }
```
