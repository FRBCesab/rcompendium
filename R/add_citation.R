#' Create a CITATION file
#'
#' @description
#' This function creates a `CITATION` file in the folder `inst/`. This file
#' contains a BiBTeX entry to cite the package as a manual. User will need to
#' edit by hand some information (title, version, etc.).
#'
#' @param organisation A character of length 1. The name of the GitHub
#'   organisation to host the package. If `NULL` (default) the GitHub account
#'   will be used. This argument is used to set the URL of the package
#'   (hosted on GitHub).
#'
#' @param open A logical value. If `TRUE` (default) the file is opened in the
#'   editor.
#'
#' @param overwrite A logical value. If this file is already present and
#'   `overwrite = TRUE`, it will be erased and replaced. Default is `FALSE`.
#'
#' @param quiet A logical value. If `TRUE` messages are deleted. Default is
#'   `FALSE`.
#'
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
#' add_citation()
#' readCitationFile("inst/CITATION")
#' }

add_citation <- function(
  given = NULL,
  family = NULL,
  organisation = NULL,
  open = TRUE,
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_project()

  stop_if_not_logical(open)
  stop_if_not_logical(overwrite)
  stop_if_not_logical(quiet)

  path <- build_abs_path("inst", "CITATION")

  stop_if_file_exists(path, overwrite)

  meta <- resolve_project_meta(
    given = given,
    family = family,
    organisation = organisation
  )

  stop_if_not_string(meta$given)
  stop_if_not_string(meta$family)

  if (should_create_file(path, overwrite)) {
    create_folder_if_needed(dirname(path))

    create_template("package/CITATION", path, meta)

    ui_file_written(path, quiet)
  }

  open_file_if_needed(path, open)

  invisible(NULL)
}
