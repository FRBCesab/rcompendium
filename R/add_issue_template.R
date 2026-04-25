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
  stop_if_not_string(name)
  stop_if_not_logical(open, overwrite, quiet)

  assert_valid_issue_template_name(name)

  rel_path <- build_rel_path(".github", "ISSUE_TEMPLATE", paste0(name, ".md"))
  full_path <- build_full_path(rel_path)

  assert_file_not_exists_or_overwrite(rel_path, overwrite)

  meta <- resolve_project_meta()

  if (should_create_file(full_path, overwrite)) {
    ensure_dir_exists(dirname(full_path))

    create_template(paste0("issues/", basename(rel_path)), rel_path, meta)

    ui_file_written(rel_path, quiet)
    add_to_buildignore(".github", quiet = quiet)
  }

  open_file_if_needed(full_path, open)

  invisible(NULL)
}
