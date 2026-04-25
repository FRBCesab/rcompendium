#' List available ISSUE TEMPLATE
#'
#' @description
#' This function returns a list of the name of all available Issue Templates.
#' This is particularly useful to get the right spelling of the Issue Templates
#' to be passed to [add_issue_template()].
#'
#' @return A `character` vector with the name of the available Issue Templates
#' in `rcompendium`.
#'
#' @export
#'
#' @family utilities functions
#'
#' @examples
#' get_available_issue_templates()

get_available_issue_templates <- function() {
  issues <- list_repo_content("issues")
  gsub("\\.(yaml|yml)$", "", issues)
}
