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
  stop_if_not_logical(open, overwrite, quiet)

  full_path <- build_full_path("inst", "CITATION")
  rel_path <- build_rel_path("inst", "CITATION")

  assert_file_not_exists_or_overwrite(rel_path, overwrite)

  meta <- resolve_project_meta(
    given = given,
    family = family,
    organisation = organisation
  )

  if (should_create_file(full_path, overwrite)) {
    ensure_dir_exists(dirname(full_path))

    create_citation_template(rel_path, meta)

    ui_file_written(rel_path, quiet)
  }

  open_file_if_needed(full_path, open)

  invisible(NULL)
}
