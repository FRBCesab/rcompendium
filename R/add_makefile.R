#' Create a Make-like R file
#'
#' @description
#' This function creates a Make-like R file (`make.R`) at the root of the
#' project based on a template. To be used only if the project is a research
#' compendium. The content of this file provides some guidelines. See also
#' [new_compendium()] for further information.
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
  stop_if_not_logical(open, overwrite, quiet)

  full_path <- build_full_path("make.R")
  rel_path <- build_rel_path("make.R")

  assert_file_not_exists_or_overwrite(rel_path, overwrite)

  meta <- resolve_project_meta(
    given = given,
    family = family,
    email = email
  )

  stop_if_null_or_empty(meta$given, "given")
  stop_if_null_or_empty(meta$family, "family")
  stop_if_null_or_empty(meta$email, "email")

  if (should_create_file(full_path, overwrite)) {
    ensure_dir_exists(dirname(full_path))

    create_template("others/make.R", rel_path, meta)

    ui_file_written(rel_path, quiet)
  }

  open_file_if_needed(full_path, open)

  invisible(NULL)
}
