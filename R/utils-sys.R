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



#' **Git Inception**
#' 
#' @noRd

git_in_git <- function() {
  
  paths <- unlist(strsplit(here::here(), .Platform$file.sep))
  
  for (i in 1:(length(paths) - 1)) {
    
    recursive_path <- paste0(c(paths[1:i], ".git"), 
                             collapse = .Platform$file.sep)
    
    if (dir.exists(recursive_path)) 
      stop("You are going to create a '.git' inside a folder that is ", 
           "already versioned.\n  < ", recursive_path, " >") 
  }
  
  invisible(NULL)
}



#' **Rproj Inception**
#' 
#' @noRd

proj_in_proj <- function() {
  
  paths <- unlist(strsplit(here::here(), .Platform$file.sep))
  
  for (i in 1:(length(paths) - 1)) {
    
    recursive_path <- paste0(paths[1:i], collapse = .Platform$file.sep)
    
    if (length(list.files(recursive_path, pattern = "\\.Rproj$"))) 
      stop("You are going to create an 'RStudio Project' inside a folder that ", 
           "is already an 'RStudio Project'.") 
  }
  
  invisible(NULL)
}


ui_title <- function(text) {
  
  ui_line()
  cat(clisymbols::symbol$radio_on, crayon::bold(crayon::underline(text)))
  ui_line()
  ui_line()
  
  invisible(NULL)
}