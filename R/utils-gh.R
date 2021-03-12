## Utilities functions - GITHUB ----



#' **Check if project is versioned**
#' 
#' @noRd

is_git <- function() dir.exists(file.path(path_proj(), ".git"))



#' **Update GitHub Repository Informations**
#' 
#' @description
#' This function:
#' * adds DESCRIPTION `Title` to GitHub Repository description field;
#' * adds a `:package:` EMOJI before GitHub Repository description field;
#' * adds Website URL to GitHub Repository homepage field.
#' 
#' @param owner a character of length 1. GitHub owner/organisation where the 
#'   package is hosted.
#'   
#' @param repo a character of length 1. GitHub repository name. Must exist.
#' 
#' @param website a logical value. If `TRUE` (default) adds the website URL to 
#'   GitHub Repository homepage field (if the website was deployed using 
#'   [pkgdown::pkgdown()]).
#'   
#' @param quiet a logical value. If `TRUE` messages are deleted. 
#'   Default is `FALSE`.
#' 
#' @noRd

update_gh_repo <- function(owner, repo, website = TRUE, quiet = FALSE) {
  
  
  is_package()
  
  stop_if_not_logical(website, quiet)
  
  
  ## Checks inputs ----
  
  if (missing(owner)) stop("Argument 'owner' is missing.")
  if (missing(repo))  stop("Argument 'repo' is missing.")
  
  stop_if_not_string(owner, repo)
  
  
  ## Is GITHUB PAT ----
  
  if (gh::gh_token() == "") {
    stop("No GITHUB PAT found. Please run `usethis::gh_token_help()` for ", 
         "further information or read the vignette.")
  }
  
  
  ## Is repo exists ----
  
  github_url <- paste0("https://", "github.com/", owner, "/", repo)
  
  repo_infos <- tryCatch(gh::gh("GET /repos/{owner}/{repo}", repo = repo, 
                                owner = owner), error = function(e) NULL)
  
  if (is.null(repo_infos)) 
    stop("Repository < ", github_url, " > does not exist.")
  
  
  ## Update GitHub Repository Description ----
  
  description <- repo_infos$"description"
  
  if (!is.null(description)) {
    
    if (!length(grep(":package: ", description))) {
      
      description <- paste0(":package: ", description)
      
      invisible(gh::gh("PATCH /repos/{owner}/{repo}", repo = repo, 
                       owner = owner, description = description))
      
      if (!quiet) 
        ui_done("Updating GitHub Repository {ui_value('Description')} field")
    }
  
  } else {
    
    description <- paste0(":package: ", read_descr()$"Title")
    
    invisible(gh::gh("PATCH /repos/{owner}/{repo}", repo = repo, 
                     owner = owner, description = description))
    
    if (!quiet) 
      ui_done("Updating GitHub Repository {ui_value('Description')} field")
  }
  
  
  ## Update GitHub Repository Homepage ----
  
  if (website) {
    
    homepage <- repo_infos$"homepage"
    
    if (is.null(homepage)) {
      
      homepage <- tolower(paste0("https://", owner, ".github.io/", repo))
      
      invisible(gh::gh("PATCH /repos/{owner}/{repo}", repo = repo,
                       owner = owner, homepage = homepage))
      
      if (!quiet) 
        ui_done("Updating GitHub Repository {ui_value('Homepage')} field")
    }
  }
  
  invisible(NULL)
}



#' **Check if GitHub account exist (stored with git_global)**
#' 
#' @noRd

is_gh_user <- function() {
  
  if (is.null(tryCatch(gh::gh("GET /user"), error = function(e) NULL))) {
    stop("Your GitHub account does not exist.")
  }
  
  invisible(NULL)
}



#' **Check if a GitHub organisation exist**
#' 
#' @noRd

is_gh_organisation <- function(organisation) {
  
  
  if (missing(organisation)) stop("Argument 'organisation' is missing.")
  
  stop_if_not_string(organisation)
  
  if (is.null(tryCatch(gh::gh("GET /orgs/{org}", org = organisation), 
                       error = function(e) NULL))) {
    stop("The GitHub organisation < ", organisation, " > does not exist.")
  }
  
  invisible(NULL)
}



#' **Check if GitHub repository exists**
#' 
#' @noRd

is_gh_repo <- function(owner, repo) {
  
  
  if (missing(owner)) stop("Argument 'owner' is missing.")
  if (missing(repo))  stop("Argument 'repo' is missing.")
  
  stop_if_not_string(owner, repo)
  
  tryCatch(gh::gh("GET /repos/{owner}/{repo}", repo = repo, 
                  owner = owner), error = function(e) NULL)
}
