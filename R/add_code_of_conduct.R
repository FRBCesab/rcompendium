#' Add code of conduct
#' 
#' @description 
#' This function creates a `CODE_OF_CONDUCT.md` file adapted from the 
#' Contributor Covenant, version 2.1 available at 
#' \url{https://www.contributor-covenant.org/version/2/1/code_of_conduct.html}.
#'   
#' @param open A logical value. If `TRUE` (default) the `CONTRIBUTING.md` file 
#'   is opened in the editor.
#' 
#' @param overwrite A logical value. If files are already present and 
#'   `overwrite = TRUE`, they will be erased and replaced. Default is `FALSE`.
#'   
#' @param quiet A logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#' 
#' @inheritParams set_credentials
#' 
#' @return No return value.
#' 
#' @export
#' 
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_code_of_conduct()
#' }

add_code_of_conduct <- function(email = NULL, 
                                open = TRUE, overwrite = FALSE, quiet = FALSE) {
  
  
  stop_if_not_logical(open, overwrite, quiet)
  
  path <- file.path(path_proj(), "CODE_OF_CONDUCT.md")
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
    
    if (!open) {
      
      stop("A 'CODE_OF_CONDUCT.md' file is already present. If you want to ",
           "replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  
  
  ## Get fields values ----
  
  if (is.null(email)) email <- getOption("email")
  
  
  stop_if_not_string(email)
  
  
  ## Copy Template ----
  
  invisible(
    file.copy(system.file(file.path("templates", "CODE_OF_CONDUCT.md"), 
                          package = "rcompendium"), path, overwrite = TRUE))
  
  
  ## Change defaults values ----
  
  xfun::gsub_file(path, "{{email}}", email, fixed = TRUE)
  
  
  ## Messages ----
  
  if (!quiet) {
    ui_done("Writing {ui_value('CODE_OF_CONDUCT.md')} file")
  }
  
  add_to_buildignore("CODE_OF_CONDUCT.md", quiet = quiet)
  
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
