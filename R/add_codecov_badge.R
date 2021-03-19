#' Add a Codecov badge
#'
#' @description 
#' This function adds a Codecov badge to the `README.Rmd`, i.e. the percentage
#' of code cover by units tests. This percentage is computed by codecov.io
#' service.
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
#' add_codecov_badge()
#' }

add_codecov_badge <- function(organisation = NULL, quiet = FALSE) {
  
  
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
  
  alt  <- "codecov"
  href <- paste0("https://codecov.io/gh/", github,"/", project_name)
  img  <- paste0("https://codecov.io/gh/", github,"/", project_name,
                 "/branch/", gert::git_branch(), "/graph/badge.svg")
  
  badge <- paste0("[![", alt, "](", img, ")](", href, ")")
  
  
  ## Add Badge ----
  
  add_badge(badge, pattern = alt)
  
  
  if (!quiet) {
    ui_done(paste0("Adding {ui_field('codecov')} badge to ", 
                   "{ui_value('README.Rmd')}"))
  }
  
  invisible(badge)
}
