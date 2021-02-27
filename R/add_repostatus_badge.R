#' Add a repository status badge
#'
#' @description 
#' This function adds or updates the Repo Status badge of the project. It is
#' based on the standard defined by the \url{https://www.repostatus.org/} 
#' project. Accepted status are listed below.
#'
#' @param status a character. One among 'concept', 'wip', 'suspended', 
#'   'abandoned', 'active', 'inactive', or 'unsupported'.
#'
#' @details 
#' The project can have the following status:
#' \itemize{
#'   \item **Concept** - Minimal or no implementation has been done yet, or the 
#'   repository is only intended to be a limited example, demo, or 
#'   proof-of-concept.
#'   \item **WIP** - Initial development is in progress, but there has not yet 
#'   been a stable, usable release suitable for the public.
#'   \item **Suspended** - Initial development has started, but there has not 
#'   yet been a stable, usable release; work has been stopped for the time 
#'   being but the author(s) intend on resuming work.
#'   \item **Abandoned** - Initial development has started, but there has not 
#'   yet been a stable, usable release; the project has been abandoned and the 
#'   author(s) do not intend on continuing development.
#'   \item **Active** - The project has reached a stable, usable state and is 
#'   being actively developed.
#'   \item **Inactive** - The project has reached a stable, usable state but is 
#'   no longer being actively developed; support/maintenance will be provided 
#'   as time allows.
#'   \item **Unsupported** - The project has reached a stable, usable state but 
#'   the author(s) have ceased all work on it. A new maintainer may be desired.
#' }
#'
#' @export
#' 
#' @family badge functions
#'
#' @examples
#' \dontrun{
#' add_repostatus_badge(status = "wip")
#' add_repostatus_badge(status = "active")
#' }

add_repostatus_badge <- function(status = "concept") {
  

  ## Checks ----
  
  if (is.null(status)) {
    stop("Argument `status` cannot be NULL.")
  }
  
  status <- match.arg(tolower(status), 
                      choices = c("concept", "wip", "suspended", "abandoned", 
                                  "active", "inactive", "unsupported"))

  if (!file.exists("README.Rmd")) {
    stop("The file **README.Rmd** cannot be found.")
  }
    
  
  ## Create Badge Markdown Expression ----
  
  status <- paste0(
    toupper(substr(status, 1, 1)),
    tolower(substr(status, 2, nchar(status))))
  
  status <- ifelse(status == "Wip", "WIP", status)
  
  alt  <- paste0("Project Status: ", 
                 status)
  href <- paste0("https://www.repostatus.org/#", 
                 tolower(status))
  img  <- paste0("https://www.repostatus.org/badges/latest/", 
                 tolower(status), ".svg")
  
  badge <- paste0("[![", alt, "](", img, ")](", href, ")")

  
  ## Add Badge ----
  
  add_badge(badge, pattern = "Project Status")
  
  ui_done("Adding {ui_field('Repo Status')} badge to {ui_value('README.Rmd')}")
  ui_todo("Re-knit {ui_value('README.Rmd')}")
  
  invisible(NULL)
}
