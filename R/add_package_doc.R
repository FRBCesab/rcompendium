#' Create a package-level documentation file
#'
#' @description 
#' This function adds a package-level documentation file (`.R`) in the **R/**
#' folder. This file will make help available to the user via `?pkg` (where 
#' `pkg` is the name of the project). It a good place to put general directives
#' like `@import` and `@importFrom`.
#' 
#' @param open a logical value. If `TRUE` (default) the file is opened in the 
#'   editor.
#' 
#' @param overwrite a logical value. If a file is already present and 
#' `overwrite = TRUE`, it will be erased and replaced.
#'
#' @export
#' 
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_package_doc()
#' }

add_package_doc <- function(open = TRUE, overwrite = FALSE) { 
  
  dir.create(here::here("R"), showWarnings = FALSE)
  
  filename <- paste0(get_package_name(), "-package.R")
  
  invisible(
    file.copy(system.file(file.path("templates", "INDEX"), 
                          package = "rcompendium"),
              here::here("R", filename)))
  
  ui_done("Writing {ui_value(paste0('R/', filename))} file")
  
  invisible(NULL)
}
