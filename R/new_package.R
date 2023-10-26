#' Create an R package structure
#' 
#' @description 
#' This function creates a new R package structure according to the current 
#' best practices.
#' Essential features of an R package are created (`DESCRIPTION` and
#' `NAMESPACE` files, and `R/` and `man/` folders). The project is also 
#' **versioned with git** and a generic R `.gitignore` is added.
#' 
#' **IMPORTANT -** Before using this function user needs to create a new folder 
#' (or a new project if using RStudio) and run this function inside this folder 
#' (by using [setwd()] or by opening the `Rproj` in a new RStudio session).
#' **The name of the package will be the same as the name of this folder**. 
#' Some rules must be respected: 
#' \url{https://r-pkgs.org/workflow101.html#name-your-package}.
#' 
#' Some fields of the `DESCRIPTION` file (maintainer information, package name, 
#' license, URLs, and  `roxygen2` version)  are automatically filled but
#' others (like title and description) need to be edited manually.
#' 
#' Additional features are also created: a `CITATION` file, a `README.Rmd`, and
#' `tests/` and `vignettes/` folders (optional). See the vignette 
#' [Get started](
#' https://frbcesab.github.io/rcompendium/articles/rcompendium.html) 
#' for a complete overview of the full structure.
#' 
#' A GitHub repository can also be created (default) following the 
#' "GitHub last" workflow
#' (\url{https://happygitwithr.com/existing-github-last.html}).
#' Configuration files for GitHub Actions to automatically 1) check the 
#' package, 2) test and report code coverage, and 3) deploy the website using
#' [`pkgdown`](https://pkgdown.r-lib.org/index.html) 
#' will be added in the `.github/` folder. See below the section 
#' **Creating a GitHub repo**.
#' 
#' @param license A character vector of length 1. The license to be used for 
#'   this package. Run [get_licenses()] to choose an appropriate one. 
#'   Default is `license = 'GPL (>= 2)'` 
#'   
#'   The license can be changed later by calling [add_license()] (and 
#'   [add_license_badge()] or [refresh()] to update the corresponding badge in
#'   the README).
#' 
#' @param status A character vector of length 1. The status of the project 
#'   according to the standard defined by the  \url{https://www.repostatus.org} 
#'   project. One among `'concept'`, `'wip'`, `'suspended'`, 
#'   `'abandoned'`, `'active'`, `'inactive'`, or `'unsupported'`. 
#'   See [add_repostatus_badge()] for further information. 
#'   
#'   This argument is used to add a badge to the `README.Rmd` to help visitors 
#'   to better understand your project. If you don't want this badge use 
#'   `status = NULL` (default). 
#'   
#'   This status can be added/changed later by using [add_repostatus_badge()].
#' 
#' @param lifecycle A character vector of length 1. The life cycle stage of the 
#'   project according to the standard defined at  
#'   \url{https://lifecycle.r-lib.org/articles/stages.html}. One among 
#'   `'experimental'`, `'stable'`, `'deprecated'`, or `'superseded'`.
#'   See [add_lifecycle_badge()] for further information. 
#'   
#'   This argument is used to add a badge to the `README.Rmd` to help visitors 
#'   to better understand your project. If you don't want this badge use 
#'   `lifecycle = NULL` (default). 
#'   
#'   This stage can be added/changed later by using [add_lifecycle_badge()].
#' 
#' @param contributing A logical value. If `TRUE` (default) adds a 
#'   `CONTRIBUTING.md` file and `ISSUE_TEMPLATES`. See [add_contributing()] for
#'   further information.
#' 
#' @param code_of_conduct A logical value. If `TRUE` (default) adds a 
#'   `CODE_OF_CONDUCT.md` file. See [add_code_of_conduct()] for further 
#'   information.
#' 
#' @param vignette A logical value. If `TRUE` (default) creates a vignette in 
#'   `vignettes/`. Packages [`knitr`](https://yihui.org/knitr/) and 
#'   [`rmarkdown`](https://rmarkdown.rstudio.com/) are also added to the 
#'   `Suggests` field in the `DESCRIPTION` file.
#' 
#' @param test A logical value. If `TRUE` (default) initializes units tests by 
#'   running [usethis::use_testthat()]. Package 
#'   [`testthat`](https://testthat.r-lib.org) is also added to the `Suggests` 
#'   field in the `DESCRIPTION` file.
#' 
#' @param create_repo A logical value. If `TRUE` (default) creates a repository
#'   (public if `private = FALSE` or private if `private = TRUE`) on GitHub. 
#'   See below the section **Creating a GitHub repo**.
#' 
#' @param private A logical value. If `TRUE` creates a private repository on 
#'   user GitHub account (or organisation). Default is `private = FALSE`.
#' 
#' @param gh_check A logical value. If `TRUE` (default) configures GitHub 
#'   Actions to automatically check and test the package after each push. This 
#'   will run `R CMD check` on the three major operating systems (Ubuntu, macOS,
#'   and Windows) on the latest release of R. See [add_github_actions_check()] 
#'   for further information. 
#'   
#'   If `create_repo = FALSE` this argument is ignored.
#'   
#' @param gh_render A logical value. If `TRUE` (default) configures GitHub 
#'   Actions to automatically knit the `README.Rmd` after each push. 
#'   See [add_github_actions_render()] for further information. 
#'   
#'   If `create_repo = FALSE` this argument is ignored.
#'   
#' @param gh_citation A logical value. If `TRUE` (default) configures GitHub 
#'   Actions to automatically update the `CITATION.cff` file. 
#'   See [add_github_actions_citation()] for further information. 
#'   
#'   If `create_repo = FALSE` this argument is ignored.
#' 
#' @param codecov A logical value. If `TRUE` (default) configures GitHub 
#'   Actions to automatically report the code coverage of units tests after 
#'   each push. See [add_github_actions_codecov()] for further information. 
#'   
#'   If `create_repo = FALSE` this argument is ignored.
#'   
#' @param website A logical value. If `TRUE` (default) configures GitHub 
#'   Actions to automatically build and deploy the package website 
#'   (using [`pkgdown`](https://pkgdown.r-lib.org/index.html)) 
#'   after each push. A **gh-pages** branch will be created using 
#'   [usethis::use_github_pages()] and the GitHub repository will be 
#'   automatically configured to deploy website.
#'   
#'   If `create_repo = FALSE` this argument is ignored.
#' 
#' @param given A character vector of length 1. The given name of the 
#'   maintainer of the package. If `NULL` (default) the function will try to 
#'   get this value by reading the `.Rprofile` file. 
#'   
#'   For further information see [set_credentials()] and below the section 
#'   **Managing credentials**.
#' 
#' @param family A character vector of length 1. The family name of the 
#'   maintainer of the package. If `NULL` (default) the function will try to 
#'   get this value by reading the `.Rprofile` file. 
#'   
#'   For further information see [set_credentials()] and below the section 
#'   **Managing credentials**.
#' 
#' @param email A character vector of length 1. The email address of the 
#'   maintainer of the package. If `NULL` (default) the function will try to 
#'   get this value by reading the `.Rprofile` file. 
#'   
#'   For further information see [set_credentials()] and below the section 
#'   **Managing credentials**.
#' 
#' @param orcid A character vector of length 1. The ORCID of the maintainer of 
#'   the package. If `NULL` (default) the function will try to get this value 
#'   by reading the `.Rprofile` file. 
#'   
#'   For further information see [set_credentials()] and below the section 
#'   **Managing credentials**.
#' 
#' @param organisation A character vector of length 1. The GitHub organisation 
#'   to host the repository. If defined it will overwrite the GitHub pseudo.
#' 
#'   Default is `organisation = NULL` (the GitHub pseudo will be used).
#' 
#' @param overwrite A logical value. If `TRUE` files written from templates and 
#'   modified by user are erased. Default is `overwrite = FALSE`. 
#'   **Be careful while using this argument**.
#' 
#' @param quiet A logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#'   
#' @return No return value.
#'
#'
#' @section Recommended workflow:
#' 
#' 
#' The purpose of the package `rcompendium` is to make easier the creation of R
#' package/research compendium so that user can focus on the code/analysis 
#' instead of wasting time organizing files.
#' 
#' The recommended workflow is:
#' 1. Create an empty RStudio project;
#' 2. Store your credentials with [set_credentials()] (if not already done);
#' 3. Run [new_package()] to create a new package structure (and the GitHub 
#'   repository);
#' 4. Edit some metadata in `DESCRIPTION`, `CITATION`, and `README.Rmd`;
#' 5. Implement, document & test functions (the fun part);
#' 6. Update the project (update `.Rd` files, `NAMESPACE`, external 
#'   dependencies in `DESCRIPTION`, re-knit `README.Rmd`, and check package 
#'   integrity) with [refresh()];
#' 7. Repeat steps 5 and 6 while developing the package.
#' 
#' 
#' @section Managing credentials:
#' 
#' 
#' You can use the arguments `given`, `family`, `email`, and `orcid`
#' directly with the function [new_package()] (and others). But if you create 
#' a lot a projects (packages and/or compendiums) it can be frustrating in the 
#' long run.
#' 
#' An alternative is to use **ONCE AND FOR ALL** the function 
#' [set_credentials()] to permanently store this information in the 
#' `.Rprofile` file. If these arguments are set to `NULL` (default) each 
#' function of the package `rcompendium` will search in this `.Rprofile` file.
#' It will save your time (it's the purpose of this package).
#' 
#' Even if you have stored your information in the `.Rprofile` file you will 
#' always be able to modify them on-the-fly (i.e. by using arguments of the
#' [new_package()]) or permanently by re-running [set_credentials()].
#' 
#' 
#' @section Configuring git:
#' 
#' 
#' First run [gh::gh_whoami()] to see if your git is correctly configured. If 
#' so you should see something like:
#' 
#' ```
#' {
#'   "name": "John Doe",
#'   "login": "jdoe",
#'   "html_url": "https://github.com/jdoe",
#'   ...
#' }
#' ```
#' 
#' Otherwise you might need to run:
#' 
#' ```
#' gert::git_config_global_set(name  = "user.name", 
#'                             value = "John Doe")
#'                             
#' gert::git_config_global_set(name  = "user.email", 
#'                             value = "john.doe@@domain.com")
#'                             
#' gert::git_config_global_set(name  = "github.user", 
#'                             value = "jdoe")
#' ```
#' 
#' See [gert::git_config_global_set()] for further information.
#' 
#' 
#' @section Creating a GitHub repo:
#' 
#' 
#' To create the GitHub repository directly from R, the package `rcompendium` 
#' uses the function [usethis::use_github()], an client to the GitHub REST API. 
#' The interaction with this API required an authentication method: a 
#' **GITHUB PAT** (Personal Access Token).
#' 
#' If you don't have a **GITHUB PAT** locally stored, you must:
#' 1. Obtain a new one from your GitHub account. **Make sure to select 
#' at least the first two scopes (private repository and workflow)**
#' 2. Store it in the `~/.Renviron` file by using [usethis::edit_r_environ()] 
#' and adding the following line: `GITHUB_PAT='ghp_99z9...z9'`
#' 
#' Run [usethis::gh_token_help()] for more information about getting and 
#' configuring a **GITHUB PAT**.
#' 
#' If everything is well configured you should see something like this after 
#' calling [gh::gh_whoami()]:
#' 
#' ```
#' {
#'   "name": "John Doe",
#'   "login": "jdoe",
#'   "html_url": "https://github.com/jdoe",
#'   "scopes": "delete_repo, repo, workflow",
#'   "token": "ghp_99z9...z9"
#' }
#' ```
#' 
#' And you will be able to create a GitHub repository directly from R!
#' 
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
#' set_credentials(given = "John", family = "Doe", 
#'                 email = "john.doe@@domain.com", 
#'                 orcid = "9999-9999-9999-9999", protocol = "ssh")
#'
#' ## Create an R package ----
#' new_package()
#' 
#' ## Start developing functions ----
#' ## ...
#' 
#' ## Update package (documentation, dependencies, README, check) ----
#' refresh()
#' }

new_package <- function(license = "GPL (>= 2)", status = NULL, 
                        lifecycle = NULL, contributing = TRUE,
                        code_of_conduct = TRUE, vignette = TRUE, 
                        test = TRUE, create_repo = TRUE, private = FALSE, 
                        gh_check = TRUE, codecov = TRUE, website = TRUE, 
                        gh_render = TRUE, gh_citation = TRUE, given = NULL, 
                        family = NULL, email = NULL, orcid = NULL, 
                        organisation = NULL, overwrite = FALSE, quiet = FALSE) {
  
  
  ## If not RStudio ----
  
  if (!rstudioapi::isAvailable()) {
    if (!file.exists(".here")) file.create(".here")
  }
  
  
  ## Check for inceptions ----
  
  git_in_git()
  proj_in_proj()
  
  if (!is_valid_name()) stop("Invalid package name.")
  
  
  ## Check if git is well configured ----
  
  github <- gh::gh_whoami()$"login"
  
  if (is.null(github)) {
    stop("Unable to find GitHub username. Please run ", 
         "`?gert::git_config_global` for more information.")
  }
  
  
  ## Check for package name ----
  
  project_name <- get_package_name()

  
  
  ## Check License ----
  
  if (!length(which(licenses$tag == license))) {
    stop("Invalid license. Please use `get_licenses()` to choose an ",
         "appropriate one.")
  }
  
  
  ## Check mandatory credentials ----
  
  if (is.null(given)) {
    
    given <- getOption("given")
    if (is.null(given)) {
      stop("Please provide a given name. Use `set_credentials()` to ", 
           "store it permanently or use the argument `given`.")
    }
  }
  
  if (is.null(family)) {
    family <- getOption("family")
    if (is.null(family)) {
      stop("Please provide a family name. Use `set_credentials()` to ", 
           "store it permanently or use the argument `family`.")
    }
  }
  
  if (is.null(email)) {
    email <- getOption("email")
    if (is.null(email)) {
      stop("Please provide an email address. Use `set_credentials()` to ", 
           "store it permanently or use the argument `email`.")
    }
  }
  
  
  ## Check if GitHub Pseudo / Organisation exists ----
  
  if (!is.null(organisation)) {
    
    is_gh_organisation(organisation)
    
  } else {
    
    is_gh_user()
  }
  
  
  ## Check GITHUB PAT & Available Repo ----
  
  if (create_repo) {
    
    if (gh::gh_token() == "") {
      stop("No GITHUB PAT found. Please run `usethis::gh_token_help()` for ", 
           "further information or read the vignette.")
    }
    
    if (!is.null(organisation)) {
      
      if (!is.null(is_gh_repo(organisation, project_name))) {
        
        github_url <- paste0("https://", "github.com/", organisation, "/", 
                             project_name)
        stop("Repository < ", github_url, " > already exists.")
      }
      
    } else {
      
      if (!is.null(is_gh_repo(github, project_name))) {
        
        github_url <- paste0("https://", "github.com/", github, "/", 
                             project_name)
        stop("Repository < ", github_url, " > already exists.")
      }
    }
    
  } else {
    
    gh_check    <- FALSE
    codecov     <- FALSE
    website     <- FALSE
    gh_render   <- FALSE
    gh_citation <- FALSE
  }
  
  
  stop_if_not_logical(test)
  
  if (!test) codecov  <- FALSE
  
  
  
  ## Check Repo Status ----
  
  if (!is.null(status)) {
    if (!(tolower(status) %in% c("concept", "wip", "suspended", "abandoned", 
                                 "active", "inactive", "unsupported"))) {
      
      stop("Invalid Repo status. Please run `?add_repostatus_badge` to ",
           "select an appropriate one.")
    }  
  }
  
  
  ## Check Life cycle ----
  
  if (!is.null(lifecycle)) {
    if (!(tolower(lifecycle) %in% c("experimental", "stable", "deprecated", 
                                    "superseded"))) {
      
      stop("Invalid Life cycle. Please run `?add_lifecycle_badge` to ",
           "select an appropriate one.")
    }  
  }
  
  
  
  ## ... End of Checks ----
  
  
  
  ##
  ## INITIALIZING VERSIONING ----
  ## 
    
  
  
  ui_title("Initializing Versioning")
  
  
  ## Init GIT (if required) ----
  
  if (!is_git()) {
    
    gert::git_init(file.path(path_proj()))
    ui_done("Init {ui_value('git')} versioning")
  }
  
  
  ## Add/Replace R-specific gitignore ----
  
  if (file.exists(file.path(path_proj(), ".gitignore"))) {
  
      invisible(file.remove(file.path(path_proj(), ".gitignore")))
  }
  
  add_to_gitignore()
  
  
  
  ##
  ## CREATING PACKAGE STRUCTURE ----
  ## 
  
  
  
  ui_title("Creating Package Structure")
  
  
  ## Ignore files for R CMD ----
  
  add_to_buildignore(paste0(project_name, ".Rproj"), quiet = quiet)
  add_to_buildignore(".Rproj.user", quiet = quiet)
  add_to_buildignore(".DS_Store", quiet = quiet)
  
  if (!quiet) ui_line()
  
  
  ## Create DESCRIPTION ----
  
  add_description(given, family, email, orcid, organisation, open = FALSE, 
                  overwrite = overwrite, quiet = quiet)
  
  if (!quiet) ui_line()
  
  
  ## Add LICENSE ----
  
  add_license(license, given, family, quiet = quiet)
  
  if (!quiet) ui_line()
  
  
  ## Create folders ----
  
  dir.create(file.path(path_proj(), "R"), showWarnings = FALSE)
  
  if (!quiet) ui_done("Creating {ui_value('R/')} directory")
  
  
  dir.create(file.path(path_proj(), "man"), showWarnings = FALSE)
  
  if (!quiet) ui_done("Creating {ui_value('man/')} directory")
  
  if (!quiet) ui_line()
  
  
  ## Package doc bonus ----
  
  add_package_doc(open = FALSE, overwrite = overwrite, quiet = quiet)
  
  add_citation(given, family, organisation, open = FALSE, 
               overwrite = overwrite, quiet = quiet)
  
  
  ## Demo R function ----
  
  if (!file.exists(file.path(path_proj(), "R", "fun-demo.R"))) {
    
    invisible(
      file.copy(system.file(file.path("templates", "fun-demo.R"), 
                            package = "rcompendium"), 
                file.path(path_proj(), "R", "fun-demo.R"), 
                overwrite = overwrite)) 
  }
  
  if (!quiet) ui_line()
  if (!quiet) ui_done("Writing {ui_value('R/fun-demo.R')} file")
  
  suppressMessages(devtools::document(quiet = TRUE))
  
  
  
  ##
  ## ADDING TESTTHAT ----
  ## 
  
  
  if (test) {
    
    ui_title("Adding Testthat")
    
    add_testthat()
  }
  
  
  
  ##
  ## ADDING VIGNETTE ----
  ## 
  
  
  if (vignette) {
    
    ui_title("Adding Vignette")
    
    add_vignette(open = FALSE, overwrite = overwrite, quiet = quiet)
  }

  
  
  ##
  ## ADDING CONTRIBUTING ----
  ## 
  
  
  if (contributing) {
    
    ui_title("Adding Contributing")
    
    add_contributing(email = email, organisation = organisation, open = FALSE, 
                     overwrite = overwrite, quiet = quiet)
  } 
  
  
  
  ##
  ## ADDING CODE OF CONDUCT ----
  ## 
  
  
  if (code_of_conduct) {
    
    ui_title("Adding Code of conduct")
    
    add_code_of_conduct(email = email, open = FALSE, overwrite = overwrite, 
                        quiet = quiet)
  }
  
  
  
  ##
  ## ADDING README ----
  ## 
  
  
  
  ui_title("Adding README")
  
  
  
  add_readme_rmd(type = "package", given, family, organisation, open = FALSE, 
                 overwrite = overwrite, quiet = quiet)
  
  add_sticker(type = "package", overwrite = overwrite, quiet = quiet)
  
  
  
  ##
  ## KNITING README ----
  ## 
  
  
  
  ui_title("Kniting README")  
  
  
  rmarkdown::render(file.path(path_proj(), "README.Rmd"), 
                    output_format = "md_document", quiet = TRUE)
  
  if (!quiet) ui_done("Kniting {ui_value('README.Rmd')}")
  
  
  
  ##
  ## FIRST COMMIT ----
  ## 
  
  
  
  ui_title("Committing changes")  
  
  
  ## Commit changes ----
  
  invisible(gert::git_add("."))
  invisible(gert::git_commit("init repo"))

  if (!quiet) {
    ui_done(paste0("Committing changes with the following message: ", 
                   "{ui_value('init repo')}"))
  }
  
  
  
  ##
  ## CREATING GITHUB REPOSITORY ----
  ## 
  
  
  
  if (create_repo) {
    
    ui_title("Creating GITHUB Repository")
    
    
    ## Create GitHub repo ----
    
    usethis::use_github(organisation = organisation, private = private)
    
    
    ## Update GitHub repo fields ----
    
    owner <- ifelse(is.null(organisation), github, organisation)
    update_gh_repo(owner, repo = project_name, website = website, 
                   quiet = quiet)
  }
  
  
  
  ##
  ## GHA R-CMD-Check ----
  ## 
  
  
  
  if (gh_check) {
    
    ui_title("Configuring GH Actions - R CMD CHECK")
    
    add_github_actions_check(quiet = quiet)
  }
  
  
  
  ##
  ## GHA Code coverage ----
  ## 
  
  
  
  if (codecov) {
    
    ui_title("Configuring GH Actions - Code Coverage")
    
    add_github_actions_codecov(quiet = quiet)
  }
  
  
  
  ##
  ## GHA Render README ----
  ## 
  
  
  
  if (gh_render) {
    
    ui_title("Configuring GH Actions - Render README")
    
    add_github_actions_render(quiet = quiet)
  }
  

  
  ##
  ## GHA Website deployment ----
  ## 
  

  
  if (website) {
    
    ui_title("Configuring GH Actions - Website deployment")
    
    add_github_actions_pkgdown()
    
    ui_line()
    
    usethis::use_github_pages(branch = "gh-pages")
  }
  
  
  
  ##
  ## GHA CITATION ----
  ## 
  
  
  
  if (gh_citation) {
    
    ui_title("Configuring GH Actions - CITATION.cff")
    
    add_github_actions_citation(quiet = quiet)
  }

  
  
  ##
  ## SECOND COMMIT ----
  ## 
  
  
  
  if (gh_check || codecov || gh_render || website || gh_citation) {
    
    ui_title("Committing changes")
    
    invisible(gert::git_add("."))
    invisible(gert::git_commit("ci: setup actions"))
    
    if (!quiet) {
      
      ui_done(paste0("Committing changes with the following message: ", 
                     "{ui_value('ci: setup actions')}"))
    }
  }
  
  
  
  ##
  ## ADDING BADGES ----
  ## 
  
  
  
  ui_title("Adding Badges to README") 
  
  
  add_cran_badge(quiet = quiet)
  
  if (gh_check) {
    add_github_actions_check_badge(organisation, quiet = quiet)
  }
  
  if (website) {
    add_github_actions_pkgdown_badge(organisation, quiet = quiet)
  }
  
  if (codecov) {
    add_github_actions_codecov_badge(organisation, quiet = quiet)
    add_codecov_badge(organisation, quiet = quiet)
  }
  
  add_license_badge(quiet = quiet)
  
  if (!is.null(lifecycle)) {
    add_lifecycle_badge(lifecycle, quiet = quiet)
  }
  
  if (!is.null(status)) {
    add_repostatus_badge(status, quiet = quiet)
  }
  
  # add_dependencies_badge(quiet = quiet)
  
  
  
  ##
  ## KNITING README ----
  ## 
  
  
  
  ui_title("Kniting README")  
  
  
  rmarkdown::render(file.path(path_proj(), "README.Rmd"), 
                    output_format = "md_document", quiet = TRUE)
  
  if (!quiet) ui_done("Kniting {ui_value('README.Rmd')}")

  
  
  ##
  ## THIRD COMMIT ----
  ## 
  
  
  
  ui_title("Committing changes")
  
  invisible(gert::git_add("."))
  invisible(gert::git_commit("doc: update README"))
    
  if (!quiet) {
    
    ui_done(paste0("Committing changes with the following message: ", 
                   "{ui_value('doc: update README')}"))
  }


  if (create_repo) invisible(gert::git_push(verbose = FALSE))
  
  
  
  ##
  ## FINAL MESSAGES ----
  ## 
  
  
  ui_title("Done!")
  
  ui_title("What's next?")
  
  ui_todo("Edit project metadata in {ui_value('DESCRIPTION')}")
  ui_todo("Edit project citation in {ui_value('inst/CITATION')}")
  ui_todo("Edit project description in {ui_value('README.Rmd')}")
  ui_todo("Write your R functions in the {ui_value('R/')} directory")
  
  if (test) 
    ui_todo(paste0("Write your units tests in the ", 
                   "{ui_value('tests/testthat/')} directory"))
  
  ui_line()
  
  ui_todo("...and commit your changes!")
  
  invisible(NULL)
}
