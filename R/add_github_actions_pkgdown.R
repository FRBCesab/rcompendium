#' Setup GitHub Actions to build and deploy package website
#' 
#' @description 
#' This function creates a configuration file (`.yaml`) to setup GitHub Actions 
#' to automatically build and deploy the website using 
#' [`pkgdown`](https://pkgdown.r-lib.org/index.html).
#' This file will be written (from a template adapted from 
#' [usethis::use_github_action()]) in the folder 
#' `.github/workflows/pkgdown.yaml`. An additional empty file (`_pkgdown.yaml`)
#' will also be written: it can be used to customize the website.
#' 
#' @param open a logical value
#' 
#'   If `TRUE` (default) the file is opened in the editor.
#' 
#' @param overwrite a logical value
#' 
#'   If this file is already present and `overwrite = TRUE`, it will be erased 
#'   and replaced. Default is `FALSE`.
#'   
#' @param quiet a logical value
#' 
#'   If `TRUE` messages are deleted. Default is `FALSE`.
#' 
#' @return None
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
  
  invisible(
    file.copy(system.file(file.path("templates", "__PKGDOWN__"), 
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
