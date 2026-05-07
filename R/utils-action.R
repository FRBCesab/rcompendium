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
