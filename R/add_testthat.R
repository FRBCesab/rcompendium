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

    path <- file.path(path_proj(), "tests", "testthat", "test-print_msg.R")

    if (!file.exists(path)) {
      download_template(
        slug = "package/test-print_msg.R",
        filename = "test-print_msg.R",
        outdir = file.path(path_proj(), "tests", "testthat")
      )
    }
  }

  invisible(NULL)
}
