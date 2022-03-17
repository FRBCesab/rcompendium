#' Setup GitHub Actions to render README
#' 
#' @description 
#' This function creates a configuration file (`.yaml`) to setup GitHub Actions 
#' to automatically knit the `README.Rmd` after a push. This workflow will be
#' triggered only if the `README.Rmd` has been modified since the last commit.
#' This workflow is derived 
#' from \url{https://github.com/r-lib/actions/tree/v2-branch/examples}.
#' This file will be written as `.github/workflows/render-README.yaml`.
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
#' add_github_actions_render()
#' }

add_github_actions_render <- function(open = FALSE, overwrite = FALSE,
                                      quiet = FALSE) {
  
  
  stop_if_not_logical(open, overwrite, quiet)
  
  if (!dir.exists(file.path(path_proj(), ".git"))) {
    stop("The project is not versioning with git.")
  }
  
  
  path <- file.path(path_proj(), ".github", "workflows", "render-README.yaml")
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
    
    if (!open) {
      
      stop("An '.github/workflows/render-README.yaml' file is already present.",
           " If you want to replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  
  
  ## Copy Template ----
  
  dir.create(file.path(path_proj(), ".github", "workflows"), 
             showWarnings = FALSE, recursive = TRUE)
  
  invisible(
    file.copy(system.file(file.path("templates", "render-README.yaml"), 
                          package = "rcompendium"), path))
  
  
  if (!quiet) 
    ui_done("Writing {ui_value('.github/workflows/render-README.yaml')} file")
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
