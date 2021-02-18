#' Create a Make-like R File
#' 
#' This function creates a Make-like R file (`make.R`) at the root of the 
#' project based on a template.
#' 
#' @param open a logical value. If `TRUE` (default) the file is opened in the 
#' editor.
#' 
#' @param overwrite a logical value. If a `make.R` is already present and 
#' `overwrite = TRUE`, this file will be erased and replaced.
#' 
#' @export

add_makefile <- function(open = TRUE, overwrite = FALSE) { 
  
  
  ## Do not replace current file ----
  
  if (!overwrite) {
    if (file.exists("make.R")) {
      stop("A `make.R` file is already present. If you want to replace ",
           "it, please use `overwrite = TRUE`.")
    }
  }
  
  
  ## Copy Template ----
  
  invisible(
    file.copy(system.file("templates/make.R", package = "rcompendium"),
              here::here("make.R")))
  
  
  ## Update date and project name ----
  
  today <- format(Sys.time(), "%Y/%m/%d")
  xfun::gsub_file(here::here("make.R"), "{{date}}", 
                  today, fixed = TRUE)
  
  project_name <- get_project_name()
  xfun::gsub_file(here::here("make.R"), "{{project_name}}", 
                  project_name, fixed = TRUE)
  
  
  ui_done("Writing {ui_value('make.R')} file.")
  
  if (open) file.edit(here::here("make.R"))
  
  invisible(NULL)
}