#' Add a Test coverage badge
#'
#' @description 
#' This function adds a Test coverage badge to the `README.Rmd`. This function
#' must be run after [add_github_actions_codecov()] which will setup GitHub 
#' Actions to report the percentage of code cover by units tests.
#' 
#' @param organisation a character of length 1
#' 
#'   The name of the GitHub organisation to host the package. If `NULL` 
#'   (default) the GitHub account will be used.
#' 
#' @param quiet a logical value
#' 
#'   If `TRUE` messages are deleted. Default is `FALSE`.
#' 
#' @return A Markdown badge expression
#'
#' @export
#' 
#' @family adding badges
#'
#' @examples
#' \dontrun{
#' add_github_actions_codecov_badge()
#' }

add_github_actions_codecov_badge <- function(organisation = NULL, 
                                             quiet = FALSE) {
  
  
  stop_if_not_logical(quiet)
  
  ## Check if GH Actions are set ----
  
  if (!file.exists(file.path(path_proj(), ".github", "workflows", 
                             "test-coverage.yaml"))) {
    stop("Please run `add_github_actions_codecov()` to setup GitHub Actions.")
  }
  
  
  ## Retrieve GitHub pseudo/organization ----
  
  if (!is.null(organisation)) {
    
    github <- organisation
    
  } else {
    
    github <- gh::gh_whoami()$"login"
    
    if (is.null(github)) {
      stop("Unable to find GitHub username. Please run ", 
           "`?gert::git_config_global` for more information.")
    }
  }
  
  
  stop_if_not_string(github)
  
  
  ## Check URL ----
  
  is_gh_user()
  
  project_name <- get_package_name()
  
  
  ## Create Badge Markdown Expression ----
  
  alt  <- "Test coverage"
  href <- paste("https://github.com", github, project_name, 
                "actions/workflows/test-coverage.yaml", sep = "/")
  img  <- paste("https://github.com", github, project_name, 
                "actions/workflows/test-coverage.yaml/badge.svg", sep = "/")
  
  badge <- paste0("[![", alt, "](", img, ")](", href, ")")
  
  
  ## Add Badge ----
  
  add_badge(badge, pattern = alt)
  
  if (!quiet) {
    ui_done(paste0("Adding {ui_field('Test coverage')} badge to ", 
                   "{ui_value('README.Rmd')}"))
  }
  
  
  invisible(badge)
}
