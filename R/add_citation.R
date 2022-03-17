#' Create a CITATION file
#' 
#' @description 
#' This function creates a `CITATION` file in the folder `inst/`. This file
#' contains a BiBTeX entry to cite the package as a manual. User will need to
#' edit by hand some information (title, version, etc.).
#' 
#' @param organisation A character of length 1. The name of the GitHub 
#'   organisation to host the package. If `NULL` (default) the GitHub account 
#'   will be used. This argument is used to set the URL of the package 
#'   (hosted on GitHub).
#'   
#' @param open A logical value. If `TRUE` (default) the file is opened in the 
#'   editor.
#' 
#' @param overwrite A logical value. If this file is already present and 
#'   `overwrite = TRUE`, it will be erased and replaced. Default is `FALSE`.
#'   
#' @param quiet A logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#' 
#' @inheritParams set_credentials
#' 
#' @return No return value.
#' 
#' @export
#' 
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_citation()
#' readCitationFile("inst/CITATION")
#' citation("pkg")    # If you have installed your package <pkg>
#' }

add_citation <- function(given = NULL, family = NULL, organisation = NULL, 
                         open = TRUE, overwrite = FALSE, quiet = FALSE) { 
  
  
  stop_if_not_logical(open, overwrite, quiet)
  
  path <- file.path(path_proj(), "inst", "CITATION")
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
    
    if (!open) {
      
      stop("An 'inst/CITATION' file is already present. If you want to ",
           "replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  
  
  ## Get fields values ----
    
  if (is.null(given))  given  <- getOption("given")
  if (is.null(family)) family <- getOption("family")
  
  if (!is.null(organisation)) {
    
    github <- organisation
    
  } else {
    
    github <- gh::gh_whoami()$"login"
    
    if (is.null(github)) {
      stop("Unable to find GitHub username. Please run ", 
           "`?gert::git_config_global` for more information.")
    }
  }
  
  stop_if_not_string(given, family, github)
  
  
  project_name <- get_package_name()
  pkg_version  <- get_package_version()
  year         <- format(Sys.Date(), "%Y")
  
  
  ## Copy Template ----

  if (!dir.exists(file.path(path_proj(), "inst")))
    dir.create(file.path(path_proj(), "inst"), showWarnings = FALSE)

  invisible(
    file.copy(system.file(file.path("templates", "citation"), 
                          package = "rcompendium"), path, overwrite = TRUE))


  ## Change defaults values ----

  xfun::gsub_file(path, "{{project_name}}", project_name, fixed = TRUE)
  xfun::gsub_file(path, "{{pkg_version}}", pkg_version, fixed = TRUE)
  xfun::gsub_file(path, "{{year}}", year, fixed = TRUE)
  xfun::gsub_file(path, "{{given}}", given, fixed = TRUE)
  xfun::gsub_file(path, "{{family}}", family, fixed = TRUE)
  xfun::gsub_file(path, "{{github}}", github, fixed = TRUE)
  
  
  ## Messages ----
  
  if (!quiet) ui_done("Writing {ui_value('inst/CITATION')} file")
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
