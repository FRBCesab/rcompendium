#' Create a .gitignore File
#' 
#' This function creates a `.gitignore` file at the root of the project based on
#' a template (specific to R). If a `.gitignore` is already present files to
#' be untracked by **git** are just added to this file.
#' 
#' @param x a character of one or several files/directories names to add to the 
#' `.gitignore`.
#' 
#' @param open a logical value. If `TRUE` the file is opened in the editor.
#' Default is `FALSE`.
#' 
#' @export

add_to_gitignore <- function(x, open = FALSE) {
  
  
  ## Copy Template ----
  
  if (!file.exists(here::here(".gitignore"))) {
    
    invisible(
      file.copy(system.file("templates/gitignore", package = "rcompendium"),
                here::here(".gitignore")))
    
    ui_done("Writing {ui_value('.gitignore')} file.")
  }
  
  
  ## Add files/folders to .gitignore ----
  
  if (!missing(x)) {
    
    stopifnot(is.character(x))
    
    git_ignore <- readLines(here::here(".gitignore"))
    
    if (!(x %in% git_ignore)) {
      
      git_ignore <- c(git_ignore, x)
      
      writeLines(git_ignore, con = here::here(".gitignore"))
      ui_done("Adding {ui_value(x)} to {ui_value('.gitignore')}")
      
    } else {
      
      ui_oops("{ui_value(x)} is already present in {ui_value('.gitignore')}")  
    }
  }
  
  if (open) file.edit(here::here(".gitignore"))
  
  invisible(NULL)
}
