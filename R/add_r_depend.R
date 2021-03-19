#' Add minimal R version to DESCRIPTION
#' 
#' @description 
#' This function adds the minimal R version to the `Depends` field of the 
#' `DESCRIPTION` file. This version corresponds to the higher version of R 
#' among all dependencies. If no dependencies mentions minimal R version, the
#' `DESCRIPTION` is not modified.
#' 
#' @return None
#'
#' @export
#' 
#' @family development functions
#'
#' @examples
#' \dontrun{
#' add_r_depend()
#' }

add_r_depend <- function() {
  
  r_version <- get_minimal_r_version()
  
  if (!is.null(r_version)) {
    
    r_version <- paste0("R (>= ", r_version, ")")
    
    descr <- read_descr()
    
    if (is.null(descr$"Depends")) {   # No Depends field
      
      descr$"Depends" <- r_version
      
    } else {
      
      depends <- unlist(strsplit(descr$"Depends", "\n\\s+|,|,\\s+"))
      
      is_r <- grep("R \\(.*\\)", depends)
      
      if (length(is_r)) {            # No R version mentioned
        
        depends[is_r] <- r_version
        
      } else {                       # R version mentioned
        
        depends <- c(r_version, depends)
      }
      
      descr$"Depends" <- paste0(depends, collapse = ", ")
    }
    
    write_descr(descr)
    ui_done(paste0("Adding the following line to {ui_value('DESCRIPTION')}: ", 
                   "{ui_code(paste('Depends:', r_version))}"))
  
  } else {
    
    ui_done(paste0("No minimal R version detected"))
  }
  
  invisible(NULL)
}
