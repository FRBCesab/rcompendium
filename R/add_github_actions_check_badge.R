#' Add a R-CMD-CHECK badge
#'
#' @description 
#' This function adds a R-CMD-CHECK badge to the `README.Rmd`. This function
#' must be run after [add_github_actions_check()] which will setup GitHub 
#' Actions (checks and tests).
#' 
#' @param github user GitHub account where the project is hosted. If `NULL` 
#'   (default) the function will try to get this value by reading the 
#'   `.Rprofile` file (unless `!is.null(organisation)`). 
#' 
#' @param organisation (alternative) name of the GitHub organisation where the 
#'   project is hosted.  If `NULL` (default) the GitHub account `github` will 
#'   be used.
#' 
#' @param quiet a logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#'   
#' @export
#' 
#' @family adding badges
#'
#' @examples
#' \dontrun{
#' add_github_actions_badge()
#' }

add_github_actions_check_badge <- function(github = NULL, organisation = NULL, 
                                     quiet = FALSE) {
  
  
  stop_if_not_logical(quiet)
  
  ## Check if GH Actions are set ----
  
  if (!file.exists(file.path(path_proj(), ".github", "workflows", 
                             "R-CMD-check.yaml"))) {
    stop("Please run `add_github_actions_check()` to setup GitHub Actions.")
  }
  
  
  ## Retrieve GitHub pseudo/organization ----
  
  if (!is.null(organisation)) {
    github <- organisation
  } else {
    if (is.null(github)) github <- getOption("github")  
  }
  
  stop_if_not_string(github)
  
  
  ## Check URL ----
  
  is_gh_user()
  
  project_name <- get_package_name()
  
  
  ## Create Badge Markdown Expression ----
  
  alt  <- "R CMD Check"
  href <- paste("https://github.com", github, project_name, 
                "actions/workflows/R-CMD-check.yaml", sep = "/")
  img  <- paste("https://github.com", github, project_name, 
                "actions/workflows/R-CMD-check.yaml/badge.svg", sep = "/")
  
  badge <- paste0("[![", alt, "](", img, ")](", href, ")")
  
  
  ## Add Badge ----
  
  add_badge(badge, pattern = alt)
  
  if (!quiet) {
    ui_done(paste0("Adding {ui_field('R-CMD-check')} badge to ", 
                   "{ui_value('README.Rmd')}"))
  }
  
  
  invisible(badge)
}
