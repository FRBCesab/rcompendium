## Utilities Functions - Get Project/System Infos ----



#' **Check if current folder is a package (DESCRIPTION file)**
#' 
#' @noRd

is_package <- function() {
  
  if (!file.exists(here::here("DESCRIPTION"))) {
    stop("The directory '", here::here(), "' is not a package ", 
         "(no **DESCRIPTION** found)")
  }
  
  invisible(NULL)
}



#' **Get project name**
#' 
#' @noRd

get_package_name <- function() {

  exploded_path <- unlist(strsplit(here::here(), .Platform$"file.sep"))
  exploded_path[length(exploded_path)]    
}



#' **Get package version**
#' 
#' @noRd

get_package_version <- function() read_descr()$"Version"



#' **Get roxygen2 version**
#' 
#' @noRd

get_roxygen2_version <- function() {
  
  if (!("roxygen2" %in% utils::installed.packages())) {
    stop("The package `roxygen2` cannot be found.")
  }
  
  as.character(utils::packageVersion("roxygen2"))
}



#' **Get R version**
#' 
#' @noRd

get_r_version <- function() {
  
  r_version <- paste(utils::sessionInfo()["R.version"][[1]]["major"], 
                     utils::sessionInfo()["R.version"][[1]]["minor"], 
                     sep = ".")
  r_version <- unlist(strsplit(r_version, "\\."))
  r_version <- paste(r_version[1], r_version[2], sep = ".")
  
  paste0("R (>= ", r_version, ")")
}
