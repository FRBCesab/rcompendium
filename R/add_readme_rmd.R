#' Create a README file
#' 
#' This function creates a `README.Rmd` file at the root of the project based on 
#' a template. Once edited user needs to knit it into a `README.Rmd` (or use the
#' function [refresh()].
#' 
#' @param type a character. If `package` (default) a GitHub `README.Rmd` 
#'   specific to an R package will be created. If `compendium` a GitHub 
#'   `README.Rmd` specific to a research compendium will be created.
#' 
#' @param organisation a character. The name of the GITHUB organisation to
#'   host the package. If `NULL` it uses the GITHUB account.
#' 
#' @param open a logical value. If `TRUE` (default) the file is opened in the 
#'   editor.
#' 
#' @param overwrite a logical value. If a `README.Rmd` is already present and 
#' `overwrite = TRUE`, this file will be erased and replaced.
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
#' add_readme_rmd(type = "package")
#' }

add_readme_rmd <- function(type = "package", given = NULL, family = NULL, 
                           github = NULL, organisation = NULL, open = TRUE, 
                           overwrite = FALSE, quiet = FALSE) {
  
  
  if (is.null(type)) {
    stop("Argument 'type' must be 'package' or 'compendium'.")
  }
  
  if (length(type) != 1) {
    stop("Argument 'type' must be 'package' or 'compendium'.") 
  }
  
  if (!(tolower(type) %in% c("package", "compendium"))) {
    stop("Argument 'type' must be 'package' or 'compendium'.")
  }
  
  stop_if_not_logical(open, overwrite, quiet)
  
  
  path <- here::here("README.Rmd")
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
    
    if (!open) {
      
      stop("A 'README.Rmd' file is already present. If you want to ",
           "replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  
  
  if ((file.exists(path) && overwrite) || !file.exists(path)) {
    
    
    if (is.null(given))  given  <- getOption("given")
    if (is.null(family)) family <- getOption("family")
    
    if (!is.null(organisation)) {
      github <- organisation
    } else {
      if (is.null(github)) github <- getOption("github")  
    }
    
    stop_if_not_string(given, family, github)
    
    
    project_name <- get_package_name()
    pkg_version <- get_package_version()
    
    
    ## Copy Template ----
    
    if (type == "package") {
      
      invisible(
        file.copy(system.file(file.path("templates", "__READMEPKG__"),
                              package = "rcompendium"), path, overwrite = TRUE))
    } else {
      
      invisible(
        file.copy(system.file(file.path("templates", "__READMERC__"),
                              package = "rcompendium"), path, overwrite = TRUE))
    }
      
  
    ## Change default values (in file) ----
  
    
    xfun::gsub_file(path, "{{project_name}}", project_name, fixed = TRUE)
    xfun::gsub_file(path, "{{pkg_version}}", pkg_version, fixed = TRUE)
    xfun::gsub_file(path, "{{given}}", given, fixed = TRUE)
    xfun::gsub_file(path, "{{family}}", family, fixed = TRUE)
    xfun::gsub_file(path, "{{github}}", github, fixed = TRUE)
    
    
    ## Message ----
    
    if (!quiet) ui_done("Writing {ui_value('README.Rmd')} file")
    
    add_to_buildignore("README.Rmd", quiet = quiet)
    add_to_buildignore("README.html", quiet = TRUE)
    
    if (open) edit_file(path)
    
    invisible(NULL)
  }
}