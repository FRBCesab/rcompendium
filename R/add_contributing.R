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

  stop_if_not_logical(open)
  stop_if_not_logical(overwrite)
  stop_if_not_logical(quiet)

  path <- build_abs_path("CONTRIBUTING.md")

  stop_if_file_exists(path, overwrite)

  meta <- resolve_project_meta(
    email = email,
    organisation = organisation
  )

  stop_if_not_string(meta$email)

  if (should_create_file(path, overwrite)) {
    create_folder_if_needed(dirname(path))

    create_template("contributing/CONTRIBUTING.md", path, meta)

    ui_file_written(path, quiet)

    add_to_buildignore("CONTRIBUTING.md", quiet = quiet)
  }

  open_file_if_needed(path, open)

  invisible(NULL)

  # template_names <- c("bug_report.md", "feature_request.md", "other_issue.md")

  # for (template_name in template_names) {
  #   path_issue <- build_abs_path(
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
  #     outdir = build_abs_path(".github", "ISSUE_TEMPLATE")
  #   )

  #   if (!quiet) {
  #     ui_done(paste0("Writing {ui_value('", path_issue_msg, "')} file"))
  #   }
  # }
}
