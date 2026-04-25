#' List available GitHub Actions
#'
#' @description
#' This function returns a list of the name of all available GitHub Actions.
#' This is particularly useful to get the right spelling of the GitHub Action
#' to be passed to [add_github_action()].
#'
#' @return A `character` vector with the name of the available GitHub Actions in
#' `rcompendium`.
#'
#' @export
#'
#' @family utilities functions
#'
#' @examples
#' get_available_gh_actions()

get_available_gh_actions <- function() {
  actions <- list_template_gh_repo_content("actions")
  actions <- actions[-which(actions == "dependabot.yaml")]
  gsub("\\.(yaml|yml)$", "", actions)
}
