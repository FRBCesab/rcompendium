#' Create a DESCRIPTION File
#' 
#' This function creates a DESCRIPTION file at the root of the project based on 
#' a template.
#' 
#' @param open a logical value. If `TRUE` (default) the file is opened in the 
#' editor.
#' 
#' @param overwrite a logical value. If a `DESCRIPTION` is already present and 
#' `overwrite = TRUE`, this file will be erased and replaced.
#' 
#' @export

add_description <- function(open = TRUE, overwrite = FALSE) {
  
  
  ## Do not replace current file ----
  
  if (!overwrite) {
    if (file.exists("DESCRIPTION")) {
      stop("A **DESCRIPTION** file is already present. If you want to ",
           "replace it, please use `overwrite = TRUE`.")
    }
  }
  
  
  ## Copy Template ----
  
  invisible(
    file.copy(system.file(file.path("templates", "DESCRIPTION"), 
                          package = "rcompendium"),
              here::here("DESCRIPTION")))
  
  
  ## Change default values (in file) ----
  
  project_name <- get_project_name()
  xfun::gsub_file(here::here("DESCRIPTION"), "{{project_name}}", 
                  project_name, fixed = TRUE)
  
  r_version <- get_r_version()
  xfun::gsub_file(here::here("DESCRIPTION"), "{{r_version}}", 
                  r_version, fixed = TRUE)
  
  roxygen2_version <- get_roxygen2_version()
  xfun::gsub_file(here::here("DESCRIPTION"), "{{roxygen2_version}}", 
                  roxygen2_version, fixed = TRUE)
  
  
  ## Change user credentials ----
  
  given_name <- getOption("given")
  if (!is.null(given_name)) {
    xfun::gsub_file(here::here("DESCRIPTION"), "{{given}}", given_name, 
                    fixed = TRUE)
  }
  
  family_name <- getOption("family")
  if (!is.null(family_name)) {
    xfun::gsub_file(here::here("DESCRIPTION"), "{{family}}", family_name, 
                    fixed = TRUE)
  }
  
  email <- getOption("email")
  if (!is.null(email)) {
    xfun::gsub_file(here::here("DESCRIPTION"), "{{email}}", email, 
                    fixed = TRUE)
  }
  
  orcid <- getOption("orcid")
  if (!is.null(orcid)) {
    xfun::gsub_file(here::here("DESCRIPTION"), "{{orcid}}", orcid, 
                    fixed = TRUE)
  }
  
  github <- getOption("github")
  if (!is.null(github)) {
    xfun::gsub_file(here::here("DESCRIPTION"), "{{github}}", github, 
                    fixed = TRUE)
  }
  
  license_pref <- getOption("license")
  if (!is.null(license_pref)) {
    xfun::gsub_file(here::here("DESCRIPTION"), "{{license}}", license_pref, 
                    fixed = TRUE)
  }
  
  
  ## Message ----
  
  ui_done("Writing {ui_value('DESCRIPTION')} file")
  
  if (open) utils::file.edit(here::here("DESCRIPTION"))
  
  invisible(NULL)
}
