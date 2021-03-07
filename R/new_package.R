#' Create an R package structure
#' 
#' @description 
#' This function creates a new R package structure according to the CRAN 
#' policies. Essential features of an R package are created (`DESCRIPTION` and
#' `NAMESPACE` files, and `R/` and `man/` folders). The project is also 
#' **versioning with git** and a generic R `.gitignore` is added.
#' 
#' **IMPORTANT -** Before using this function user needs to create a new folder 
#' (or a new project if using RStudio) and run this function inside this folder 
#' (by using [setwd()] or by opening the Rproj in a new Rstudio session).
#' **The name of the package will be the same as the name of this folder and 
#' some rules must be respected**: 
#' \url{https://r-pkgs.org/workflows101.html#naming}.
#' 
#' Some fields of the `DESCRIPTION` file (maintainer information, package name, 
#' license, URLs, and  `roxygen2` version)  are automatically filled but
#' others (title and description) need to be edited manually.
#' 
#' Additional features are also created: a `CITATION` file, a `README.Rmd`, and
#' a `vignettes/` folder (optional). See below the section **Package Content** 
#' to see the full structure of the R package.
#' 
#' A GitHub repository can also be created (default) following the 
#' "GitHub last" workflow
#' (\url{https://happygitwithr.com/existing-github-last.html}).
#' Configuration files for GitHub Actions to automatically check the package and 
#' deploy the website [pkgdown::pkgdown()] will be added in the `.github/`
#' folder. See below the section **Creating a GITHUB Repository**.
#' 
#' @param license a character vector of length 1
#' 
#'   The license to be used for this package. Run [get_licenses()] to choose an 
#'   appropriate one. Default is `license = 'GPL (>= 2)'` 
#'   
#'   The license can be changed later by using [add_license()] (and 
#'   [add_license_badge()] or [refresh()] to update the corresponding badge).
#' 
#' @param status a character vector of length 1
#' 
#'   The status of the project according to the standard defined by the 
#'   \url{https://www.repostatus.org/} project. One among `'concept'` (default), 
#'   `'wip'`, `'suspended'`, `'abandoned'`, `'active'`, `'inactive'`, or 
#'   `'unsupported'`. See [add_repostatus_badge()] for further information. 
#'   
#'   This argument is used to add a badge to the `README.Rmd` to help visitors 
#'   to better understand your project. If you don't want this badge use 
#'   `status = NULL`.
#'   
#'   This status can be added/changed later by using [add_repostatus_badge()].
#' 
#' @param lifecycle a character vector of length 1
#'   
#'   The lifecycle stage of the project according to the standard defined at 
#'   \url{https://lifecycle.r-lib.org/articles/stages.html}. One among 
#'   `'experimental'` (default), `'stable'`, `'deprecated'`, or `'superseded'`.
#'   See [add_lifecycle_badge()] for further information. 
#'   
#'   This argument is used to add a badge to the `README.Rmd` to help visitors 
#'   to better understand your project. If you don't want this badge use 
#'   `lifecycle = NULL`. 
#'   
#'   This stage can be added/changed later by using [add_lifecycle_badge()].
#' 
#' @param vignette a logical value
#' 
#'   If `TRUE` creates a vignette in `vignettes/` named `pkg.Rmd`. Packages 
#'   [knitr::knitr()] and [rmarkdown::rmarkdown()] are also added to `Suggests`
#'   in the `DESCRIPTION` file.
#' 
#' @param create_repo a logical value
#' 
#'   If `TRUE` (default) creates a repository (public if `private = FALSE` or 
#'   private if `private = TRUE`) on GitHub. See below the section
#'   **Creating a GITHUB Repository**.
#' 
#' @param private a logical value
#' 
#'   If `TRUE` creates a private repository on user GitHub account (or 
#'   organisation). Default is `private = FALSE`.
#' 
#' @param gh_check a logical value
#' 
#'   If `TRUE` (default) configures GitHub Actions to automatically check and 
#'   test the package after each push. This will run `R CMD check` on the three 
#'   major operating systems (Ubuntu, macOS, and Windows) on the latest release 
#'   of R. See [add_github_actions_check()] for further information. 
#'   
#'   If `create_repo = FALSE` this argument is ignored.
#' 
#' @param website a logical value
#' 
#'   If `TRUE` (default) configures GitHub Actions to automatically build and 
#'   deploy the package website (using [pkgdown::pkgdown()]) after each push. A 
#'   **gh-pages** branch will be created using [usethis::use_github_pages()] 
#'   and the GitHub repository will be automatically configured. 
#'   
#'   If `create_repo = FALSE` this argument is ignored.
#' 
#' @param given a character vector of length 1
#' 
#'   The given name of the maintainer of the package. If `NULL` (default) the 
#'   function will try to get this value by reading the `.Rprofile` file. 
#'   
#'   For further information see [set_credentials()] and below the section 
#'   **Managing Credentials**.
#' 
#' @param family a character vector of length 1
#' 
#'   The family name of the maintainer of the package. If `NULL` (default) the 
#'   function will try to get this value by reading the `.Rprofile` file. 
#'   
#'   For further information see [set_credentials()] and below the section 
#'   **Managing Credentials**.
#' 
#' @param email a character vector of length 1
#' 
#'   The email address of the maintainer of the package. If `NULL` (default) the 
#'   function will try to get this value by reading the `.Rprofile` file. 
#'   
#'   For further information see [set_credentials()] and below the section 
#'   **Managing Credentials**.
#' 
#' @param orcid a character vector of length 1
#' 
#'   The ORCID of the maintainer of the package. If `NULL` (default) the 
#'   function will try to get this value by reading the `.Rprofile` file. 
#'   
#'   For further information see [set_credentials()] and below the section 
#'   **Managing Credentials**.
#' 
#' @param github a character vector of length 1
#' 
#'   The GitHub pseudo of the maintainer of the package. It will be used to 
#'   create the repository on GitHub unless `!is.null(organisation)` (the
#'   repository will be created on the GitHub organisation specified by the
#'   argument `organisation`).
#'   
#'   If `NULL` (default) the function will try to get this value by reading 
#'   the `.Rprofile` file (unless `!is.null(organisation)`). 
#' 
#' @param organisation a character vector of length 1
#' 
#'   The GitHub organisation to host the repository. If defined it will 
#'   overwrite the argument `github`.
#' 
#'   Default is `organisation = NULL` (the GitHub pseudo will be used).
#' 
#' @param overwrite a logical value
#' 
#'   If `TRUE` files written from templates and modified by user are erased. 
#'   Default is `overwrite = FALSE`. **Be careful while using this argument**.
#' 
#' @param quiet a logical value
#' 
#'   If `TRUE` messages are deleted. Default is `FALSE`.
#'   
#' @details
#' 
#' ## Package Content
#' 
#' With default settings the package `pkg` will contain: 
#' 
#' ```
#' .
#' │
#' ├── .git/                     # GIT tracking folder
#' ├── .github/                  # (optional) GitHub Actions settings
#' │   └── workflows/
#' │       ├── pkgdown.yaml      # Configuration file to build & deploy website
#' │       └── R-CMD-check.yaml  # Configuration file to check & test package
#' ├── .Rbuildignore             # Automatically generated
#' ├── .gitignore                # Specific to R packages
#' ├── pkg.Rproj                 # (optional) Created by user 
#' ├── _pkgdown.yaml             # (optional) User website settings
#' │
#' ├── R/                        # R functions
#' │   └── pkg-package.R         # Dummy R file for package-level documentation
#' │
#' ├── man/                      # R functions helps (automatically updated)
#' │   ├── figures/              # Figures for the README 
#' │   │   └── hexsticker.png    # Template R package HexSticker
#' │   └── pkg-package.Rd        # Package-level documentation
#' │
#' ├── inst/
#' │   └── CITATION              # BiBTeX entry to cite the R package       [*]
#' │
#' ├── vignettes/
#' │   └── pkg_vignette.Rmd      # (optional) Package tutorial              [*]
#' │
#' ├── DESCRIPTION               # Project metadata                         [*]
#' ├── NAMESPACE                 # Automatically generated
#' │
#' ├── LICENSE                   # (optional) If License = MIT
#' ├── LICENSE.md                # Content of the chosen license
#' │
#' ├── README.md                 # GitHub README (automatically generated)
#' └── README.Rmd                # GitHub README (to knit)                  [*]
#' 
#' [*] These files are automatically edited but user needs to add manually 
#'     some information.
#' 
#' ```
#' 
#' 
#' ## Recommended Workflow
#' 
#' The purpose of the package `rcompendium` is to make easier the creation of R
#' package/research compendium so that user can focus on the code/analysis 
#' instead of wasting time organizing files.
#' 
#' The recommended workflow is as follow:
#' * Create an empty RStudio project;
#' * Store your credentials with [set_credentials()] (if not already done);
#' * Run [new_package()] to create the package structure (and the GitHub 
#'   repository);
#' * Edit some metadata in `DESCRIPTION`, `CITATION`, and `README.Rmd`;
#' * Implement, document & test functions (the fun part);
#' * Update the project (update `.Rd` files, `NAMESPACE`, external dependencies 
#'   in `DESCRIPTION`, re-knit `README.Rmd`, and check package integrity) with
#'   [refresh()].
#' 
#' 
#' ## Managing Credentials
#' 
#' You can use the arguments `given`, `family`, `email`, `orcid`, and `github`
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
#' ## Creating a GITHUB Repository
#' 
#' First run [gh::gh_whoami()] to see if your git and associated credentials are
#' correctly configured. If so you should see something like:
#' 
#' ```
#' {
#' "name": "Given Family",
#' "login": "pseudo",
#' "html_url": "https://github.com/pseudo",
#' ...
#' }
#' ```
#' 
#' Otherwise see [gert::git_config()] to debug.
#' 
#' To create the GitHub repository directly from R, the package `rcompendium` 
#' uses the function [usethis::use_github()], an interface to the GitHub 
#' REST API. The interaction with this API required an authentication method:
#' a **GITHUB PAT** (Personal Access Token).
#' 
#' If you don't have a **GITHUB PAT** locally stored, you must:
#' 1. Obtain a new one from your GitHub account. **Make sure to select 
#' at least the first two scopes (private repository and workflow)**
#' 2. Store it in the `.Renviron` file by using [usethis::edit_r_environ()] 
#' and adding the following line: `GITHUB_PAT='99z9...z9'`
#' 
#' See [usethis::gh_token_help()] for more information about getting and 
#' configuring a **GITHUB PAT**.
#' 
#' If everything is well configured you should see something like:
#' 
#' ```
#' {
#' "name": "Given Family",
#' "login": "pseudo",
#' "html_url": "https://github.com/pseudo",
#' "scopes": "delete_repo, repo, workflow",
#' "token": "99z9...z9"
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
#' set_credentials("Given", "Family", "email.address@domain.com", 
#'                 github = "pseudo", orcid = "0000-0000-0000-0000")
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

new_package <- function(license = "GPL (>= 2)", status = "concept", 
                        lifecycle = "experimental", vignette = TRUE, 
                        create_repo = TRUE, private = FALSE, gh_check = TRUE, 
                        website = TRUE, given = NULL, family = NULL, 
                        email = NULL, orcid = NULL, github = NULL, 
                        organisation = NULL, overwrite = FALSE, quiet = FALSE) {
  
  
  ## If not RStudio ----
  
  if (!rstudioapi::isAvailable()) {
    if (!file.exists(".here")) file.create(".here")
  }
  
  
  ## Check inceptions ----
  
  git_in_git()
  proj_in_proj()
  
  
  ## Check for package name ----
  
  project_name <- get_package_name()
  
  response <- ui_yeah("Is your project name correct: {ui_value(project_name)}?", 
                      yes = "Absolutely", no = "Not at all", n_no = 1, 
                      shuffle = FALSE)
  
  if (!response) {
    
    ui_oops(paste0("Please open R/RStudio in the adequate (empty) folder ", 
                   "(create it if necessary).\n  ", 
                   "** The project will be named after this folder **"))
    
    return(invisible(NULL))
  }
  
  
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
  
  if (is.null(organisation)) {
    if (is.null(github)) {
      github <- getOption("github")
      if (is.null(github)) {
        stop("Please provide a GITHUB pseudo. Use `set_credentials()` to ", 
             "store it permanently or use the argument `github`.")
      }
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
        stop("Repository < ", github_url, " > already exist.")
      }
      
    } else {
      
      if (!is.null(is_gh_repo(github, project_name))) {
        
        github_url <- paste0("https://", "github.com/", github, "/", 
                             project_name)
        stop("Repository < ", github_url, " > already exist.")
      }
    }
    
  } else {
    
    gh_check <- FALSE
    website  <- FALSE
  }
  
  
  ## Check Repo Status ----
  
  if (!is.null(status)) {
    if (!(tolower(status) %in% c("concept", "wip", "suspended", "abandoned", 
                                 "active", "inactive", "unsupported"))) {
      
      stop("Invalid Repo status. Please use `?add_repostatus_badge()` to ",
           "select an appropriate one.")
    }  
  }
  
  
  ## Check Life cycle ----
  
  if (!is.null(lifecycle)) {
    if (!(tolower(lifecycle) %in% c("experimental", "stable", "deprecated", 
                                    "superseded"))) {
      
      stop("Invalid Life cycle. Please use `?add_lifecycle_badge()` to ",
           "select an appropriate one.")
    }  
  }
  
  
  
  ## ... End of Checks ----
  
  
  
  ##
  ## INITIALIZING VERSIONING ----
  ## 
    
  
  
  ui_title("Initializing Versioning")
  
  
  ## Init GIT (if required) ----
  
  if (!dir.exists(here::here(".git"))) {
    
    gert::git_init(here::here(".git"))
    ui_done("Init {ui_value('git')} versioning")
  }
  
  
  ## Add/Replace R-specific gitignore ----
  
  if (file.exists(".gitignore")) {
  
      invisible(file.remove(here::here(".gitignore")))
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
  
  add_description(given, family, email, orcid, github, organisation, 
                  open = FALSE, overwrite = overwrite, quiet = quiet)
  
  if (!quiet) ui_line()
  
  
  ## Add LICENSE ----
  
  add_license(license, given, family, quiet = quiet)
  
  if (!quiet) ui_line()
  
  
  ## Create folders ----
  
  dir.create(here::here("R"), showWarnings = FALSE)
  
  if (!quiet) ui_done("Creating {ui_value('R/')} directory")
  
  
  dir.create(here::here("man/"), showWarnings = FALSE)
  
  if (!quiet) ui_done("Creating {ui_value('man/')} directory")
  
  if (!quiet) ui_line()
  
  
  ## Package doc bonus ----
  
  add_package_doc(open = FALSE, overwrite = overwrite, quiet = quiet)
  
  add_citation(given, family, github, organisation, open = FALSE, 
               overwrite = overwrite, quiet = quiet)
  
  
  
  ##
  ## ADDING VIGNETTE ----
  ## 
  
  
  if (vignette) {
    
    ui_title("Adding Vignette")
    
    add_vignette(open = FALSE, overwrite = overwrite, quiet = quiet)
  }
  
  
  
  ##
  ## ADDING README ----
  ## 
  
  
  
  ui_title("Adding README")
  
  
  
  add_readme_rmd(type = "package", given, family, github, organisation, 
                 open = FALSE, overwrite = overwrite, quiet = quiet)
  
  add_sticker(overwrite = overwrite, quiet = quiet)
  
  
  
  ##
  ## CHECKING DEPENDENCIES ----
  ## 
  
  
  
  # ui_title("Checking Dependencies")
  
  
  # add_dependencies(suggest = NULL)
  
  
  
  ##
  ## ADDING BADGES ----
  ## 
  
  
  
  ui_title("Adding Badges") 
  
  
  if (gh_check) {
    add_github_actions_badge(quiet = quiet)
  }

  add_cran_badge(quiet = quiet)
  add_license_badge(quiet = quiet)
  
  if (!is.null(status)) {
    add_repostatus_badge(status, quiet = quiet)
  }
  
  if (!is.null(lifecycle)) {
    add_lifecycle_badge(lifecycle, quiet = quiet)
  }
  
  add_dependencies_badge(quiet = quiet)
  
  
  
  ##
  ## KNITING README ----
  ## 
  
  
  
  ui_title("Kniting README")  
  
  
  rmarkdown::render(here::here("README.Rmd"), output_format = "md_document",
                    quiet = TRUE)
  
  if (!quiet) ui_done("Kniting {ui_value('README.Rmd')}")
  
  
  
  ##
  ## FIRST COMMIT ----
  ## 
  
  
  
  ui_title("Committing changes")  
  
  
  ## Commit changes ----
  
  invisible(gert::git_add("."))
  invisible(gert::git_commit(":tada: Initial commit"))

  if (!quiet) {
    ui_done(paste0("Committing changes with the following message: ", 
                   "{ui_value('Initial commit')}"))
  }
  
  
  
  ##
  ## CREATING GITHUB REPOSITORY ----
  ## 
  
  
  
  if (create_repo) {
    
    ui_title("Creating GITHUB repository")
    
    
    ## Create GitHub repo ----
    
    usethis::use_github(organisation = organisation, private = private)
    
    
    ## Update GitHub repo fields ----
    
    owner <- ifelse(is.null(organisation), github, organisation)
    update_gh_repo(owner, repo = project_name, website = website, quiet = quiet)
    
  }
  
  
  
  ##
  ## CONFIGURING GITHUB ACTIONS ----
  ## 
  
  
  
  if (gh_check) {
    
    ui_title("Configuring GITHUB Actions")
    
    
    ## R-CMD-Check ----
    
    add_github_actions_check(quiet = quiet)
    add_to_buildignore(".github", quiet = quiet)
    
  }
  

  
  ##
  ## DEPLOYING WEBSITE ----
  ## 
  
  

  ## Deploy website ----
  
  if (website) {
    
    ui_title("Deploying Website")
    
    
    ## Add pkgdown with GH Actions config file ----
    
    add_github_actions_pkgdown()
    
    ui_line()
    
    usethis::use_github_pages(branch = "gh-pages")
    
    
    
    ## Commit changes ----
    
    if (!quiet) {
      
      ui_line()
      ui_done(paste0("Committing & pushing changes with the following ", 
                     "message: {ui_value('Configure GH Actions')}"))
    }
    
    invisible(gert::git_add("."))
    invisible(gert::git_commit(":rocket: Configure GH Actions"))
    invisible(gert::git_push(verbose = FALSE))
  }
  
  
  
  ##
  ## FINAL MESSAGES ----
  ## 
  
  
  ui_title("Done!")
  
  ui_title("What's next?")
  
  ui_todo("Edit project metadata in {ui_value('DESCRIPTION')}")
  ui_todo("Edit project citation in {ui_value('inst/CITATION')}")
  ui_todo("Edit project description in {ui_value('README.Rmd')}")
  ui_todo("Write your R functions in the {ui_value('R/')} directory")
  ui_todo("Refresh your package with {ui_code('refresh()')}")
  ui_todo("...and commit your changes!")
  
  invisible(NULL)
}
