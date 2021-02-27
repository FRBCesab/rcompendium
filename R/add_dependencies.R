#' Add Dependencies in DESCRIPTION File
#'
#' This function detects dependencies used in `R/`, `NAMESPACE`, and `@examples`
#' and automatically adds these dependencies in **Imports** section of the
#' `DESCRIPTION` file.
#' 
#' In the `NAMESPACE` file it detects dependencies mentionned as `import(pkg)` 
#' and `importFrom(pkg,fun)`.
#' 
#' In the `R/` folder it detects functions called as `pkg::fun()` in the code
#' of each R files. In `@examples` section it also detects packages attached
#' using `library(pkg)` or `require(pkg)`.
#' 
#' The folder `vignettes/` is also inspected and detected dependencies 
#' (`pkg::fun()`, `library(pkg)` or `require(pkg)`) are added in the section
#' **Suggests** of the `DESCRIPTION` file.
#' 
#' If the project is a research compendium user can also inspect one
#' additional folder (i.e. `analysis/`) with the argument `import` to detected 
#' dependencies to be added in the section **Imports** of the `DESCRIPTION` 
#' file. The detection process is the same as the one used for `vignettes/`. 
#'
#' @param path the path to the package/research compendium (must have a 
#' `DESCRIPTION` file) in which dependencies are recursively detected.
#' 
#' @param import (optional) the name of the folder to recursively detect 
#' dependencies to be added in the **Imports** field of `DESCRIPTION` file. 
#' Default is `import = NULL` (but `R/`, `NAMESPACE`, and `@examples` are still
#' inspected).
#' 
#' @param suggest the name of the folder to recursively detect dependencies to
#' be added in the **Suggests** field of `DESCRIPTION` file. 
#' Default is `suggest = "vignettes"`.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' add_dependencies()
#' }

add_dependencies <- function(path = ".", import = NULL, suggest = "vignettes") {


  ## Checks ----
  
  if (!dir.exists(path)) {
    stop("The directory '", path, "' does not exist.")
  }
  
  is_package(path)
  
  if (!is.null(suggest)) {
    if (length(suggest) > 1) stop("Argument 'suggest' must be of length 1.")
  }
  
  if (!is.null(import)) {
    if (length(import) > 1) stop("Argument 'import' must be of length 1.")
  }
  
  
  ## Update Documentation & NAMESPACE ----
  
  devtools::document(pkg = path, quiet = TRUE)
  
  
  ## Detect Dependencies in NAMESPACE ----
  
  deps_in_namespace <- get_deps_in_namespace(path)
  
  
  ## Detect Dependencies in R/ ----
  
  deps_in_functions <- get_deps_in_functions_r(path)
  
  
  ## Detect Dependencies in `import/` ----
  
  deps_extra <- get_deps_extra(path, import = import)
  
  
  ## Merge in functions ----
  
  deps_in_functions <- c(deps_in_functions, deps_extra)
  deps_in_functions <- sort(unique(deps_in_functions))
  
  
  ## Detect duplicates ----
  
  duplicated_deps <- deps_in_functions[which(deps_in_functions %in% 
                                             deps_in_namespace)]
  
  if (length(duplicated_deps)) {
    
    duplicated_deps <- sort(duplicated_deps)
    duplicated_deps <- paste0(duplicated_deps, "()")
    
    ui_info("The following function(s) are already present in {ui_value('NAMESPACE')}:")
    ui_line("{ui_code(duplicated_deps)}")
    ui_todo("You can omit package name when calling these functions")
    ui_line()
  }

  
  ## Detect Dependencies in @examples ----
  
  deps_in_examples <- get_deps_in_examples(path)
  
  
  ## Merge Dependencies ----
  
  deps_in_package <- c(deps_in_namespace, deps_in_functions, deps_in_examples)
  
  if (length(deps_in_package)) {
    
    deps_in_package <- unlist(lapply(strsplit(deps_in_package, "::"), 
                                     function(x) x[1]))
  }
  
  deps_in_package <- sort(unique(deps_in_package))
  
  
  ## Detect Dependencies vignettes ----
  
  deps_suggest <- get_deps_in_vignettes(path, suggest = suggest)
  
  if (length(deps_suggest)) {
    
    deps_suggest <- unlist(lapply(strsplit(deps_suggest, "::"), 
                                     function(x) x[1]))
  }
  
  deps_suggest <- sort(unique(deps_suggest))
  
  
  ## Remove Package Name ----
  
  package_name <- get_package_name(path)
  
  deps_in_package <- deps_in_package[!(deps_in_package %in% package_name)]
  deps_suggest    <- deps_suggest[!(deps_suggest %in% package_name)]
  
  
  ## Remove duplicates ----
  
  if (length(deps_suggest)) {
    deps_suggest <- deps_suggest[!(deps_suggest %in% deps_in_package)]
    deps_suggest <- sort(unique(deps_suggest))
  }
  
  deps_in_package <- sort(unique(deps_in_package))
  
  
  ## Read DESCRIPTION File ----
  
  descr <- read_descr(path)
  
  
  ## Dependencies in DEPENDS ----
  
  pkgs_in_depends <- get_deps_in_depends(path)
  
  ui_done("Scanning {ui_value('Depends')} dependencies")
  
  if (!length(pkgs_in_depends)) {
  
    ui_line("  {clisymbols::symbol$radio_on} No package found")
  
  } else {
  
    ui_line("  {clisymbols::symbol$radio_on} Found {ui_value(length(pkgs_in_depends))} package(s)")  
  }
  
  ui_line()
  
  
  ## Dependencies in IMPORTS ----
  
  ui_done("Scanning {ui_value('Imports')} dependencies")
  
  pkgs_in_imports <- sort(deps_in_package[!(deps_in_package %in% pkgs_in_depends)])
  
  if (length(deps_in_package)) {
    
    # Message
    ui_line("  {clisymbols::symbol$radio_on} Found {ui_value(length(pkgs_in_imports))} package(s)") 
    msg <- paste0("Imports: ", paste0(pkgs_in_imports, collapse = ", "))
    ui_line("  {clisymbols::symbol$radio_on} Adding the following line in {ui_value('DESCRIPTION')}: {ui_code(msg)}")

    pkgs_in_imports <- paste0(pkgs_in_imports, collapse = ",\n    ")
    descr$"Imports" <- paste0("\n    ", pkgs_in_imports)

  } else {
    
    ui_line("  {clisymbols::symbol$radio_on} No package found")
    
    pos <- which(colnames(descr) == "Imports")
    if (length(pos)) descr <- descr[ , -pos]
  }
  
  ui_line()
  
  
  ## Dependencies in SUGGESTS ----
  
  ui_done("Scanning {ui_value('Suggests')} dependencies")
  
  pkgs_in_suggests <- sort(deps_suggest[!(deps_suggest %in% pkgs_in_depends)])
  
  if (length(deps_suggest)) {
    
    # Message
    ui_line("  {clisymbols::symbol$radio_on} Found {ui_value(length(pkgs_in_suggests))} package(s)") 
    msg <- paste0("Suggests: ", paste0(pkgs_in_suggests, collapse = ", "))
    ui_line("  {clisymbols::symbol$radio_on} Adding the following line in {ui_value('DESCRIPTION')}: {ui_code(msg)}")
    
    
    pkgs_in_suggests <- paste0(pkgs_in_suggests, collapse = ",\n    ")
    descr$"Suggests" <- paste0("\n    ", pkgs_in_suggests)
    
  } else {
    
    ui_line("  {clisymbols::symbol$radio_on} No package found")
    
    pos <- which(colnames(descr) %in% c("Suggests", "VignetteBuilder"))
    if (length(pos)) descr <- descr[ , -pos]
  }
  
  
  ## Rewrite DESCRIPTION ----
  
  write_descr(path, descr_file = descr)
  
  invisible(NULL)
}
