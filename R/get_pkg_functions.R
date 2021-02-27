#' List all functions in the package
#' 
#' @description
#' This function returns a list of all the functions (exported and internal) 
#' available with the package. As this function scans the **NAMESPACE** it is
#' recommended to update this file with [devtools::document()].
#' 
#' @return 
#' A vector of internal and external (exported) functions of the packages.
#' Exported functions are noted `pkg::fun()` while internal functions are noted 
#' `pkg:::fun()`.
#' 
#' @family utilitaries functions
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' devtools::document()
#' get_pkg_functions()
#' }

get_pkg_functions <- function() {
  
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
    
    
    ## Extract function names ----
    
    x <- lapply(x, function(x) x[grep(" (<-|=) function\\(", x)])
    x <- lapply(x, function(x) gsub("\\s{0,}(<-|=)\\s{0,}function.*", "", x))
    
    x <- unlist(x)
    x <- gsub("\\s", "", x)
    x <- sort(unlist(x))
    
    
    if (length(x)) {
      
      if (file.exists(here::here("NAMESPACE"))) {
        
        namespace <- readLines(con = here::here("NAMESPACE"), warn = FALSE)
        
        exports <- gsub("export\\(|\\)", "", 
                        namespace[grep("^export", namespace)])
        
        if (length(exports)) {
          
          funs <- c(
            paste0(get_project_name(), "::", 
                   x[(x %in% exports)], "()"),
            
            paste0(get_project_name(), ":::", 
                   x[!(x %in% exports)], "()")
          )
          
        } else {
          
          funs <- paste0(get_project_name(), ":::", x, "()")
        }
        
      } else {
        
        funs <- paste0(get_project_name(), ":::", x, "()")
      }
      
      return(funs)
      
    } else {
      
      return(NULL)
    }
  }
}
