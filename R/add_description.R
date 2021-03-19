#' Create a DESCRIPTION file
#' 
#' @description 
#' This function creates a `DESCRIPTION` file at the root of the project based  
#' on a template (adapted from [`usethis`](https://usethis.r-lib.org)). User 
#' credentials can be passed as arguments but it is recommended to store them 
#' in the `.Rprofile` file with [set_credentials()].
#' 
#' @param organisation a character of length 1
#' 
#'   The name of the GitHub organisation to host the package. If `NULL` 
#'   (default) the GitHub account will be used.
#'   
#' @param open a logical value
#' 
#'   If `TRUE` (default) the file is opened in the editor.
#' 
#' @param overwrite a logical value
#' 
#'   If a `DESCRIPTION` is already present and `overwrite = TRUE`, this file 
#'   will be erased and replaced. Default is `FALSE`.
#'   
#' @param quiet a logical value
#' 
#'   If `TRUE` messages are deleted. Default is `FALSE`.
#' 
#' @inheritParams set_credentials
#' 
#' @return None
#'
#' @export
#' 
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_description(organisation = "MySociety")
#' }

add_description <- function(given = NULL, family = NULL, email = NULL, 
                            orcid = NULL, organisation = NULL, open = TRUE, 
                            overwrite = FALSE, quiet = FALSE) {
  
  
  stop_if_not_logical(open, overwrite, quiet)
  
  
  path <- file.path(path_proj(), "DESCRIPTION")
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
      
    if (!open) {
      
      stop("A 'DESCRIPTION' file is already present. If you want to ",
           "replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  

 ## Get fields values ----
    
  if (is.null(given))  given  <- getOption("given")
  if (is.null(family)) family <- getOption("family")
  if (is.null(email))  email  <- getOption("email")
  if (is.null(orcid))  orcid  <- getOption("orcid")
  
  if (!is.null(organisation)) {
    
    github <- organisation
    
  } else {
    
    github <- gh::gh_whoami()$"login"
    
    if (is.null(github)) {
      stop("Unable to find GitHub username. Please run ", 
           "`?gert::git_config_global` for more information.")
    }
  }
  
  
  stop_if_not_string(given, family, email, github)
  
  if (!is.null(orcid)) stop_if_not_string(orcid)
    
  
  project_name     <- get_package_name()
  roxygen2_version <- get_roxygen2_version()
  
  
  ## Copy Template ----
  
  invisible(
    file.copy(system.file(file.path("templates", "__DESCRIPTION__"), 
                          package = "rcompendium"), path, overwrite = TRUE))
  
  
  ## Change default values (in file) ----
  
  xfun::gsub_file(path, "{{project_name}}", project_name, fixed = TRUE)
  xfun::gsub_file(path, "{{roxygen2_version}}", roxygen2_version, fixed = TRUE)
  xfun::gsub_file(path, "{{given}}", given, fixed = TRUE)
  xfun::gsub_file(path, "{{family}}", family, fixed = TRUE)
  xfun::gsub_file(path, "{{email}}", email, fixed = TRUE)
  xfun::gsub_file(path, "{{github}}", github, fixed = TRUE)
  
  if (!is.null(orcid)) xfun::gsub_file(path, "{{orcid}}", orcid, fixed = TRUE)
  
  
  ## Message ----
  
  if (!quiet) ui_done("Writing {ui_value('DESCRIPTION')} file")

  if (open) edit_file(path)
  
  invisible(NULL)
}
