#' Create a Make-like R file
#' 
#' @description
#' This function creates a Make-like R file ( _make.R_ ) at the root of the 
#' project based on a template.
#' 
#' @param open a logical value. If `TRUE` (default) the file is opened in the 
#'   editor.
#' 
#' @param overwrite a logical value. If a _make.R_ is already present and 
#'   `overwrite = TRUE`, this file will be erased and replaced.
#' 
#' @param quiet a logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#'   
#' @inheritParams set_credentials
#'   
#' @export
#' 
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_makefile()
#' }

add_makefile <- function(given = NULL, family = NULL, email = NULL, 
                         open = TRUE, overwrite = FALSE, quiet = FALSE) { 
  
  
  path <- here::here("make.R")
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
    
    if (!open) {
      
      stop("A 'make.R' file is already present. If you want to ",
           "replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  
  
  if ((file.exists(path) && overwrite) || !file.exists(path)) {
  
  
    ## Copy Template ----
    
    invisible(
      file.copy(system.file(file.path("templates", "__MAKE__"), 
                            package = "rcompendium"), path))
    
    
    ## Update date and project name ----
    
    today <- format(Sys.time(), "%Y/%m/%d")
    xfun::gsub_file(path, "{{date}}", today, fixed = TRUE)
    
    project_name <- get_package_name()
    xfun::gsub_file(path, "{{project_name}}", project_name, fixed = TRUE)
    
    
    ## Change user credentials ----
    
    if (is.null(given)) given <- getOption("given")
    if (!is.null(given)) 
      xfun::gsub_file(path, "{{given}}", given, fixed = TRUE)
    
    if (is.null(family)) family <- getOption("family")
    if (!is.null(family)) 
      xfun::gsub_file(path, "{{family}}", family, fixed = TRUE)
    
    if (is.null(email)) email <- getOption("email")
    if (!is.null(email))
      xfun::gsub_file(path, "{{email}}", email, fixed = TRUE)
    
    
    if (!quiet) ui_done("Writing {ui_value('make.R')} file")
    
    add_to_buildignore("make.R", quiet = quiet)
    
    if (open) edit_file(path)
    
    invisible(NULL)
  }
}
