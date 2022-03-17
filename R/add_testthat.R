#' Initialize units tests
#' 
#' @description 
#' This function initializes units tests settings by running 
#' [usethis::use_testthat()] and by adding an example units tests file 
#' `tests/testthat/test-demo.R`. The sample file will test a demo function
#' created in `R/fun-demo.R`.
#' 
#' @return No return value.
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
        file.copy(system.file(file.path("templates", "test-demo.R"), 
                              package = "rcompendium"), path, 
                  overwrite = TRUE)) 
    }
  }
  
  invisible(NULL)
}
