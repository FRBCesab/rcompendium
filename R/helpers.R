#' @importFrom utils file.edit installed.packages sessionInfo
#' @importFrom usethis ui_done ui_value ui_oops ui_todo ui_code ui_line



#' @noRd
add_package_doc <- function() { 
  
  filename <- paste0(get_project_name(), "-package.R")
  
  invisible(
    file.copy(system.file("templates/xxx-package.R", package = "rcompendium"), 
              here::here("R", filename)))
  
  ui_done("Writing {ui_value(paste0('R/', filename))} file.")
  
  invisible(NULL)
}



#' @noRd
get_project_name <- function() {
  
  if (!("here" %in% installed.packages())) {
    stop("The package `here` cannot be found.")
  }
  
  exploded_path <- unlist(strsplit(here::here(), .Platform$"file.sep"))
  exploded_path[length(exploded_path)]    
}



#' @noRd
get_roxygen2_version <- function() {
  
  if (!("roxygen2" %in% installed.packages())) {
    stop("The package `roxygen2` cannot be found.")
  }
  
  as.character(utils::packageVersion("roxygen2"))
}



#' @noRd
get_r_version <- function() {
  
  r_version <- paste(sessionInfo()["R.version"][[1]]["major"], 
                     sessionInfo()["R.version"][[1]]["minor"], sep = ".")
  r_version <- unlist(strsplit(r_version, "\\."))
  r_version <- paste(r_version[1], r_version[2], sep = ".")
  paste0("R (>= ", r_version, ")")
}
