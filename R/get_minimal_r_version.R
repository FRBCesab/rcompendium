#' Get required minimal R version
#'
#' @description 
#' This function detects the minimal required R version for the project based 
#' on minimal required R version of its dependencies. It can be used to update
#' the `Depends` field of the `DESCRIPTION` file.
#' 
#' @param pkg a character of length 1
#' 
#'   The name of a CRAN package or `NULL` (default). If `NULL` get minimal 
#'   required R version of the local (uninstalled) project (package or 
#'   compendium).
#'
#' @return A character with the minimal required R version.
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
#' ## Minimal R version of a project ----
#' get_minimal_r_version()
#' 
#' ## Minimal R version of a CRAN package ----
#' get_minimal_r_version("usethis")
#' }

get_minimal_r_version <- function(pkg = NULL) {
  
  if (is.null(pkg)) {
    
    ## Dev package ----
    
    direct_deps <- c(get_deps_in_depends(), read_descr()$"Imports", 
                     read_descr()$"LinkingTo")
    
    direct_deps <- unlist(strsplit(direct_deps, "\n\\s+|,|,\\s+"))
    direct_deps <- direct_deps[!(direct_deps == "")]
    
    pkg <- direct_deps
    
  } else {
    
    ## CRAN package ----
    
    if (length(pkg) > 1) stop("Argument `pkg` must be of length 1 or `NULL`.")
    
  }
  
  deps <- gtools::getDependencies(pkg, installed = FALSE, available = FALSE)
  
  if (length(deps)) {
    
    pkgs <- utils::available.packages()
    
    r_versions <- pkgs[pkgs[ , "Package"] %in% deps, "Depends"]
    r_versions <- unlist(stringr::str_extract_all(string = r_versions, 
                                                  pattern = "^R \\(.[^,]+\\)$"))
    r_versions <- gsub("R \\(|\\)|>|=|\\s", "", r_versions)
    r_versions <- r_versions[!is.na(r_versions)]
    
    r_version <- max(numeric_version(r_versions))
    r_version <- strsplit(as.character(r_version), "\\.")[[1]]
    
    return(paste(r_version[1], r_version[2], sep = "."))
    
  } else {
    
    return(NULL)
  }
}
