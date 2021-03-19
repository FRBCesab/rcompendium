#' Add dependencies in DESCRIPTION
#' 
#' @description 
#' This function detects external dependencies used in `R/`, `NAMESPACE`, and 
#' `@examples` sections of `roxygen2` headers and automatically adds these 
#' dependencies in the `Imports` section of the `DESCRIPTION` file.
#' 
#' In the `NAMESPACE` this function detects dependencies mentioned as 
#' `import(pkg)` and `importFrom(pkg,fun)`.
#' 
#' In the `R/` folder it detects functions called as `pkg::fun()` in the code
#' of each R files. In `@examples` sections it also detects packages attached
#' by `library()` or `require()`.
#' 
#' The `vignettes/` folder is also inspected and detected dependencies 
#' (`pkg::fun()`, `library()` or `require()`) are added to the `Suggests` 
#' field of the `DESCRIPTION` file (in addition to the packages 
#' [`knitr`](https://yihui.org/knitr/) and 
#' [`rmarkdown`](https://rmarkdown.rstudio.com/)).
#' 
#' If the project is a research compendium user can also inspect additional 
#' folder(s) with the argument `compendium` to add dependencies to the 
#' `Imports` section of the `DESCRIPTION` file. The detection process is the 
#' same as the one used for `vignettes/`. 
#' 
#' The `tests/` folder is also inspected and detected dependencies 
#' (`pkg::fun()`, `library()` or `require()`) are added to the `Suggests` 
#' field of the `DESCRIPTION` file (in addition to the package 
#' [`testthat`](https://testthat.r-lib.org)).
#' 
#' @param compendium a character of length 1
#' 
#'   The name of the folder to recursively detect dependencies to be added to 
#'   the `Imports` field of `DESCRIPTION` file. It can be `'analysis/'` (if 
#'   additional folders, i.e. `data/`, `outputs/`, `figures/`, etc. have been
#'   created in this folder), `'.'` (if folders `data/`, `outputs/`, 
#'   `figures/`, etc. have been created at the root of the project), etc. 
#'   See [new_compendium()] for further information.
#'   
#'   Default is `compendium = NULL` (i.e. no additional folder are inspected 
#'   but `R/`, `NAMESPACE`, `vignettes/`, and `tests/` are still inspected).
#' 
#' @return None
#'   
#' @export
#' 
#' @family development functions
#'
#' @examples
#' \dontrun{
#' add_dependencies()
#' }

add_dependencies <- function(compendium = NULL) {


  ## Checks ----

  if (!is.null(compendium))  stop_if_not_string(compendium)

  is_package()
  path <- path_proj()
  
  ## If no R function ----
  
  if (!dir.exists(file.path(path, "R"))) stop("No 'R/' folder found.")
  
  
  ## Update Documentation & NAMESPACE ----
  
  suppressMessages(devtools::document(quiet = TRUE))
  
  
  ## Detect Dependencies in NAMESPACE ----
  
  deps_in_namespace <- get_deps_in_namespace()
  
  
  ## Detect Dependencies in R/ ----
  
  deps_in_functions <- get_deps_in_functions_r()
  
  
  ## Detect Dependencies in import/ ----
  
  deps_extra <- get_deps_extra(compendium)
  
  
  ## Merge in-functions ----
  
  deps_in_functions <- c(deps_in_functions, deps_extra)
  deps_in_functions <- sort(unique(deps_in_functions))
  
  
  ## Detect duplicates ----
  
  duplicated_deps <- deps_in_functions[which(deps_in_functions %in% 
                                             deps_in_namespace)]
  
  if (length(duplicated_deps)) {
    
    duplicated_deps <- sort(duplicated_deps)
    duplicated_deps <- paste0(duplicated_deps, "()")
    
    ui_info(paste0("The following function(s) are already present in ",
                   "{ui_value('NAMESPACE')}:"))
    ui_line("{ui_code(duplicated_deps)}")
    ui_todo("You can omit package name when calling these functions")
    ui_line()
  }

  
  ## Detect Dependencies in @examples ----
  
  deps_in_examples <- get_deps_in_examples()
  
  
  ## Merge Dependencies ----
  
  deps_in_package <- c(deps_in_namespace, deps_in_functions, deps_in_examples)
  
  if (length(deps_in_package)) {
    
    deps_in_package <- unlist(lapply(strsplit(deps_in_package, "::"), 
                                     function(x) x[1]))
  }
  
  deps_in_package <- sort(unique(deps_in_package))
  
  
  ## Detect Dependencies VIGNETTES ----
  
  deps_suggest <- get_deps_in_vignettes()
  
  if (length(deps_suggest)) {
    
    deps_suggest <- unlist(lapply(strsplit(deps_suggest, "::"), 
                                  function(x) x[1]))
  }
  
  deps_suggest <- sort(unique(deps_suggest))
  
  
  ## Detect Dependencies TESTS ----
  
  deps_test <- get_deps_in_tests()
  
  if (length(deps_test)) {
    
    deps_test <- unlist(lapply(strsplit(deps_test, "::"), function(x) x[1]))
    
  }
  
  deps_suggest <- sort(unique(c(deps_suggest, deps_test)))
  
  
  ## Remove Package Name ----
  
  package_name <- get_package_name()
  
  deps_in_package <- deps_in_package[!(deps_in_package %in% package_name)]
  deps_suggest    <- deps_suggest[!(deps_suggest %in% package_name)]
  
  
  ## Remove duplicates ----
  
  if (length(deps_suggest)) {
    deps_suggest <- deps_suggest[!(deps_suggest %in% deps_in_package)]
    deps_suggest <- sort(unique(deps_suggest))
  }
  
  deps_in_package <- sort(unique(deps_in_package))

  
  
  ## Read DESCRIPTION File ----
  
  descr <- read_descr()
  
  
  ## Dependencies in DEPENDS ----
  
  pkgs_in_depends <- get_deps_in_depends()
  
  ui_done("Scanning {ui_value('Depends')} dependencies")
  
  if (!length(pkgs_in_depends)) {
  
    ui_line("  {clisymbols::symbol$radio_on} No package found")
  
  } else {
  
    ui_line(paste0("  {clisymbols::symbol$radio_on} Found ", 
                   "{ui_value(length(pkgs_in_depends))} package(s)"))
  }
  
  
  ## Dependencies in IMPORTS ----
  
  ui_done("Scanning {ui_value('Imports')} dependencies")
  
  pkgs_in_imports <- sort(deps_in_package[!(deps_in_package %in% 
                                              pkgs_in_depends)])
  
  if (length(pkgs_in_imports)) {
    
    # keep packages versions
    pkgs_with_version <- c(get_deps_in_imports(), get_deps_in_suggests())
    pkgs_with_version <- pkgs_with_version[grep("\\(.*\\)", pkgs_with_version)]
    
    if (length(pkgs_with_version)) {
      
      pkgs <- unlist(lapply(strsplit(pkgs_with_version, "\\s\\("), 
                            function(x) x[1]))
      for (i in seq_len(length(pkgs))) {
        pos <- which(pkgs_in_imports == pkgs[i])
        if (length(pos)) pkgs_in_imports[pos] <- pkgs_with_version[i]
      }
    }
    
    # Message
    ui_line(paste0("  {clisymbols::symbol$radio_on} Found ", 
                   "{ui_value(length(pkgs_in_imports))} package(s)")) 
    
    msg <- paste0("Imports: ", paste0(pkgs_in_imports, collapse = ", "))
    ui_line(paste0("  {clisymbols::symbol$radio_on} Adding the following ", 
                   "line in {ui_value('DESCRIPTION')}: {ui_code(msg)}"))

    pkgs_in_imports <- paste0(pkgs_in_imports, collapse = ",\n    ")
    descr$"Imports" <- paste0("\n    ", pkgs_in_imports)

  } else {
    
    ui_line("  {clisymbols::symbol$radio_on} No package found")
    
    pos <- which(colnames(descr) == "Imports")
    if (length(pos)) descr <- descr[ , -pos]
  }
  
  
  
  ## Dependencies in SUGGESTS ----
  
  ui_done("Scanning {ui_value('Suggests')} dependencies")
  
  pkgs_in_suggests <- sort(deps_suggest[!(deps_suggest %in% pkgs_in_depends)])
  
  if (length(pkgs_in_suggests)) {
    
    # keep packages versions
    pkgs_with_version <- c(get_deps_in_imports(), get_deps_in_suggests())
    pkgs_with_version <- pkgs_with_version[grep("\\(.*\\)", pkgs_with_version)]
    
    if (length(pkgs_with_version)) {
      
      pkgs <- unlist(lapply(strsplit(pkgs_with_version, "\\s\\("), 
                            function(x) x[1]))
      for (i in seq_len(length(pkgs))) {
        pos <- which(pkgs_in_suggests == pkgs[i])
        if (length(pos)) pkgs_in_suggests[pos] <- pkgs_with_version[i]
      }
    }
    
    
    # Message
    ui_line(paste0("  {clisymbols::symbol$radio_on} Found ", 
                   "{ui_value(length(pkgs_in_suggests))} package(s)"))
    
    msg <- paste0("Suggests: ", paste0(pkgs_in_suggests, collapse = ", "))
    ui_line(paste0("  {clisymbols::symbol$radio_on} Adding the following ", 
                   "line in {ui_value('DESCRIPTION')}: {ui_code(msg)}"))
    
    
    pkgs_in_suggests <- paste0(pkgs_in_suggests, collapse = ",\n    ")
    descr$"Suggests" <- paste0("\n    ", pkgs_in_suggests)
    
  } else {
    
    ui_line("  {clisymbols::symbol$radio_on} No package found")
    
    pos <- which(colnames(descr) %in% c("Suggests", "VignetteBuilder"))
    if (length(pos)) descr <- descr[ , -pos]
  }
  
  
  ## Rewrite DESCRIPTION ----
  
  write_descr(descr)
  
  invisible(NULL)
}
