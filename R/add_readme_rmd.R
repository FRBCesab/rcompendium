#' Create a README File
#' 
#' This function creates a `README.Rmd` file at the root of the project based on 
#' a template. Once edited user needs to knit the file (`rmarkdown::render()`).
#' 
#' @param open a logical value. If `TRUE` (default) the file is opened in the 
#' editor.
#' 
#' @param overwrite a logical value. If a `README.Rmd` is already present and 
#' `overwrite = TRUE`, this file will be erased and replaced.
#' 
#' @export

add_readme_rmd <- function(open = TRUE, overwrite = FALSE) {
  
  
  ## Do not replace current file ----
  
  if (!overwrite) {
    if (file.exists("README.Rmd")) {
      stop("A `README.Rmd` file is already present. If you want to replace ",
           "it, please use `overwrite = TRUE`.")
    }
  }
  
  
  ## Copy Template ----
  
  invisible(
    file.copy(system.file("templates/README.Rmd", package = "rcompendium"),
              here::here("README.Rmd")))
  
  
  ## Change default values (in file) ----
  
  project_name <- get_project_name()
  xfun::gsub_file(here::here("README.Rmd"), "{{project_name}}", 
                  project_name, fixed = TRUE)
  
  
  ## Message ----
  
  ui_done("Writing {ui_value('README.Rmd')} file")
  
  if (open) file.edit(here::here("README.Rmd"))
  
  invisible(NULL)
}
