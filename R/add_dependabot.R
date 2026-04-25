#' Add a DEPENDABOT file
#'
#' @description
#' This function creates a `dependabot.yaml` file (configuration file) in the
#' `.github/` directory. This GitHub Action will be triggered once a week to
#' check for dependency updates (used by any GitHub Action of the repository).
#' If an update is available, this bot will open a Pull Request and user will
#' be invited to review changes.
#'
#' This function is called by [add_github_action()] to automatically create
#' this configuration file if any GitHub Action is used.
#'
#' @inheritParams add_citation
#'
#' @return No return value.
#'
#' @export
#'
#' @family development functions
#'
#' @examples
#' \dontrun{
#' add_dependabot()
#' }

add_dependabot <- function(
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_project()
  stop_if_not_logical(overwrite, quiet)

  full_path <- build_full_path(".github", "dependabot.yaml")
  rel_path <- build_rel_path(".github", "dependabot.yaml")

  meta <- resolve_project_meta()

  if (should_create_file(full_path, overwrite)) {
    ensure_dir_exists(dirname(full_path))

    create_template(paste0("actions/", basename(rel_path)), rel_path, meta)

    ui_file_written(rel_path, quiet)
    add_to_buildignore(".github", quiet = quiet)
  }

  invisible(NULL)
}
