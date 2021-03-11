#' Setup GitHub Actions to check and test package
#' 
#' @description 
#' This function creates a configuration file (`.yaml`) to setup GitHub Actions 
#' to check and test the package. This file will be added (from a template)
#' in the folder `.github/workflows/R-CMD-check.yaml`.
#' 
#' @param open a logical value. If `TRUE` the file is opened in the editor.
#'   Default is `FALSE`.
#' 
#' @param overwrite a logical value. If this file already exists and 
#'   `overwrite = TRUE`, its content will be erased.
#' 
#' @param quiet a logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#'   
#' @details 
#' This workflow runs `R CMD check` on the three major operating systems
#' (Ubuntu, macOS, and Windows) on the latest release of R.
#' 
#' @export
#' 
#' @family development functions
#'
#' @examples
#' \dontrun{
#' add_github_actions_check()
#' }

add_github_actions_check <- function(open = FALSE, overwrite = FALSE,
                                     quiet = FALSE) {

  
  stop_if_not_logical(open, overwrite, quiet)
  
  if (!dir.exists(file.path(path_proj(), ".git"))) {
    stop("The project is not versioning with git.")
  }
  
  
  path <- file.path(path_proj(), ".github", "workflows", "R-CMD-check.yaml")
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
    
    if (!open) {
      
      stop("An '.github/workflows/R-CMD-check.yaml' file is already present. ",
           "If you want to replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  
  
  ## Copy Template ----
  
  dir.create(file.path(path_proj(), ".github", "workflows"), 
             showWarnings = FALSE, recursive = TRUE)

  invisible(
    file.copy(system.file(file.path("templates", "__RCMDCHECK__"), 
                          package = "rcompendium"), path))

  
  if (!quiet) 
    ui_done("Writing {ui_value('.github/workflows/R-CMD-check.yaml')} file")
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
