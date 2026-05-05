#' Add a DESCRIPTION file
#'
#' @description
#' This function creates a `DESCRIPTION` file at the root of the project. This
#' file contains metadata of the project. Some information (title, description,
#' version, etc.) must be edited by hand. For more information:
#' \url{https://r-pkgs.org/description.html}.
#' User credentials can be passed as arguments but it is recommended to store
#' them in the `.Rprofile` file of the project with [set_credentials()].
#'
#' @inheritParams add_citation
#' @inheritParams set_credentials
#'
#' @return No return value.
#'
#' @export
#'
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_description(organisation = "MySociety")
#' }

add_description <- function(
  given = NULL,
  family = NULL,
  email = NULL,
  orcid = NULL,
  organisation = NULL,
  open = TRUE,
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_project()

  stop_if_not_logical(open)
  stop_if_not_logical(overwrite)
  stop_if_not_logical(quiet)

  path <- build_abs_path("DESCRIPTION")

  stop_if_file_exists(path, overwrite)

  meta <- resolve_project_meta(
    given = given,
    family = family,
    email = email,
    orcid = orcid,
    organisation = organisation
  )

  stop_if_not_string(meta$given)
  stop_if_not_string(meta$family)
  stop_if_not_string(meta$email)

  if (should_create_file(path, overwrite)) {
    create_folder_if_needed(dirname(path))

    create_template("package/DESCRIPTION", path, meta)

    ui_file_written(path, quiet)
  }

  open_file_if_needed(path, open)

  invisible(NULL)
}
