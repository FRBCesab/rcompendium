#' Create a research compendium
#' 
#' @description 
#' This function creates a new files-folders structure according to the
#' research compendium paradigm. The project can be (if required) installed 
#' as an R package.
#' 
#' @param status a character. One among 'concept' (default), 'wip', 
#'   'suspended', 'abandoned', 'active', 'inactive', or 'unsupported'. This will
#'   add a Repo Status badge to the **README.Rmd**. If you don't want to add 
#'   this badge, set `status` to `NULL`. For further information see 
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
#' @family core functions
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
  
  
  project_name <- get_project_name()
  
  response <- ui_yeah("Is your project name correct: {ui_value(project_name)}?", 
                      yes = "Absolutely", no = "No", n_no = 1)
  
  if (!response) {
    
    
    ## Get out ----
    
    ui_todo(paste0("Please open R/RStudio in the adequate (empty) folder ", 
                   "(create it if necessary).\n  ** The project will be named ",
                   "after this folder **"))
    
  } else {
  
    
    ## Git ----
    
    cat(clisymbols::symbol$radio_on, 
        crayon::bold(crayon::underline("Initializing Versioning")))
    ui_line()
    
    ui_line()
    if (!dir.exists(".git")) {
      gert::git_init(here::here())
      ui_done("Init {ui_value('git')} versioning")
    }
    
    if (file.exists(".gitignore")) {
      invisible(file.remove(here::here(".gitignore")))
    }
    
    add_to_gitignore()
  
    
    ## Package Structure ----
    
    ui_line()
    cat(clisymbols::symbol$radio_on, 
        crayon::bold(crayon::underline("Creating Package Structure")))
    ui_line()
    
    ui_line()
    add_to_buildignore(paste0(get_project_name(), ".Rproj"))
    
    ui_line()
    add_description(open = FALSE, overwrite = overwrite)
    ui_todo("Edit project metadata in the {ui_value('DESCRIPTION')} file")
    
    ui_line()
    ui_done("Writing {ui_value('LICENSE.md (GPL >= 2)')} file")   #######
    add_to_buildignore("LICENSE.md")
    
    ui_line()
    dir.create(here::here("R"), showWarnings = FALSE)
    ui_done("Creating {ui_value('R/')} directory")
    ui_todo("Write your R functions in the {ui_value('R/')} directory")
    
    ui_line()
    dir.create(here::here("man"), showWarnings = FALSE)
    ui_done("Creating {ui_value('man/')} directory")
    ui_todo(paste0("Use {ui_code('devtools::document()')} to add functions ", 
                   "helps in {ui_value('man/')} directory"))
    
    ui_line()
    add_package_doc()
    
    
    ## README ----
    
    ui_line()
    add_readme_rmd(type = "compendium", open = FALSE)
    add_to_buildignore("README.Rmd")
    add_to_buildignore("README.html")
    ui_todo(paste0("Edit the {ui_value('README.Rmd')} and do not forget to ", 
                   "knit it into a {ui_value('README.md')}"))
    
    
    ## Badges ----
    
    if (check) add_github_actions_badge()
    if (cran) add_cran_badge()
    add_license_badge(license)
    if (!is.null(status)) add_repostatus_badge(status)
    if (!is.null(lifecycle)) add_lifecycle_badge(lifecycle)
    if (codeofconduct) add_codeofconduct_badge()
    
    
    ## Compendium ----
    
    ui_line()
    cat(clisymbols::symbol$radio_on, 
        crayon::bold(crayon::underline("Creating Compendium")))
    ui_line()
    
    ui_line()
    add_makefile(open = FALSE, overwrite = overwrite)
    add_to_buildignore("make.R")
    ui_todo(paste0("Call your R scripts with {ui_code('source()')} in the ", 
                   "{ui_value('make.R')} file"))
    
    ui_line()
    dir.create(here::here("analysis"), showWarnings = FALSE)
    ui_done("Creating {ui_value('analysis/')} directory")
    add_to_buildignore("analysis")
    
    ui_line()
    dir.create(here::here("analysis", "data"), showWarnings = FALSE)
    ui_done("Creating {ui_value('analysis/data/')} directory")
    ui_todo(paste0("Add your raw data in the ",
                   "{ui_value('analysis/data/')} directory"))
    
    ui_line()
    dir.create(here::here("analysis", "rscripts"), showWarnings = FALSE)
    ui_done("Creating {ui_value('analysis/rscripts/')} directory")
    ui_todo(paste0("Add your analyses (R scripts) in the ", 
                   "{ui_value('analysis/rscripts/')} directory"))
    
    ui_line()
    dir.create(here::here("analysis", "outputs"), showWarnings = FALSE)
    ui_done("Creating {ui_value('analysis/outputs/')} directory")
    ui_todo(paste0("Export your results in the ", 
                   "{ui_value('analysis/outputs/')} directory"))
    
    ui_line()
    dir.create(here::here("analysis", "figures"), showWarnings = FALSE)
    ui_done("Creating {ui_value('analysis/figures/')} directory")
    ui_todo(paste0("Export your figures in the ", 
                   "{ui_value('analysis/figures/')} directory"))
    
    
    ## End ----
    
    ui_line()
    cat(clisymbols::symbol$radio_on, 
        crayon::bold(crayon::underline("Done!")))
    ui_line()
  }  
  
  invisible(NULL)
}
