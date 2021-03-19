#' Add a Dependencies badge
#'
#' @description 
#' This function adds a dependencies badge to the `README.Rmd`. The first
#' number corresponds to the direct dependencies and the second to the 
#' recursive dependencies.
#' 
#' **Note/** this function can work with packages not published on the CRAN
#' and is based on the function [gtools::getDependencies()]. See also the 
#' function [get_all_dependencies()].
#' 
#' @param quiet a logical value
#' 
#'   If `TRUE` messages are deleted. Default is `FALSE`.
#' 
#' @return A Markdown badge expression
#'
#' @export
#' 
#' @family adding badges
#'
#' @examples
#' \dontrun{
#' add_dependencies_badge()
#' }

add_dependencies_badge <- function(quiet = FALSE) {
  
  
  stop_if_not_logical(quiet)
  
  deps <- get_all_dependencies()
  deps <- unlist(lapply(deps, length))
  
  
  ## Create Badge Markdown Expression ----
  
  if (deps["direct_deps"] == 0) 
    color <- "brightgreen"
  if (deps["direct_deps"] >  0 && 
      deps["direct_deps"] <  5) 
    color <- "green"
  if (deps["direct_deps"] >  4 && 
      deps["direct_deps"] < 10) 
    color <- "orange"
  if (deps["direct_deps"] >  9) 
    color <- "red"
  
  url <- "https://img.shields.io/badge/dependencies"
  
  img <- paste0(url, "-", deps["direct_deps"], "/", deps["all_deps"], "-")
  img <- paste0(img, color, "?style=flat")
  
  badge <- paste0("[![Dependencies](", img, ")](#)")
  

  ## Add Badge ----
  
  add_badge(badge, pattern = "Dependencies")
  
  
  if (!quiet) {
    ui_done(paste0("Adding {ui_field('Dependencies')} badge to ", 
                   "{ui_value('README.Rmd')}"))
  }
  
  invisible(badge)
}
