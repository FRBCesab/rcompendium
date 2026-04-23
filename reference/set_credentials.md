# Store credentials to the .Rprofile

This function is used to store user credentials in the `.Rprofile` file.
Accepted credentials are listed below. This function is useful if user
creates a lot of packages and/or research compendiums.

If the `.Rprofile` file does not exist this function will create it.
Users need to paste the content of the clipboard to this file.

## Usage

``` r
set_credentials(
  given = NULL,
  family = NULL,
  email = NULL,
  orcid = NULL,
  protocol = NULL
)
```

## Arguments

- given:

  A character of length 1. The given name of the project maintainer.

- family:

  A character of length 1. The family name of the project maintainer.

- email:

  A character of length 1. The email address of the project maintainer.

- orcid:

  A character of length 1. The ORCID of the project maintainer.

- protocol:

  A character of length 1. The GIT protocol used to communicate with the
  GitHub remote. One of `'https'` or `'ssh'`. If you don't know, keep
  the default value (i.e. `NULL`) and the protocol will be `'https'`.

## Value

No return value.

## See also

Other setup functions:
[`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md),
[`new_package()`](https://frbcesab.github.io/rcompendium/reference/new_package.md)

## Examples

``` r
if (FALSE) { # \dontrun{
library(rcompendium)


## Define **ONCE FOR ALL** your credentials ----

set_credentials("John", "Doe", "john.doe@domain.com",
                orcid = "9999-9999-9999-9999", protocol = "https")
} # }
```
