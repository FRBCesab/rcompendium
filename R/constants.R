#' Blocks used to organise metadata
#' @noRd
.DEFAULT_BLOCKS <- c("user", "project", "git", "runtime")

#' Version of the GitHub API
#' @noRd
.GITHUB_API_VERSION <- "2022-11-28"

#' URL of the GitHub API
#' @noRd
.GITHUB_API_URL <- "https://api.github.com"

#' Endpoint of the GitHub API
#' @noRd
.GITHUB_API_ENDPOINT <- "/repos/frbcesab/r-templates/contents/"

#' URL to access raw file on GH repo
#' @noRd
.TEMPLATE_FILE_URL <- paste0(
  "https://raw.githubusercontent.com/FRBCesab/",
  "r-templates/refs/heads/main/"
)
