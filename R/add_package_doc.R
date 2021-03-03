#' Create a package-level documentation file
#'
#' @description 
#' This function adds a package-level documentation file (`pkg-package.R`) in 
#' the `R/` folder. This file will make help available to the user via `?pkg` 
#' (where `pkg` is the name of the package). It a good place to put general 
#' directives like `@import` and `@importFrom`.
#' 
#' @param open a logical value. If `TRUE` (default) the file is opened in the 
#'   editor.
#' 
#' @param overwrite a logical value. If a file is already present and 
#'   `overwrite = TRUE`, it will be erased and replaced.
#'   
#' @param quiet a logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#'   
#' @export
#' 
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_package_doc()
#' }

add_package_doc <- function(open = TRUE, overwrite = FALSE, quiet = FALSE) { 
  
  filename <- paste0(get_package_name(), "-package.R")
  
  path <- here::here("R", filename)
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
    
    if (!open) {
      
      stop("A 'R/", filename, "' file is already present. If you want to ",
           "replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  
  
  if ((file.exists(path) && overwrite) || !file.exists(path)) {
  
    if (!dir.exists(here::here("R")))
      dir.create(here::here("R"), showWarnings = FALSE)
    
    invisible(
      file.copy(system.file(file.path("templates", "__INDEX__"), 
                            package = "rcompendium"), path))
    
    
    if (!quiet) ui_done("Writing {ui_value(paste0('R/', filename))} file")
    
    if (open) edit_file(path)
    
    invisible(NULL)
  }
}