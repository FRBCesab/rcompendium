#' Add a CODE OF CONDUCT file
#'
#' @description
#' This function creates a `CODE_OF_CONDUCT.md` file adapted from the
#' Contributor Covenant, version 2.1 available at
#' \url{https://www.contributor-covenant.org/version/2/1/code_of_conduct.html}.
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
#' add_code_of_conduct()
#' }

add_code_of_conduct <- function(
  email = NULL,
  open = TRUE,
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_project()
  stop_if_not_logical(open, overwrite, quiet)

  full_path <- build_full_path("CODE_OF_CONDUCT.md")
  rel_path <- build_rel_path("CODE_OF_CONDUCT.md")

  assert_file_not_exists_or_overwrite(rel_path, overwrite)

  meta <- resolve_project_meta(
    email = email
  )

  stop_if_null_or_empty(meta$email, "email")

  if (should_create_file(full_path, overwrite)) {
    ensure_dir_exists(dirname(full_path))

    create_code_of_conduct_template(rel_path, meta)

    ui_file_written(rel_path, quiet)

    add_to_buildignore("CODE_OF_CONDUCT.md", quiet = quiet)
  }

  open_file_if_needed(full_path, open)

  invisible(NULL)
}
