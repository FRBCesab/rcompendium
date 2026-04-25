#' Add a CONTRIBUTING file
#'
#' @description
#' This function creates a `CONTRIBUTING.md` file providing general guidelines
#' outlining the best way to contribute to the project (need to be adapted).
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
#' add_contributing()
#' }

add_contributing <- function(
  email = NULL,
  organisation = NULL,
  open = TRUE,
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_project()
  stop_if_not_logical(open, overwrite, quiet)

  rel_path <- build_rel_path("CONTRIBUTING.md")
  full_path <- build_full_path(rel_path)

  assert_file_not_exists_or_overwrite(rel_path, overwrite)

  meta <- resolve_project_meta(
    email = email,
    organisation = organisation
  )

  stop_if_null_or_empty(meta$email, "email")

  if (should_create_file(full_path, overwrite)) {
    ensure_dir_exists(dirname(full_path))

    create_template("contributing/CONTRIBUTING.md", rel_path, meta)

    ui_file_written(rel_path, quiet)

    add_to_buildignore("CONTRIBUTING.md", quiet = quiet)
  }

  open_file_if_needed(full_path, open)

  invisible(NULL)

  # template_names <- c("bug_report.md", "feature_request.md", "other_issue.md")

  # for (template_name in template_names) {
  #   path_issue <- file.path(
  #     path_proj(),
  #     ".github",
  #     "ISSUE_TEMPLATE",
  #     template_name
  #   )

  #   path_issue_msg <- file.path(".github", "ISSUE_TEMPLATE", template_name)

  #   if (file.exists(path_issue) && !overwrite) {
  #     stop(paste0(
  #       "A '",
  #       path_issue_msg,
  #       "' file is already present. If you ",
  #       "want to replace it, please use `overwrite = TRUE`."
  #     ))
  #   }

  #   download_template(
  #     slug = paste0("issues/", template_name),
  #     filename = template_name,
  #     outdir = file.path(path_proj(), ".github", "ISSUE_TEMPLATE")
  #   )

  #   if (!quiet) {
  #     ui_done(paste0("Writing {ui_value('", path_issue_msg, "')} file"))
  #   }
  # }
}
