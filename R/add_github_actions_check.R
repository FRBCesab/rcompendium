#' Setup GitHub Actions to check package
#' 
#' @description 
#' This function creates a configuration file (`.yaml`) to setup GitHub Actions 
#' to check the package.
#' This workflow is derived 
#' from \url{https://github.com/r-lib/actions/tree/v2-branch/examples}.
#' This file will be written as `.github/workflows/R-CMD-check.yaml`.
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
#' @details 
#' This workflow runs `R CMD check` on the three major operating systems
#' (Ubuntu, macOS, and Windows) using the latest release of R. The package is
#' also checked on Ubuntu (latest version) using the development and previous 
#' versions of R.
#' 
#' @return No return value.
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
    file.copy(system.file(file.path("templates", "R-CMD-check.yaml"), 
                          package = "rcompendium"), path))

  
  if (!quiet) 
    ui_done("Writing {ui_value('.github/workflows/R-CMD-check.yaml')} file")
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
