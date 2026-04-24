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
  stop_if_not_logical(open, overwrite, quiet)

  full_path <- build_full_path("DESCRIPTION")
  rel_path <- build_rel_path("DESCRIPTION")

  assert_file_not_exists_or_overwrite(rel_path, overwrite)

  meta <- resolve_project_meta(
    given = given,
    family = family,
    email = email,
    orcid = orcid,
    organisation = organisation
  )

  stop_if_null_or_empty(meta$given, "given")
  stop_if_null_or_empty(meta$family, "family")
  stop_if_null_or_empty(meta$email, "email")

  if (should_create_file(full_path, overwrite)) {
    ensure_dir_exists(dirname(full_path))

    create_template("package/DESCRIPTION", rel_path, meta)

    ui_file_written(rel_path, quiet)
  }

  open_file_if_needed(full_path, open)

  invisible(NULL)
}
