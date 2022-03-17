#' Create a package-level documentation file
#'
#' @description 
#' This function adds a package-level documentation file (`pkg-package.R`) in 
#' the `R/` folder. This file will make help available to the user via `?pkg` 
#' (where `pkg` is the name of the package). It a good place to put general 
#' directives like `@import` and `@importFrom`.
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
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_package_doc()
#' }

add_package_doc <- function(open = TRUE, overwrite = FALSE, quiet = FALSE) { 
  
  
  stop_if_not_logical(open, overwrite, quiet)
  
  filename <- paste0(get_package_name(), "-package.R")
  path     <- file.path(path_proj(), "R", filename)
  
  
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
  
  
  if (!dir.exists(file.path(path_proj(), "R")))
    dir.create(file.path(path_proj(), "R"), showWarnings = FALSE)
  
  invisible(
    file.copy(system.file(file.path("templates", "package-package.R"), 
                          package = "rcompendium"), path, overwrite = TRUE))
  
  
  if (!quiet) ui_done("Writing {ui_value(paste0('R/', filename))} file")
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
