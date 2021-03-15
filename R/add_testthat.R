#' Initialize units tests
#' 
#' @description 
#' This function initializes units tests by running [usethis::use_testthat()]
#' and adding an example units tests file `test-demo.R`.
#' 
#' @export
#' 
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_testthat()
#' }

add_testthat <- function() {
  
  if (!file.exists(file.path(path_proj(), "tests", "testthat.R"))) {
    
    usethis::use_testthat()
    
    path <- file.path(path_proj(), "tests", "testthat", "test-demo.R")
  
    if (!file.exists(path)) {
      
      invisible(
        file.copy(system.file(file.path("templates", "__TESTDEMO__"), 
                              package = "rcompendium"), path, 
                  overwrite = TRUE)) 
    }
  }
  
  invisible(NULL)
}
