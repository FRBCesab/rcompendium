#' Create a CITATION file
#' 
#' @description 
#' This function creates a _CITATION_ file in the folder _inst/_. This file
#' contains a BiBTeX entry to cite the package as a manual.
#' 
#' @param organisation a character. The name of the GITHUB organisation to
#'   host the package. If `NULL` it uses the GITHUB account.
#'   
#' @param open a logical value. If `TRUE` (default) the file is opened in the 
#'   editor.
#' 
#' @param overwrite a logical value. If a _CITATION_ is already present and 
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
#' add_citation()
#' readCitationFile("inst/CITATION")
#' citation("pkg")    # If you have installed your package <pkg>
#' }

add_citation <- function(given = NULL, family = NULL, github = NULL, 
                         organisation = NULL, open = TRUE, overwrite = FALSE,
                         quiet = FALSE) { 
  
  path <- here::here("inst", "CITATION")
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
    
    if (!open) {
      
      stop("An 'inst/CITATION' file is already present. If you want to ",
           "replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  
  
  if ((file.exists(path) && overwrite) || !file.exists(path)) {
  
  
  ## Copy Template ----
  
    if (!dir.exists(here::here("inst")))
      dir.create(here::here("inst"), showWarnings = FALSE)
  
    invisible(
      file.copy(system.file(file.path("templates", "__CITATION__"), 
                            package = "rcompendium"), path))

  
  ## Change defaults values ----
  
    project_name <- get_package_name()
    xfun::gsub_file(path, "{{project_name}}", project_name, fixed = TRUE)
    
    pkg_version <- get_package_version()
    xfun::gsub_file(path, "{{pkg_version}}", pkg_version, fixed = TRUE)
  
    year <- format(Sys.Date(), "%Y")
    xfun::gsub_file(path, "{{year}}", year, fixed = TRUE)
  
    if (is.null(given)) given <- getOption("given")
    if (!is.null(given)) 
      xfun::gsub_file(path, "{{given}}", given, fixed = TRUE)
    
    if (is.null(family)) family <- getOption("family")
    if (!is.null(family)) 
      xfun::gsub_file(path, "{{family}}", family, fixed = TRUE)
    
    if (is.null(organisation)) {
      
      if (is.null(github)) github <- getOption("github")
      if (!is.null(github))
        xfun::gsub_file(path, "{{github}}", github, fixed = TRUE)
      
    } else {
      
      xfun::gsub_file(path, "{{github}}", organisation, fixed = TRUE)
    }
    
    
    if (!quiet) ui_done("Writing {ui_value('inst/CITATION')} file")
    
    if (open) edit_file(path)
    
    invisible(NULL)
  }
}
