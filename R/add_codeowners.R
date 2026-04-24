#' Create a CODEOWNERS file
#'
#' @description
#' This function creates a `CODEOWNERS` file in the folder `.github/`. This
#' file is used to define individual that is responsible for code in the
#' repository.
#'
#' @inheritParams add_citation
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
  open = FALSE,
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_project()
  stop_if_not_logical(open, overwrite, quiet)

  full_path <- build_full_path(".github", "CODEOWNERS")
  rel_path <- build_rel_path(".github", "CODEOWNERS")

  assert_file_not_exists_or_overwrite(rel_path, overwrite)

  meta <- resolve_project_meta()

  if (should_create_file(full_path, overwrite)) {
    ensure_dir_exists(dirname(full_path))

    writeLines(
      text = paste0("* @", get_github_user()),
      con = full_path
    )

    ui_file_written(rel_path, quiet)

    add_to_buildignore(".github", quiet = quiet)
  }

  open_file_if_needed(full_path, open)

  invisible(NULL)
}
