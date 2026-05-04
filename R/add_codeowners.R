#' Create a CODEOWNERS file
#'
#' @description
#' This function creates a `CODEOWNERS` file in the folder `.github/`. This
#' file is used to define individual that is responsible for code in the
#' repository.
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
#' add_codeowners()
#' }

add_codeowners <- function(
  github_user = NULL,
  open = FALSE,
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_project()

  stop_if_not_logical(open)
  stop_if_not_logical(overwrite)
  stop_if_not_logical(quiet)

  path <- build_abs_path(".github", "CODEOWNERS")

  assert_file_not_exists_or_overwrite(path, overwrite)

  meta <- resolve_project_meta(
    github_user = github_user
  )

  stop_if_not_string(meta$github_user)

  if (should_create_file(path, overwrite)) {
    ensure_dir_exists(dirname(path))

    writeLines(
      text = paste0("* @", meta$github_user),
      con = path
    )

    ui_file_written(path, quiet)

    add_to_buildignore(".github", quiet = quiet)
  }

  open_file_if_needed(path, open)

  invisible(NULL)
}
