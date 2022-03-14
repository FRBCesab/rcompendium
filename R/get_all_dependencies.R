#' Get all external dependencies
#' 
#' @description 
#' This function gets all the external packages that the project needs. It is 
#' used the generate the _Dependencies_ badge ([add_dependencies_badge()]).
#'
#' @param pkg A character of length 1. The name of a CRAN package or `NULL` 
#'   (default). If `NULL` get dependencies of the local (uninstalled) project 
#'   (package or compendium).
#'
#' @return A list of three vectors: 
#'   * `base_deps`, a vector of base packages;
#'   * `direct_deps`, a vector of direct packages;
#'   * `all_deps`, a vector of all dependencies (recursively obtained).
#' 
#' @export
#' 
#' @family utilities functions
#' 
#' @examples
#' \dontrun{
#' ## Update dependencies ----
#' add_dependencies()
#' 
#' ## Get all dependencies ----
#' deps <- get_all_dependencies()
#' unlist(lapply(deps, length))
#' 
#' ## Can be used for a CRAN package ----
#' deps <- get_all_dependencies("usethis")
#' unlist(lapply(deps, length))
#' }

get_all_dependencies <- function(pkg = NULL) {
  
  if (is.null(pkg)) {
    
    ## Dev package ----
    
    direct_deps <- c(get_deps_in_depends(), read_descr()$"Imports", 
                     read_descr()$"LinkingTo")
    
    if (!is.null(direct_deps)) {
      
      direct_deps <- unlist(strsplit(direct_deps, "\n\\s+|,|,\\s+"))
      direct_deps <- direct_deps[!(direct_deps == "")]
      
      pkg <- direct_deps 
    
    } else {
      
      return(list("base_deps"   = character(0),
                  "direct_deps" = character(0), 
                  "all_deps"    = character(0)))
    }
  
  } else {
    
    ## CRAN package ----
    
    if (length(pkg) > 1) stop("Argument `pkg` must be of length 1 or `NULL`.")
    
    deps <- utils::available.packages()
    deps <- deps[deps[ , "Package"] %in% pkg, ]
    
    deps <- deps[c("Depends", "Imports", "LinkingTo")]
    
    deps_depends   <- unlist(strsplit(deps["Depends"], ", "))
    deps_depends   <- deps_depends[!grep("^R\\s\\(", deps_depends)]
    deps_imports   <- unlist(strsplit(deps["Imports"], ", "))
    deps_linkingto <- unlist(strsplit(deps["LinkingTo"], ", "))
    
    direct_deps <- c(deps_depends, deps_imports, deps_linkingto)
    direct_deps <- direct_deps[!is.na(direct_deps)]
    direct_deps <- gsub("\\s\\(.+\\)|\\n", "", direct_deps)
    
    direct_deps <- unlist(strsplit(direct_deps, ","))
  }
  
  
  ## List of base packages ----
  
  base_deps <- c("base", "compiler", "datasets", "graphics", "grDevices", 
                 "grid", "methods", "parallel", "splines", "stats", "stats4", 
                 "tcltk", "tools", "utils")
  
  
  ## List of all dependencies (on which pkg depends) ----
  
  all_deps <- gtools::getDependencies(pkg, installed = FALSE, 
                                      available = FALSE, base = FALSE)
  all_deps <- gsub("\\s\\(.+\\)", "", all_deps)
  names(all_deps) <- NULL
  
  basic_deps <- direct_deps[direct_deps %in% base_deps]
  names(basic_deps) <- NULL
  
  direct_deps <- direct_deps[!(direct_deps %in% base_deps)]
  names(direct_deps) <- NULL
  
  list("base_deps"   = sort(unique(basic_deps)),
       "direct_deps" = sort(unique(direct_deps)), 
       "all_deps"    = sort(unique(all_deps)))
}
