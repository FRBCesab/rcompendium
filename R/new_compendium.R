#' Create a research compendium
#' 
#' @description 
#' This function creates a new files/folders structure according to the
#' research compendium paradigm. The project can be (if required) installed 
#' as an R package.
#' 
#' @param status a character. One among `'concept'` (default), `'wip'`, 
#'   '`suspended'`, `'abandoned'`, `'active'`, `'inactive'`, or `'unsupported'`.
#'   This will add a Repo Status badge to the **README.Rmd**. If you don't want 
#'   to add this badge, set `status` to `NULL`. For further information see 
#'   [add_repostatus_badge()].
#'   
#' @param lifecycle **!!! __ADD__ !!!**
#' 
#' @param cran a boolean. If `TRUE` adds a CRAN version badge to the 
#'   **README.Rmd**. Default is `FALSE` (this badge is more appropriate for an 
#'   R package).
#'   
#' @param codeofconduct a boolean. If `TRUE` (default) adds a Code of Conduct 
#'   badge and a paragraph to the **README.Rmd**. The content of the Code of 
#'   Conduct is also added at the root of the project.
#'   
#' @param check **!!! __ADD__ !!!**
#' 
#' @param deploy **!!! __ADD__ !!!**
#' 
#' @param create_repo **!!! __ADD__ !!!**
#' 
#' @param given a character of length 1. User given name to be used for this 
#'   project. Default is `NULL` and the value of this parameter will be 
#'   obtained from the **.Rprofile** file (if [set_credentials()] was previously 
#'   used). For further information see [set_credentials()].
#'   
#' @param family a character of length 1. User family name to be used for this 
#'   project. Default is `NULL` and the value of this parameter will be 
#'   obtained from the **.Rprofile** file (if [set_credentials()] was previously 
#'   used). For further information see [set_credentials()].
#'   
#' @param short a character of length 1. User short name to be used for this 
#'   project. Default is `NULL` and the value of this parameter will be 
#'   obtained from the **.Rprofile** file (if [set_credentials()] was previously 
#'   used). For further information see [set_credentials()].
#'   
#' @param email a character of length 1. User email address to be used for this 
#'   project. Default is `NULL` and the value of this parameter will be 
#'   obtained from the **.Rprofile** file (if [set_credentials()] was previously 
#'   used). For further information see [set_credentials()].
#'   
#' @param orcid a character of length 1. User ORCID to be used for this 
#'   project. Default is `NULL` and the value of this parameter will be 
#'   obtained from the **.Rprofile** file (if [set_credentials()] was previously 
#'   used). For further information see [set_credentials()].
#'   
#' @param github a character of length 1. User GitHub pseudo/organization to be 
#'   used for this project. Default is `NULL` and the value of this parameter 
#'   will be obtained from the **.Rprofile** file (if [set_credentials()] was  
#'   previously used). For further information see [set_credentials()].
#'   
#' @param license a character of length 1. User preferred license to be 
#'   used for this project. Default is `NULL` and the value of this parameter 
#'   will be obtained from the **.Rprofile** file (if [set_credentials()] was  
#'   previously used). For further information see [set_credentials()].
#'   
#' @param overwrite a logical value. If a **make.R** is already present and 
#'   `overwrite = TRUE`, this file will be erased and replaced.
#' 
#' @details
#' ...
#' 
#' @export
#' 
#' @family setup functions
#' 
#' @examples 
#' \dontrun{
#' rcompendium::new_compendium()
#' }

new_compendium <- function(status = "concept", lifecycle = "experimental", 
                           cran = TRUE, codeofconduct = TRUE, check = FALSE, 
                           deploy = FALSE, create_repo = TRUE, given = NULL,
                           family = NULL, short = NULL, email = NULL, 
                           orcid = NULL, github = NULL, license = NULL, 
                           overwrite = FALSE) {
  
  ui_info("Coming soon...")
  
  invisible(NULL)
}
