#' Create a README File
#' 
#' This function creates a `README.Rmd` file at the root of the project based on 
#' a template. Once edited user needs to knit it into a `README.md`.
#' 
#' @param type a character. If `package` (default) a GitHub `README.Rmd` 
#' specific to an R package will be created. If `compendium` a GitHub 
#' `README.Rmd` specific to a research compendium will be created.
#' 
#' @param open a logical value. If `TRUE` (default) the file is opened in the 
#' editor.
#' 
#' @param overwrite a logical value. If a `README.Rmd` is already present and 
#' `overwrite = TRUE`, this file will be erased and replaced.
#' 
#' @export

add_readme_rmd <- function(type = "package", open = TRUE, overwrite = FALSE) {
  
  
  if (!(tolower(type) %in% c("package", "compendium"))) {
    stop("Argument `type` must be 'package' or 'compendium'.")
  }
  
  ## Do not replace current file ----
  
  if (!overwrite) {
    if (file.exists("README.Rmd")) {
      stop("A **README.Rmd** file is already present. If you want to replace ",
           "it, please use `overwrite = TRUE`.")
    }
  }
  
  
  ## Copy Template ----
  
  if (type == "package") {
    
    invisible(
      file.copy(system.file(file.path("templates", "README-pkg"),
                            package = "rcompendium"),
                here::here("README.Rmd")))
  } else {
    
    invisible(
      file.copy(system.file(file.path("templates", "README-rc"),
                            package = "rcompendium"),
                here::here("README.Rmd")))
  }
    
  
  ## Change default values (in file) ----
  
  project_name <- get_project_name()
  xfun::gsub_file(here::here("README.Rmd"), "{{project_name}}", 
                  project_name, fixed = TRUE)
  
  given_name <- getOption("given")
  if (!is.null(given_name)) {
    xfun::gsub_file(here::here("README.Rmd"), "{{given}}", given_name, 
                    fixed = TRUE)
  }
  
  family_name <- getOption("family")
  if (!is.null(family_name)) {
    xfun::gsub_file(here::here("README.Rmd"), "{{family}}", family_name, 
                    fixed = TRUE)
  }
  
  github <- getOption("github")
  if (!is.null(github)) {
    xfun::gsub_file(here::here("README.Rmd"), "{{github}}", github, 
                    fixed = TRUE)
  }
  
  pkg_version <- get_pkg_version()
  xfun::gsub_file(here::here("README.Rmd"), "{{pkg_version}}", 
                  project_name, fixed = TRUE)

  
  ## Message ----
  
  ui_done("Writing {ui_value('README.Rmd')} file")
  
  if (open) utils::file.edit(here::here("README.Rmd"))
  
  invisible(NULL)
}
