#' Store credentials to the .Rprofile
#' 
#' @description 
#' This function is used to store user credentials in the `.Rprofile` file. 
#' Accepted credentials are listed below. This function is useful if user 
#' creates a lot of packages and/or research compendiums.
#' 
#' If the `.Rprofile` file does not exist this function will create it. Users
#' need to paste the content of the clipboard to this file.
#'
#' @param given A character of length 1. The given name of the project 
#'   maintainer.
#' 
#' @param family A character of length 1. The family name of the project 
#'   maintainer.
#' 
#' @param email A character of length 1. The email address of the project 
#'   maintainer.
#' 
#' @param orcid A character of length 1. The ORCID of the project maintainer.
#' 
#' @param protocol A character of length 1. The GIT protocol used to 
#'   communicate with the GitHub remote. One of `'https'` or `'ssh'`. If you 
#'   don't know, keep the default value (i.e. `NULL`) and the protocol will be 
#'   `'https'`.
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
#' 
#' ## Define **ONCE FOR ALL** your credentials ----
#' 
#' set_credentials("John", "Doe", "john.doe@domain.com", 
#'                 orcid = "9999-9999-9999-9999", protocol = "https")
#' }

set_credentials <- function(given = NULL, family = NULL, email = NULL, 
                            orcid = NULL, protocol = NULL) {
  
  
  credentials <- as.list(match.call())[-1]
  
  if (length(credentials)) {
      
    r_prof <- "## RCompendium Credentials ----"
    
    
    ## Check remote protocol ----
    
    protocol <- credentials["protocol"]$protocol
    
    if (!is.null(protocol)) {
      
      stop_if_not_string(protocol)
      
      if (!(protocol %in% c("https", "ssh"))) {
        
        protocol <- NULL
        stop("Argument 'protocol' must one among 'https' and 'ssh'.")
      }
      
      
      if (!is.null(protocol)) {
        
        usethis_protocol <- getOption("usethis.protocol")
        
        if (!is.null(usethis_protocol)) {
          
          if (usethis_protocol == protocol) {
            
            ui_oops("Protocol is already set to {ui_value(protocol)}")
            protocol <- NULL
          }
        }
      }
    }
    
    
    ## Check user credentials ----
    
    credentials <- credentials[!(names(credentials) %in% "protocol")]
    
    if (!is.null(credentials)) {

      invisible(lapply(credentials, stop_if_not_string))
      
      opts <- paste0(names(credentials), " = \"", unlist(credentials), "\"")
      opts <- paste0(opts, collapse = ", ")
      
      r_prof <- c(r_prof, paste0("options(", opts, ")", ""))
    }
    
    if (!is.null(protocol)) {
      
      opts <- paste0("usethis.protocol = \"", protocol, "\"")
      r_prof <- c(r_prof, paste0("options(", opts, ")", "")) 
    }
    
    
    ## Re-write .Rprofile ----
    
    ui_todo("Please paste the following lines to the {ui_value('.Rprofile')}:")
    usethis::ui_code_block(r_prof)
  }
  
  usethis::edit_r_profile()
  
  invisible(NULL)
}
