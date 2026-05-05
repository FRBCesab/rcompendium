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
  stop_if_not_project()

  if (!file.exists(build_abs_path("tests", "testthat.R"))) {
    usethis::use_testthat()

    path <- build_abs_path("tests", "testthat", "test-print_msg.R")

    if (!file.exists(path)) {
      download_template(
        slug = "package/test-print_msg.R",
        filename = path
      )
    }
  }

  invisible(NULL)
}
