#' List all Rd function families
#' 
#' @description 
#' This function parses all R functions to detect `@family` tag.
#' 
#' @return A vector of Rd function families.
#' 
#' @export
#' 
#' @family utilities functions
#'
#' @examples
#' \dontrun{
#' get_rd_families()
#' }

get_rd_families <- function() {
  
  if (!dir.exists(here::here("R"))) {
    stop("The directory 'R/' cannot be found.")
  }
  
  
  x <- list.files(path = here::here("R"), pattern = "\\.R$", 
                  full.names = TRUE, ignore.case = TRUE)
  
  
  if (!length(x)) {
    
    ui_oops("The {ui_value('R/')} folder is empty")
    
    return(NULL)
    
  } else {
    
    
    ## Read R files ----
    
    x <- lapply(x, function(x) readLines(con = x, warn = FALSE))
    
    
    ## Extract families names ----
    
    x <- lapply(x, function(x) x[grep("#'\\s{0,}@family", x)])
    x <- lapply(x, function(x) gsub("#'\\s{0,}@family ", "", x))
    
    return(sort(unique(unlist(x))))
  }
}