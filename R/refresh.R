#' Refresh a package/research compendium
#' 
#' @description 
#' This function refreshes a package/research compendium. It will:
#' * Update `.Rd` files and `NAMESPACE`, using [devtools::document()];
#' * Update external packages (in `DESCRIPTION` file);
#' * Update badges in `README.Rmd` (if already present);
#' * Re-knitr the `README.Rmd`, using [rmarkdown::render()];
#' * Check package integrity with [devtools::check()].
#' 
#' @param quiet a logical value. If `TRUE` (default) no message are printed.
#' 
#' @param check a logical value. If `TRUE` (default) package integrity is 
#'   checked using [devtools::check()].
#'  
#' @inheritParams add_dependencies
#' 
#' @export
#' 
#' @family setup functions
#' 
#' @examples 
#' \dontrun{
#' rcompendium::refresh()
#' }

refresh <- function(quiet = FALSE, check = TRUE, import = NULL) { 
  
  is_package()
  
  ## Update Rd files and NAMESPACE ----
  
  ui_title("Updating Documentation")
  
  devtools::document(quiet = TRUE)
  
  if (!quiet) {
    ui_line()
    ui_done("Updating {ui_value('Rd files')} and {ui_value('NAMESPACE')}")
  }
  
  
  ## Update Dependencies ----
  
  ui_title("Updating Dependencies")
  
  add_dependencies(import = import)
  
  
  ## Update Badges ----

  if (file.exists(here::here("README.Rmd"))) {
    
    ui_title("Updating Badges")
    
    read_me <- readLines(con = here::here("README.Rmd"))
    
    if (length(grep(paste0("^\\s{0,}\\[!\\[Dependencies"), read_me))) {
      
      add_dependencies_badge()  
    }
    
    if (length(grep(paste0("^\\s{0,}\\[!\\[License"), read_me))) {
      
      add_license_badge()  
    }
  }
  
  
  ## Update README.md ----
  
  if (file.exists(here::here("README.Rmd"))) {
    
    ui_title("Updating README")
    
    rmarkdown::render(here::here("README.Rmd"), output_format = "md_document",
                      quiet = TRUE)
    
    if (!quiet) 
      ui_done("Re-kniting {ui_value('README.Rmd')}")
  }
  
  
  ## Check package integrity ----
  
  if (check) {
    
    ui_title("Checking package")
    
    dev_msg <- devtools::check(quiet = TRUE)
    
    ui_line()
    
    print(dev_msg)
  }
  
  invisible(NULL)
}
