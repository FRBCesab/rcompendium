#' Add to .Rbuildignore File
#' 
#' This function adds files/folders to the `.Rbuildignore` file. If a 
#' `.Rbuildignore` is already present, files to be ignored are just added to  
#' this file. Otherwise a new file is created.
#' 
#' @param x a character of one or several files/directories names to add to the 
#' `.Rbuildignore`. This argument is mandatory.
#' 
#' @param open a logical value. If `TRUE` the file is opened in the editor.
#' Default is `FALSE`.
#' 
#' @export

add_to_buildignore <- function(x, open = FALSE) {
  
  if (missing(x)) stop("Argument 'x' is missing.")
  
  stopifnot(is.character(x))
  
  
  ## Escape files ----
  
  x <- gsub("\\.", "\\\\.", x)
  x <- gsub("/$", "", x)
  x <- paste0("^", x, "$")
  
  
  ## Create new file (if missing) ----
  
  if (!file.exists(here::here(".Rbuildignore"))) {
    
    invisible(file.create(here::here(".Rbuildignore")))
    ui_done("Writing {ui_value('.Rbuildignore')} file")
  }
  
  
  ## Add files/folders to .Rbuildignore ----
  
  build_ignore <- readLines(here::here(".Rbuildignore"))
  
  if (!(x %in% build_ignore)) {
    
    build_ignore <- c(build_ignore, x)
    
    writeLines(build_ignore, con = here::here(".Rbuildignore"))
    ui_done("Adding {ui_value(x)} to {ui_value('.Rbuildignore')}")
    
  } else {
    
    ui_oops("{ui_value(x)} is already present in {ui_value('.Rbuildignore')}")  
  }
  
  if (open) utils::file.edit(here::here(".Rbuildignore"))
  
  invisible(NULL)
}