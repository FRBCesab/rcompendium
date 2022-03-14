#' Add to the .Rbuildignore file
#' 
#' @description 
#' This function adds files/folders to the `.Rbuildignore` file. If a 
#' `.Rbuildignore` is already present, files to be ignored while checking 
#' package are just added to this file. Otherwise a new file is created.
#' 
#' @param x A character vector. One or several files/folders names to be added 
#'   to the `.Rbuildignore`. This argument is mandatory.
#' 
#' @param open A logical value. If `TRUE` the `.Rbuildignore` file is opened in
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
#' add_to_buildignore(open = TRUE)
#' add_to_buildignore(".DS_Store")
#' }

add_to_buildignore <- function(x, open = FALSE, quiet = FALSE) {
  
  
  if (missing(x) && !open) stop("Argument 'x' is missing.")
  
  stop_if_not_logical(open, quiet)
  
  
  path <- file.path(path_proj(), ".Rbuildignore")
  
  
  ## Create new file (if missing) ----
  
  if (!file.exists(path)) {
    
    invisible(file.create(path))
    
    if (!quiet) ui_done("Writing {ui_value('.Rbuildignore')} file")
  }
  
  
  ## Add file/folder ----
  
  if (!missing(x)) {
  
    stopifnot(is.character(x))
  
  
    ## Escape files ----
    
    x <- gsub("\\.", "\\\\.", x)
    x <- gsub("/$", "", x)
    x <- paste0("^", x, "$")
    
  
    ## Add files/folders to .Rbuildignore ----
  
    build_ignore <- readLines(path)
  
    x <- x[!(x %in% build_ignore)]
    
    if (length(x)) {
      
      build_ignore <- c(build_ignore, x)
      
      writeLines(build_ignore, con = path)
      
      if (!quiet) 
        ui_done(paste0("Adding {ui_value(paste0(x, collapse = ", "))} to ", 
                       "{ui_value('.Rbuildignore')}"))
    }
  }
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
