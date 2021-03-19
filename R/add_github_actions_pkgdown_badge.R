#' Add a Website deployment badge
#'
#' @description 
#' This function adds a Website deployment badge to the `README.Rmd`. This 
#' function must be run after [add_github_actions_pkgdown()] which will setup 
#' GitHub Actions to build and deploy package website.
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
#' add_github_actions_pkgdown_badge()
#' }

add_github_actions_pkgdown_badge <- function(organisation = NULL, 
                                             quiet = FALSE) {
  
  
  stop_if_not_logical(quiet)
  
  ## Check if GH Actions are set ----
  
  if (!file.exists(file.path(path_proj(), ".github", "workflows", 
                             "pkgdown.yaml"))) {
    stop("Please run `add_github_actions_pkgdown()` to setup GitHub Actions.")
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
  
  alt  <- "Website deployment"
  href <- paste("https://github.com", github, project_name, 
                "actions/workflows/pkgdown.yaml", sep = "/")
  img  <- paste("https://github.com", github, project_name, 
                "actions/workflows/pkgdown.yaml/badge.svg", sep = "/")
  
  badge <- paste0("[![", alt, "](", img, ")](", href, ")")
  
  
  ## Add Badge ----
  
  add_badge(badge, pattern = alt)
  
  if (!quiet) {
    ui_done(paste0("Adding {ui_field('Website deployment')} badge to ", 
                   "{ui_value('README.Rmd')}"))
  }
  
  
  invisible(badge)
}
