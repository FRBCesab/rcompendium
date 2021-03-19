#' Store credentials to the .RProfile
#' 
#' @description 
#' This function stores user credentials in the `.Rprofile` file. Accepted 
#' credentials are listed below. This function is useful if user creates a lot
#' of packages and/or research compendiums.
#' 
#' If the `.Rprofile` file does not exist this function will create it. Note
#' that credentials are added at the end of the file: if you run this function
#' two times, credentials will be added twice. User can run the command 
#' `set_credentials(open = TRUE)` to open the `.Rprofile` and clean its 
#' content. **Be careful while modifying this file!**.
#'
#' @param given a character of length 1
#' 
#'   The given name of the package maintainer.
#' 
#' @param family a character of length 1
#' 
#'   The family name of the package maintainer.
#' 
#' @param email a character of length 1
#' 
#'   The email address of the package maintainer.
#' 
#' @param orcid a character of length 1
#' 
#'   The ORCID of the package maintainer.
#' 
#' @param protocol a character of length 1
#' 
#'   The GIT protocol used to communicate with the GitHub remote. One of 
#'   `'https'` or `'ssh'`. If you don't know, keep the default value 
#'   (i.e. `NULL`) and the protocol will be `'https'`.
#' 
#' @param open a logical value
#' 
#'   If `TRUE` the file is opened in the editor. Default is `open = FALSE`
#' 
#' @return None
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
#'                 orcid = "9999-9999-9999-9999", protocol = "ssh")
#' }

set_credentials <- function(given = NULL, family = NULL, email = NULL, 
                            orcid = NULL, protocol = NULL, open = FALSE) {
  
  
  credentials <- as.list(match.call())[-1]
  credentials <- credentials[!(names(credentials) %in% "open")]
  
  path <- fs::path_home_r(".Rprofile")
  
  if (length(credentials)) {
    
    if (!file.exists(path)) {
      
      r_prof <- NULL
      
    } else {
      
      r_prof <- readLines(path)
    }
    
    r_prof <- c(r_prof, "## RCompendium Credentials ----")
    
    
    ## Check remote protocol ----
    
    protocol <- credentials["protocol"]$protocol
    
    if (!is.null(protocol)) {
      
      stop_if_not_string(protocol)
      
      if (!(protocol %in% c("https", "ssh"))) {
        
        protocol <- NULL
        ui_oops(paste0("Protocol must one among {ui_value('https')} and ", 
                       "{ui_value('ssh')}"))
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
      
      if (!is.null(unlist(lapply(names(credentials), getOption)))) {
        
        warning("Credentials are already stored in the '.Rprofile'.\n  ", 
                "New credentials will be added but please run ", 
                "`set_credentials(open = TRUE)` to clean this file.")
      }
      
      opts <- paste0(names(credentials), " = \"", unlist(credentials), "\"")
      opts <- paste0(opts, collapse = ", ")
      
      r_prof <- c(r_prof, paste0("options(", opts, ")", ""))
    }
    
    if (!is.null(protocol)) {
      
      opts <- paste0("usethis.protocol = \"", protocol, "\"")
      r_prof <- c(r_prof, paste0("options(", opts, ")", "")) 
    }
    
    
    ## Re-write .Rprofile ----
    
    writeLines(r_prof, con = path)
    
    ui_done("The file {ui_value('.Rprofile')} has been successfully updated")
    ui_todo("Restart R for changes to take effect")
  }
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
