#' Get Required Minimal R Version
#'
#' This function...
#'
#' @param pkg ...
#'
#' @return ...
#' @export
#'
#' @examples
#' \dontrun{
#' ##
#' }

get_minimal_r_version <- function(pkg) {
  
  deps <- gtools::getDependencies(pkg, installed = TRUE, available = FALSE)
  pkgs <- utils::installed.packages()
  
  r_versions <- pkgs[pkgs[ , "Package"] %in% deps, "Depends"]
  r_versions <- unlist(stringr::str_extract_all(string = r_versions, 
                                                pattern = "^R \\(.[^,]+\\)$"))
  r_versions <- gsub("R \\(|\\)|>|=|\\s", "", r_versions)
  r_versions <- r_versions[!is.na(r_versions)]
  as.character(max(numeric_version(r_versions)))
}


#' Get Required Minimal R Version
#'
#' This function...
#'
#' @param pkg ...
#'
#' @return ...
#' @export
#'
#' @examples
#' \dontrun{
#' ##
#' }

get_dependencies <- function(pkg) {
  
  # read_descr
  
  all_deps <- gtools::getDependencies(pkg, installed = FALSE, available = FALSE, 
                                      base = FALSE)
  all_deps <- gsub("\\s\\(.+\\)", "", all_deps)
  names(all_deps) <- NULL
  base_deps <- rownames(utils::installed.packages(priority = "base"))
  
  
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
  
  basic_deps <- direct_deps[direct_deps %in% base_deps]
  names(basic_deps) <- NULL
  
  direct_deps <- direct_deps[!(direct_deps %in% base_deps)]
  names(direct_deps) <- NULL
  
  list("base_deps"   = sort(unique(basic_deps)),
       "direct_deps" = sort(unique(direct_deps)), 
       "all_deps"    = sort(unique(all_deps)))
}
