#' Set up an Issue Template file
#'
#' @description
#' This function creates an Issue template file (`md`) in the directory
#' `.github/ISSUE_TEMPLATE`. These files preformat a GitHub Issue. Contributors
#' can use these templates when they open new issues. For instance, you can
#' format issue related to bug report, feature request, etc.
#'
#' @param name A character of length 1. The name of the Issue Template to add.
#'   Run [get_available_issue_templates()] to list available Issue Templates.
#'
#' @inheritParams add_citation
#' @inheritParams set_credentials
#'
#' @return No return value.
#'
#' @export
#'
#' @family development functions
#'
#' @examples
#' \dontrun{
#' add_issue_template(name = "feature_request")
#' }

add_issue_template <- function(
  name,
  open = FALSE,
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_project()

  stop_if_not_logical(open)
  stop_if_not_logical(overwrite)
  stop_if_not_logical(quiet)

  stop_if_not_string(name)
  assert_valid_issue_template_name(name)

  path <- build_abs_path(".github", "ISSUE_TEMPLATE", paste0(name, ".md"))

  assert_file_not_exists_or_overwrite(path, overwrite)

  meta <- resolve_project_meta()

  if (should_create_file(path, overwrite)) {
    ensure_dir_exists(dirname(path))

    create_template(paste0("issues/", basename(path)), path, meta)

    ui_file_written(path, quiet)
    add_to_buildignore(".github", quiet = quiet)
  }

  open_file_if_needed(path, open)

  invisible(NULL)
}
