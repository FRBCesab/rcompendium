#' Add a CRAN Status badge
#'
#' @description 
#' This function adds a **CRAN Status** badge to the `README.Rmd`. If the 
#' package is not hosted on the CRAN the badge will indicate 
#' _not published on the CRAN_.
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
#' add_cran_badge()
#' }

add_cran_badge <- function(quiet = FALSE) {
  
  
  stop_if_not_logical(quiet)
  
  ## Create Badge Markdown Expression ----
  
  project_name <- get_package_name()
  
  alt  <- "CRAN status"
  href <- paste0("https://CRAN.R-project.org/package=", project_name)
  img  <- paste0("https://www.r-pkg.org/badges/version/", project_name)
  
  badge <- paste0("[![", alt, "](", img, ")](", href, ")")
  
  
  ## Add Badge ----
  
  add_badge(badge, pattern = "CRAN status")
  
  
  if (!quiet) {
    ui_done(paste0("Adding {ui_field('CRAN status')} badge to ", 
                   "{ui_value('README.Rmd')}"))
  }
  
  invisible(badge)
}
