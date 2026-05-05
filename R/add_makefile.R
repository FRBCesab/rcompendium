#' Create a Make-like R file
#'
#' @description
#' This function creates a Make-like R file (`make.R`) at the root of the
#' project based on a template. To be used only if the project is a research
#' compendium. The content of this file provides some guidelines. See also
#' [create_new_compendium()] for further information.
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
#' add_makefile()
#' }

add_makefile <- function(
  given = NULL,
  family = NULL,
  email = NULL,
  open = TRUE,
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_project()

  stop_if_not_logical(open)
  stop_if_not_logical(overwrite)
  stop_if_not_logical(quiet)

  path <- build_abs_path("make.R")

  stop_if_file_exists(path, overwrite)

  meta <- resolve_project_meta(
    given = given,
    family = family,
    email = email
  )

  stop_if_not_string(meta$given)
  stop_if_not_string(meta$family)
  stop_if_not_string(meta$email)

  if (should_create_file(path, overwrite)) {
    create_folder_if_needed(dirname(path))

    create_template("others/make.R", path, meta)

    ui_file_written(path, quiet)
  }

  open_file_if_needed(path, open)

  invisible(NULL)
}
