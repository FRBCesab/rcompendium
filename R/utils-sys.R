## Utilities Functions - Get Project/System Infos ----



#' **Get Project Root Path**
#' 
#' @noRd

path_proj <- function() usethis::proj_get()



#' **Check if current folder is a package (DESCRIPTION file)**
#' 
#' @noRd

is_package <- function() {
  
  
  path <- path_proj()
  
  if (!file.exists(file.path(path, "DESCRIPTION"))) {
    stop("No 'DESCRIPTION' file found.")
  }
  
  invisible(NULL)
}



#' **Get project name**
#' 
#' @noRd

get_package_name <- function() {
  
  
  path <- path_proj()
  
  exploded_path <- unlist(strsplit(path, .Platform$"file.sep"))
  exploded_path[length(exploded_path)]
}



#' **Get package version**
#' 
#' @noRd

get_package_version <- function() {
  
  
  is_package()
  
  read_descr()$"Version"
}



#' **Get `roxygen2` version**
#' 
#' @noRd

get_roxygen2_version <- function() {
  
  
  if (!length(find.package("roxygen2", quiet = TRUE))) {
    stop("The package 'roxygen2' cannot be found.")
  }
  
  as.character(utils::packageVersion("roxygen2"))
}



#' **Get System R version**
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
  
  
  paths <- unlist(strsplit(path_proj(), .Platform$file.sep))
  
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
  
  
  paths <- unlist(strsplit(path_proj(), .Platform$file.sep))
  
  for (i in 1:(length(paths) - 1)) {
    
    recursive_path <- paste0(paths[1:i], collapse = .Platform$file.sep)
    
    if (length(list.files(recursive_path, pattern = "\\.Rproj$"))) 
      stop("You have created an 'RStudio Project' inside a folder that ", 
           "is already an 'RStudio Project'.") 
  }
  
  invisible(NULL)
}



#' **Custom ui_*() message**
#' 
#' @noRd

ui_title <- function(texte) {
  
  
  ui_line()
  cat(clisymbols::symbol$radio_on, 
      crayon::bold(crayon::underline(texte)))
  ui_line()
  ui_line()
  
  invisible(NULL)
}



#' **List all Rd functions families**
#' 
#' @description 
#' This function parses all R functions to detect `@family` tag. For internal
#' purpose.
#' 
#' @return A vector of Rd function families.
#'
#' @noRd

get_rd_families <- function() {
  
  
  path <- path_proj()
  
  if (!dir.exists(file.path(path, "R")))
    stop("The directory 'R/' cannot be found.")
  
  
  x <- list.files(path = file.path(path, "R"), pattern = "\\.R$", 
                  full.names = TRUE, ignore.case = TRUE)
  
  
  if (!length(x)) {
    
    ui_oops("The {ui_value('R/')} folder is empty")
    
    return(NULL)
    
  } else {
    
    
    ## Read R files ----
    
    x <- lapply(x, function(x) readLines(con = x, warn = FALSE))
    
    
    ## Extract families names ----
    
    x <- lapply(x, function(x) x[grep("#'\\s{0,}@family", x)])
    x <- lapply(x, function(x) gsub("#'\\s{0,}@family ", "", x))
    
    return(sort(unique(unlist(x))))
  }
}




#' **Check if package name is valid**
#' 
#' @description 
#' This function checks if the package name is valid.
#' Inspired from `usethis:::valid_package_name()` - Thanks guys!.
#' 
#' @return `TRUE` or `FALSE`.
#'
#' @noRd

is_valid_name <- function() {

  pkg <- get_package_name()
  grepl("^[a-zA-Z][a-zA-Z0-9.]+$", pkg) && !grepl("\\.$", pkg)
}
