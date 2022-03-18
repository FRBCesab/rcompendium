#' Add to the .gitignore file
#' 
#' @description 
#' This function creates a `.gitignore` file at the root of the project based on
#' a template (specific to R). If a `.gitignore` is already present, files to
#' be untracked by **git** are just added to this file.
#' 
#' @param x A character vector. One or several files/folders names to be added 
#'   to the `.gitignore`.
#' 
#' @param open A logical value. If `TRUE` the `.gitignore` file is opened in 
#'   the editor. Default is `FALSE`.
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
#' add_to_gitignore(open = TRUE)
#' add_to_gitignore(".DS_Store")
#' }

add_to_gitignore <- function(x, open = FALSE, quiet = FALSE) {
  
  
  stop_if_not_logical(open, quiet)
  
  path <- file.path(path_proj(), ".gitignore")
  
  
  ## Copy Template ----
  
  if (!file.exists(path)) {
    
    invisible(
      file.copy(system.file(file.path("templates", "gitignore"), 
                            package = "rcompendium"), path))
    
    if (!quiet) ui_done("Writing {ui_value('.gitignore')} file")
  }
  
  
  ## Add files/folders to .gitignore ----
  
  if (!missing(x)) {
    
    stopifnot(is.character(x))
    
    git_ignore <- readLines(path)
    
    x <- x[!(x %in% git_ignore)]
    
    if (length(x)) {
      
      git_ignore <- c(git_ignore, x)
      
      writeLines(git_ignore, con = path)
      
      if (!quiet) 
        ui_done(paste0("Adding {ui_value(paste0(x, collapse = ", "))} to ", 
                       "{ui_value('.gitignore')}"))
    }
  }
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
