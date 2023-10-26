#' Setup GitHub Actions to build and deploy package website
#' 
#' @description 
#' This function creates a configuration file (`.yaml`) to setup GitHub Actions 
#' to automatically build and deploy the website using 
#' [`pkgdown`](https://pkgdown.r-lib.org/index.html). This workflow is derived 
#' from \url{https://github.com/r-lib/actions/tree/v2-branch/examples}.
#' This file will be written as `.github/workflows/pkgdown.yaml`. 
#' An additional empty file (`_pkgdown.yaml`) will also be written: it can be 
#' used to customize the website.
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
#' @return No return value.
#'
#' @export
#' 
#' @family development functions
#'
#' @examples
#' \dontrun{
#' add_github_actions_pkgdown()
#' }

add_github_actions_pkgdown <- function(open = FALSE, overwrite = FALSE, 
                                       quiet = FALSE) {

  
  stop_if_not_logical(open, overwrite, quiet)
  
  if (!dir.exists(file.path(path_proj(), ".git"))) {
    stop("The project is not versioning with git.")
  }
  
  path <- file.path(path_proj(), ".github", "workflows", "pkgdown.yaml")
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
    
    if (!open) {
      
      stop("An '.github/workflows/pkgdown.yaml' file is already present. ",
           "If you want to replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  
  
  ## Copy Template ----
    
  dir.create(file.path(path_proj(), ".github", "workflows"), 
             showWarnings = FALSE, recursive = TRUE)
  
  add_to_buildignore(".github", quiet = FALSE)
  
  invisible(
    file.copy(system.file(file.path("templates", "pkgdown.yaml"), 
                          package = "rcompendium"), path))
  
  
  if (!quiet) 
    ui_done("Writing {ui_value('.github/workflows/pkgdown.yaml')} file")
  
  
  ## Write (Empty) Custom Config file ---
  
  if (!file.exists(file.path(path_proj(), "_pkgdown.yaml"))) {
    file.create(file.path(path_proj(), "_pkgdown.yaml"))
    add_to_buildignore("_pkgdown.yaml", quiet = quiet)
  }
  
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
