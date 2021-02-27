#' Store credentials to the .RProfile
#' 
#' @description 
#' This function stores user credentials in the **.Rprofile** file. Accepted 
#' credentials are listed below. This function is useful if user creates a lot
#' of packages and/or research compendiums.
#' 
#' If the **.Rprofile** file does not exist this function will create it. Note
#' that credentials are added at the end of the file: if you run this function
#' two times, credentials will be added twice. User can run the command 
#' `usethis::edit_r_profile()` to open the **.Rprofile** and clean its content. 
#' **Be careful when modifying this file!**.
#'
#' @param given (optional) user given name (i.e. "Nicolas")
#' @param family (optional) user family name (i.e. "Casajus")
#' @param short (optional) user short name (e.g. "Casajus N.")
#' @param email (optional) user email address (i.e. "nicolas.casajus@gmail.com")
#' @param orcid (optional) user ORCID (i.e. "0000-0002-5537-5294")
#' @param github (optional) user GitHub pseudo/organization (i.e. "ahasverus")
#' @param license (optional) user preferred license (i.e. "GPL (>= 2)")
#'
#' @export
#' 
#' @family setup projects
#'
#' @examples
#' \dontrun{
#' set_credentials(given = "Nicolas", family = "Casajus", short = "Casajus N.",
#'                 email = "nicolas.casajus@gmail.com", github = "ahasverus", 
#'                 orcid = "0000-0002-5537-5294", license = "GPL (>= 2)")
#' }

set_credentials <- function(given = NULL, family = NULL, short = NULL, 
                            email = NULL, orcid = NULL, github = NULL, 
                            license = NULL) {
  
  credentials <- as.list(match.call())[-1]
  
  if (length(credentials)) {
    
    if (!file.exists(fs::path_home_r(".Rprofile"))) {
      
      r_prof <- NULL
      
    } else {
      
      r_prof <- readLines(fs::path_home_r(".Rprofile"))
    }
    
    r_prof <- c(r_prof, "## Credentials ----")
    
    opts <- paste0(names(credentials), " = \"", unlist(credentials), "\"")
    opts <- paste0(opts, collapse = ", ")
    
    r_prof <- c(r_prof, paste0("options(", opts, ")", ""))
    
    writeLines(r_prof, con = fs::path_home_r(".Rprofile"))
    
    ui_done("The file {ui_value('.Rprofile')} has been successfully updated")
    ui_todo("Restart R for changes to take effect")
  }
}
