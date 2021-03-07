#' Create a DESCRIPTION file
#' 
#' @description 
#' This function creates a `DESCRIPTION` file at the root of the project based  
#' on a template. User credentials can be passed as arguments but it is 
#' recommended to store them in the `.Rprofile` file with [set_credentials()].
#' 
#' @param organisation a character. The name of the GITHUB organisation to
#'   host the package. If `NULL` it uses the GITHUB account.
#'   
#' @param open a logical value. If `TRUE` (default) the file is opened in the 
#'   editor.
#' 
#' @param overwrite a logical value. If a `DESCRIPTION` is already present and 
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
#' add_description(organisation = "FRBCesab")
#' }

add_description <- function(given = NULL, family = NULL, email = NULL, 
                            orcid = NULL, github = NULL, organisation = NULL, 
                            open = TRUE, overwrite = FALSE, quiet = FALSE) {
  
  
  stop_if_not_logical(open, overwrite, quiet)
  
  
  path <- here::here("DESCRIPTION")
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
      
    if (!open) {
      
      stop("A 'DESCRIPTION' file is already present. If you want to ",
           "replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  

  if ((file.exists(path) && overwrite) || !file.exists(path)) {
  
    
    ## Get fields values ----
    
    if (is.null(given))  given  <- getOption("given")
    if (is.null(family)) family <- getOption("family")
    if (is.null(email))  email  <- getOption("email")
    if (is.null(orcid))  orcid  <- getOption("orcid")
    
    if (!is.null(organisation)) {
      github <- organisation
    } else {
      if (is.null(github)) github <- getOption("github")  
    }
    
    stop_if_not_string(given, family, email, orcid, github)
    
    
    project_name     <- get_package_name()
    r_version        <- get_r_version()
    roxygen2_version <- get_roxygen2_version()
    
    
    ## Copy Template ----
    
    invisible(
      file.copy(system.file(file.path("templates", "__DESCRIPTION__"), 
                            package = "rcompendium"), path, overwrite = TRUE))
    
    
    ## Change default values (in file) ----
    
    xfun::gsub_file(path, "{{project_name}}", project_name, fixed = TRUE)
    xfun::gsub_file(path, "{{r_version}}", r_version, fixed = TRUE)
    xfun::gsub_file(path, "{{roxygen2_version}}", roxygen2_version, fixed = TRUE)
    xfun::gsub_file(path, "{{given}}", given, fixed = TRUE)
    xfun::gsub_file(path, "{{family}}", family, fixed = TRUE)
    xfun::gsub_file(path, "{{email}}", email, fixed = TRUE)
    xfun::gsub_file(path, "{{orcid}}", orcid, fixed = TRUE)
    xfun::gsub_file(path, "{{github}}", github, fixed = TRUE)
    
    
    ## Message ----
    
    if (!quiet) ui_done("Writing {ui_value('DESCRIPTION')} file")
  
    if (open) edit_file(path)
    
    invisible(NULL)
  }
}