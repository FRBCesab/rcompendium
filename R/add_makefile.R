#' Create a Make-like R file
#' 
#' @description
#' This function creates a Make-like R file (`make.R`) at the root of the 
#' project based on a template. To be used only if the project is a research
#' compendium. The content of this file provides some guidelines. See also
#' [new_compendium()] for further information.
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
#' @inheritParams set_credentials
#' 
#' @return None
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
  
  
  stop_if_not_logical(open, overwrite, quiet)
  
  path <- file.path(path_proj(), "make.R")
  
  
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
  
  
  ## Get fields values ----
    
  if (is.null(given))  given  <- getOption("given")
  if (is.null(family)) family <- getOption("family")
  if (is.null(email))  email  <- getOption("email")
  
  stop_if_not_string(given, family, email)
  
  
  project_name <- get_package_name()
  today        <- format(Sys.time(), "%Y/%m/%d")
  
  
  ## Copy Template ----
  
  invisible(
    file.copy(system.file(file.path("templates", "__MAKE__"), 
                          package = "rcompendium"), path, overwrite = TRUE))
  
  
  ## Update default values ----
  
  
  xfun::gsub_file(path, "{{date}}", today, fixed = TRUE)
  xfun::gsub_file(path, "{{project_name}}", project_name, fixed = TRUE)
  xfun::gsub_file(path, "{{given}}", given, fixed = TRUE)
  xfun::gsub_file(path, "{{family}}", family, fixed = TRUE)
  xfun::gsub_file(path, "{{email}}", email, fixed = TRUE)
  
  
  ## Message ----
  
  if (!quiet) ui_done("Writing {ui_value('make.R')} file")
  
  add_to_buildignore("make.R", quiet = quiet)
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
