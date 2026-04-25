#' Add CRAN total download badge
#'
#' @description
#' This function adds a **CRAN total download** badge to the `README.Rmd`.
#'
#' Make sure that 1) a `README.Rmd` file exists at the project root and 2) it
#' contains a block starting with the line `<!-- badges: start -->` and ending
#' with the line `<!-- badges: end -->`.
#'
#' Don't forget to re-render the `README.md`.
#'
#' @param quiet A logical value. If `TRUE` messages are deleted. Default is
#'   `FALSE`.
#'
#' @return A badge as a markdown expression.
#'
#' @export
#'
#' @family adding badges
#'
#' @examples
#' \dontrun{
#' add_cran_total_download_badge()
#' }

add_cran_total_download_badge <- function(quiet = FALSE) {
  stop_if_not_logical(quiet)

  ## Create Badge Markdown Expression ----

  project_name <- get_project_name()

  alt <- "Total downloads"
  href <- paste0("https://CRAN.R-project.org/package=", project_name)
  img <- paste0("https://cranlogs.r-pkg.org/badges/grand-total/", project_name)

  badge <- paste0("[![", alt, "](", img, ")](", href, ")")

  ## Add Badge ----

  add_badge(badge, pattern = alt)

  if (!quiet) {
    ui_done(paste0(
      "Adding {ui_field('Total downloads')} badge to ",
      "{ui_value('README.Rmd')}"
    ))
  }

  invisible(badge)
}
