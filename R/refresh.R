#' Refresh a package/research compendium
#' 
#' @description 
#' **This function is about to be removed from `rcompendium`.**
#' 
#' This function refreshes a package/research compendium. It will:
#' * Update `.Rd` files and `NAMESPACE` by using [devtools::document()];
#' * Update external packages (in `DESCRIPTION` file) by using 
#' [add_dependencies()];
#' * Update badges in `README.Rmd` (if already present);
#' * Re-knitr the `README.Rmd` by using [rmarkdown::render()];
#' * Check package integrity by using [devtools::check()];
#' * Run analysis by sourcing `make.R` (only for compendium).
#' 
#' @param make A logical value. If `TRUE` the Make-like R file `make.R` is 
#'   sourced. Only for research compendium created with [new_compendium()]. 
#'   Default is `FALSE`.
#'   
#' @param check A logical value. If `TRUE` package integrity is checked using 
#'   [devtools::check()].
#'   Default is `FALSE`.
#'   
#' @param quiet A logical value. If `TRUE` (default) message are deleted.
#'  
#' @inheritParams add_dependencies
#' 
#' @return No return value.
#'
#' @export
#' 
#' @family setup functions
#' 
#' @examples 
#' \dontrun{
#' library(rcompendium)
#'
#' ## Create an R package ----
#' new_package()
#' 
#' ## Start developing functions ----
#' ## ...
#' 
#' ## Update package (documentation, dependencies, README) ----
#' refresh()
#' }

refresh <- function(compendium = NULL, make = FALSE, check = FALSE, 
                    quiet = FALSE) { 
  
  
  .Deprecated(msg = "This function is about to be removed from 'rcompendium'")
  
  is_package()
  
  stop_if_not_logical(make, check, quiet)
  
  
  ## Loading Project ----
  
  ui_title("Loading Project")
  
  suppressMessages(devtools::load_all(quiet = TRUE))
  
  if (!quiet) {
    ui_done("Loading {ui_value(get_package_name())}")
  }
  
  
  ## Update Rd files and NAMESPACE ----
  
  ui_title("Updating Documentation")
  
  suppressMessages(devtools::document(quiet = TRUE))
  
  if (!quiet) {
    ui_done("Updating {ui_value('Rd files')} and {ui_value('NAMESPACE')}")
  }
  
  
  ## Update Dependencies ----
  
  ui_title("Updating Dependencies")
  
  add_dependencies(compendium)
  
  
  ## Update Badges ----

  if (file.exists(file.path(path_proj(), "README.Rmd"))) {
    
    ui_title("Updating Badges")
    
    read_me <- readLines(con = file.path(path_proj(), "README.Rmd"))
    
    if (length(grep(paste0("^\\s{0,}\\[!\\[Dependencies"), read_me))) {
      
      add_dependencies_badge()  
    }
    
    if (length(grep(paste0("^\\s{0,}\\[!\\[License"), read_me))) {
      
      add_license_badge()  
    }
  }
  
  
  ## Update README.md ----
  
  if (file.exists(file.path(path_proj(), "README.Rmd"))) {
    
    ui_title("Updating README")
    
    rmarkdown::render(file.path(path_proj(), "README.Rmd"), 
                      output_format = "md_document", quiet = TRUE)
    
    if (!quiet) 
      ui_done("Re-kniting {ui_value('README.Rmd')}")
  }
  
  
  ## Check package integrity ----
  
  if (check) {
    
    ui_title("Checking Package")
    
    dev_msg <- suppressMessages(devtools::check(quiet = TRUE))
    
    print(dev_msg)
  }
  
  
  ## Run project (research compendium) ----
  
  if (make) {
    
    ui_title("Running Analysis")
    
    if (file.exists(file.path(path_proj(), "make.R"))) {
      
      if (!quiet) 
        ui_info("Sourcing 'make.R'}")
      
      source(file.path(path_proj(), "make.R"))
      
      if (!quiet) 
        ui_done("Done!")
      
    } else {
      
      ui_oops("Unable to find {ui_value('make.R')}")
    }
  }
  
  
  invisible(NULL)
}
