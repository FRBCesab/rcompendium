#' Store user information in the .Rprofile
#'
#' @description
#' This function is used to store user credentials (given and family names,
#' email, ORCID, GitHub username, etc.) in the `.Rprofile` file.
#' This function is useful to store user credentials once for all especially if
#' the user creates a lot of R projects and/or if the user manually calls
#' the `add_*()` functions.
#'
#' This function will create the `.Rprofile` file if it does not exist. Then,
#' the user needs to paste the content of the clipboard to this file (open by
#' the function).
#'
#' @param given a `character` of length 1. The given name of the user
#'   (considered as the maintainer and code owner of the project).
#'
#' @param family a `character` of length 1. The family name of the user
#'   (considered as the maintainer and code owner of the project).
#'
#' @param email a `character` of length 1. The email address of the user
#'   (considered as the maintainer and code owner of the project).
#'
#' @param orcid a `character` of length 1. The ORCID of the user
#'   (considered as the maintainer and code owner of the project).
#'
#' @param github_user a `character` of length 1. The GitHub account name of the
#'   user (considered as the maintainer and code owner of the project).
#'
#' @param protocol a `character` of length 1. The GIT protocol used to
#'   communicate with GitHub. One of `'https'` or `'ssh'`. If you
#'   don't know, keep the default value (i.e. `https`).
#'
#' @param open a `logical` value. If `TRUE` (default) the `.Rprofile` is opened
#'   in the default text editor (recommended).
#'
#' @return No return value.
#'
#' @export
#'
#' @family setup functions
#'
#' @examples
#' \dontrun{
#' set_credentials(
#'   given = "John",
#'   family = "Doe",
#'   email = "john.doe@domain.com",
#'   orcid = "9999-9999-9999-9999",
#'   github_user = "jdoe",
#'   protocol = "https",
#'   open = TRUE
#' )
#' }

set_credentials <- function(
  given = NULL,
  family = NULL,
  email = NULL,
  orcid = NULL,
  github_user = NULL,
  protocol = "https",
  open = TRUE
) {
  credentials <- as.list(match.call())[-1]

  assert_valid_credentials(credentials)
  assert_valid_git_protocol(credentials)

  if (should_edit_r_profile(credentials)) {
    credentials <- set_default_git_protocol(credentials)

    content <- create_r_profile_content(credentials)

    ui_r_profile_content(content)
  }

  r_profile <- create_r_profile_if_needed()
  open_file_if_needed(r_profile, open)

  invisible(r_profile)
}
