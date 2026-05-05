#' Error if the GH Action name if not available
#' @param name a character of length of 1. The name of the GH Action.
#' @noRd
stop_if_invalid_gh_action_name <- function(name) {
  available_actions <- get_available_gh_actions()

  if (!(name %in% available_actions)) {
    stop(
      paste0(
        "The action '",
        name,
        "' is not available. Please run ",
        "`get_available_gh_actions()` to list available GitHub Actions."
      )
    )
  }

  invisible(NULL)
}


#' List templates of a directory
#' @param directory a character of length of 1. The name of the GH directory.
#' @noRd
list_template_files <- function(directory = NULL) {
  content <- gh::gh(
    endpoint = paste0(get_template_repo_url(), directory),
    .send_headers = c(
      `Accept` = "application/vnd.github.raw+json",
      `Content-Type` = "application/json"
    )
  )

  unlist(lapply(content, function(x) x[["name"]]))
}
