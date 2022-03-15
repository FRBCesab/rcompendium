#' Add a Life Cycle badge
#'
#' @description 
#' This function adds or updates the **Life Cycle** badge to the `README.Rmd`.
#' It is based on the standard defined at 
#' \url{https://lifecycle.r-lib.org/articles/stages.html}.
#' 
#' Make sure that 1) a `README.Rmd` file exists at the project root and 2) it
#' contains a block starting with the line `<!-- badges: start -->` and ending 
#' with the line `<!-- badges: end -->`.
#' 
#' Don't forget to re-render the `README.md`.
#'
#' @param lifecycle A character of length 1. Accepted stages are: 
#'   `'experimental'` (default), `'stable'`, `'deprecated'`, or `'superseded'`.
#' 
#' @param quiet A logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#'   
#' @details 
#' The project can have the following life cycle stage:
#' \itemize{
#'   \item **Experimental** - An experimental project is made available so user 
#'   can try it out and provide feedback, but come with no promises for long 
#'   term stability.
#'   \item **Stable** - A project is considered stable when the author is happy 
#'   with its interface, does not see major issues, and is happy to share it 
#'   with the world.
#'   \item **Superseded** - A superseded project has a known better 
#'   alternative, and it is not going away. Superseded project will not receive 
#'   new features, but will receive any critical bug fixes needed to keep it 
#'   working.
#'   \item **Deprecated** - A deprecated project has a better alternative 
#'   available and is scheduled for removal.
#' }
#' 
#' @return A badge as a markdown expression.
#'
#' @export
#' 
#' @family adding badges
#'
#' @examples
#' \dontrun{
#' add_lifecycle_badge()
#' add_lifecycle_badge(lifecycle = "stable")
#' }

add_lifecycle_badge <- function(lifecycle = "experimental", quiet = FALSE) {
  
  
  ## Checks ----
  
  stop_if_not_logical(quiet)
  
  stop_if_not_string(lifecycle)

  if (!(tolower(lifecycle) %in% c("experimental", "stable", "deprecated", 
                                  "superseded"))) {
    stop("Argument 'lifecycle' must be of among 'experimental', 'stable', ",
         "'deprecated', or 'superseded'.")
  }

  
  if (!file.exists(file.path(path_proj(), "README.Rmd"))) {
    stop("The file 'README.Rmd' cannot be found.")
  }
  
  
  ## Create Badge Markdown Expression ----
  
  color <- switch(lifecycle,
                  `stable`       = "green",
                  `experimental` = "orange",
                  `deprecated`   = "orange",
                  `superseded`   = "blue")
  
  alt  <- "LifeCycle"
  
  href <- paste0("https://lifecycle.r-lib.org/articles/stages.html#", 
                 lifecycle)
  
  img  <- paste0("https://img.shields.io/badge/lifecycle-", lifecycle, "-", 
                 color)
  
  badge <- paste0("[![", alt, "](", img, ")](", href, ")")
  
  
  ## Add Badge ----
  
  add_badge(badge, pattern = alt)
  
  
  if (!quiet) {
    ui_done(paste0("Adding {ui_field('Lifecycle')} badge to ", 
                   "{ui_value('README.Rmd')}"))
  }
  
  invisible(badge)
}
