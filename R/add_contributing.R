#' Add contribution guidelines
#' 
#' @description 
#' This function creates several files to help the user to learn how to 
#' contribute to the project:
#' - `CONTRIBUTING.md`: general guidelines outlining the best way to contribute
#' to the project (can be modified);
#' - `.github/ISSUE_TEMPLATE/bug_report.md`: an issue template to report a bug
#' (can be modified);
#' - `.github/ISSUE_TEMPLATE/feature_request.md`: an issue template to suggest
#' a new feature (can be modified);
#' - `.github/ISSUE_TEMPLATE/other_issue.md`: an issue template for all other
#' types of issue (can be modified).
#' 
#' @param organisation A character of length 1. The name of the GitHub 
#'   organisation to host the package. If `NULL` (default) the GitHub account 
#'   will be used. This argument is used to set the URL of the package 
#'   (hosted on GitHub).
#'   
#' @param open A logical value. If `TRUE` (default) the `CONTRIBUTING.md` file 
#'   is opened in the editor.
#' 
#' @param overwrite A logical value. If files are already present and 
#'   `overwrite = TRUE`, they will be erased and replaced. Default is `FALSE`.
#'   
#' @param quiet A logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#' 
#' @inheritParams set_credentials
#' 
#' @return No return value.
#' 
#' @export
#' 
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_contributing()
#' }

add_contributing <- function(email = NULL, organisation = NULL, open = TRUE, 
                             overwrite = FALSE, quiet = FALSE) { 
  
  
  stop_if_not_logical(open, overwrite, quiet)
  
  path <- file.path(path_proj(), "CONTRIBUTING.md")
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
    
    if (!open) {
      
      stop("A 'CONTRIBUTING.md' file is already present. If you want to ",
           "replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  
  
  ## Get fields values ----
  
  if (is.null(email)) email <- getOption("email")
  
  if (!is.null(organisation)) {
    
    github <- organisation
    
  } else {
    
    github <- gh::gh_whoami()$"login"
    
    if (is.null(github)) {
      stop("Unable to find GitHub username. Please run ", 
           "`?gert::git_config_global` for more information.")
    }
  }
  
  stop_if_not_string(email, github)
  
  
  project_name <- get_package_name()
  branch       <- get_git_branch_name()
  
  
  ## Copy Template ----
  
  invisible(
    file.copy(system.file(file.path("templates", "CONTRIBUTING.md"), 
                          package = "rcompendium"), path, overwrite = TRUE))
  
  
  ## Change defaults values ----
  
  xfun::gsub_file(path, "{{project_name}}", project_name, fixed = TRUE)
  xfun::gsub_file(path, "{{branch}}", branch, fixed = TRUE)
  xfun::gsub_file(path, "{{email}}", email, fixed = TRUE)
  xfun::gsub_file(path, "{{github}}", github, fixed = TRUE)
  
  
  ## Messages ----
  
  if (!quiet) {
    ui_done("Writing {ui_value('CONTRIBUTING.md')} file")
  }
  
  add_to_buildignore("CONTRIBUTING.md", quiet = quiet)
  
  
  ## Copying ISSUE TEMPLATES ----
  
  if (!dir.exists(file.path(path_proj(), ".github", "ISSUE_TEMPLATE"))) {
    
    dir.create(file.path(path_proj(), ".github", "ISSUE_TEMPLATE"), 
               showWarnings = FALSE, recursive = TRUE)
    
    add_to_buildignore(".github")
  }
    
  
  template_names <- c("bug_report.md", "feature_request.md", "other_issue.md")
  
  for (template_name in template_names) {
    
    path_issue <- file.path(path_proj(), ".github", "ISSUE_TEMPLATE", 
                            template_name)
    
    path_issue_msg <- file.path(".github", "ISSUE_TEMPLATE", template_name)
    
    if (file.exists(path_issue) && !overwrite) {
      stop(paste0("A '", path_issue_msg, "' file is already present. If you ",
                  "want to replace it, please use `overwrite = TRUE`."))
    }
    
    invisible(
      file.copy(system.file(file.path("templates", template_name), 
                            package = "rcompendium"), path_issue, 
                overwrite = TRUE))
    
    if (!quiet) {
      ui_done(paste0("Writing {ui_value('", path_issue_msg, 
                               "')} file"))
    }
  }
  
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
