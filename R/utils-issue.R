#' Error if the Issue Template name if not available
#' @param name a character of length of 1. The name of the Issue Template.
#' @noRd
stop_if_invalid_issue_template_name <- function(name) {
  available_issues <- get_available_issue_templates()

  if (!(name %in% available_issues)) {
    stop(
      paste0(
        "The issue template '",
        name,
        "' is not available. Please run ",
        "`get_available_issue_templates()` to list available Issue Templates."
      )
    )
  }

  invisible(NULL)
}
