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
#' `usethis::edit_r_profile()` to open the `.Rprofile` and clean its content. 
#' **Be careful while modifying this file!**.
#'
#' @param given (optional) given name of the package maintainer
#' 
#' @param family (optional) family name of the package maintainer
#' 
#' @param email (optional) email address of the package maintainer
#' 
#' @param github (optional) GitHub pseudo/organization to host the package
#' 
#' @param orcid (optional) ORCID of the package maintainer
#' 
#' @param open a logical value. If `TRUE` the file is opened in the editor.
#'   Default is `open = FALSE`
#'
#' @export
#' 
#' @family setup functions
#'
#' @examples
#' \dontrun{
#' library(rcompendium)
#' 
#' ## Define **ONCE FOR ALL** your credentials ----
#' set_credentials("Given", "Family", "email.address@domain.com", 
#'                 github = "pseudo", orcid = "0000-0000-0000-0000")
#' }

set_credentials <- function(given = NULL, family = NULL, email = NULL, 
                            github = NULL, orcid = NULL, open = FALSE) {
  
  credentials <- as.list(match.call())[-1]
  
  path <- fs::path_home_r(".Rprofile")
  
  if (length(credentials)) {
    
    if (!file.exists(path)) {
      
      r_prof <- NULL
      
    } else {
      
      r_prof <- readLines(path)
    }
    
    r_prof <- c(r_prof, "## Credentials ----")
    
    opts <- paste0(names(credentials), " = \"", unlist(credentials), "\"")
    opts <- paste0(opts, collapse = ", ")
    
    r_prof <- c(r_prof, paste0("options(", opts, ")", ""))
    
    writeLines(r_prof, con = path)
    
    ui_done("The file {ui_value('.Rprofile')} has been successfully updated")
    ui_todo("Restart R for changes to take effect")
  }
  
  if (open) edit_file(path)
}
