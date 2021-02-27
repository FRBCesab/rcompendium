#' @noRd

is_package <- function(path = ".") {
  
  if (!file.exists(file.path(path, "DESCRIPTION"))) {
    stop("The directory '", path, "' is not a package (no 'DESCRIPTION' file)")
  }
}



#' @noRd

get_package_name <- function(path = ".") {
  
  is_package(path)
  
  package_name <- read.dcf(file.path(path, "DESCRIPTION"))
  
  pkg_name <- as.character(package_name[1, "Package"])
  
  if (!length(pkg_name)) stop("Malformed 'DESCRIPTION' file")
  
  return(pkg_name)
}



#' @noRd

get_deps_in_functions_r <- function(path = ".") {
  
  if (!dir.exists(file.path(path, "R"))) {
    stop("The directory 'R/' cannot be found")
  }
  
  
  x <- list.files(path = file.path(path, "R"), pattern = "\\.R$", 
                  full.names = TRUE, ignore.case = TRUE)
  
  
  if (!length(x)) {
    
    ui_oops("The {ui_value('R/')} folder is empty")
    
    return(NULL)
    
  } else {
    
    
    ## Read R files ----
    
    x <- lapply(x, function(x) readLines(con = x, warn = FALSE))
    
    
    ## Remove comments ----
    
    x <- lapply(x, function(x) {
      comments <- grep("^\\s*#", x)
      if (length(comments)) x[-comments] else x })
    
    
    ## Functions called as pkg::fun() ----
    
    pattern <- "[A-Z|a-z|0-9|\\.]{1,}::[A-Z|a-z|0-9|\\.|_]{1,}"
    
    funs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    funs <- funs[!(funs %in% c("pkg", "pkg::fun"))]
    
    if (!length(funs)) {
      
      return(NULL)
      
    } else {
    
      return(sort(unique(funs)))
    }
  }
}



#' @noRd

get_deps_in_namespace <- function(path = ".") {
  
  if (file.exists(file.path(path, "NAMESPACE"))) {
    
    namespace <- readLines(con = file.path(path, "NAMESPACE"), warn = FALSE)
    
    imports <- gsub("importFrom\\(|import\\(|\\)", "", 
                        namespace[grep("^import", namespace)])
    
    if (!length(imports)) {
      
      return(NULL)
      
    } else {
    
      return(gsub(",", "::", imports))
    }
  
  } else {
    
    ui_oops("No {ui_value('NAMESPACE')} file found")
    return(NULL)
  }
}



#' @noRd

get_deps_in_examples <- function(path = ".") { 
  
  if (!dir.exists(file.path(path, "R"))) {
    stop("The directory 'R/' cannot be found")
  }
  
  x <- list.files(path = file.path(path, "R"), pattern = "\\.R$", 
                  full.names = TRUE, ignore.case = TRUE)
  
  if (!length(x)) {
    
    ui_oops("The {ui_value('R/')} folder is empty")
    
    return(NULL)
    
  } else {
    
    
    ## Read R files ----
    
    x <- lapply(x, function(x) readLines(con = x, warn = FALSE))
    
    
    ## Remove comments ----
    
    x <- lapply(x, function(x) x[grep("^\\s*#'", x)] )
    
    
    ## Functions called as pkg::fun() ----
    
    pattern <- "[A-Z|a-z|0-9|\\.]{1,}::[A-Z|a-z|0-9|\\.|_]{1,}"
    
    funs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    
    ## Attached Packages ----
    
    pattern <- c("library\\(([A-Z|a-z|0-9|\\.]{1,}|\"[A-Z|a-z|0-9|\\.]{1,}\")",
                 "require\\(([A-Z|a-z|0-9|\\.]{1,}|\"[A-Z|a-z|0-9|\\.]{1,}\")")
    pattern <- paste0(pattern, collapse = "|")
    
    pkgs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    pkgs <- gsub("library\\(|require\\(|\"", "", pkgs)
    
    
    ## Merge dependencies ----
    
    funs <- sort(unique(c(funs, pkgs)))
    funs <- funs[!(funs %in% c("pkg", "pkg::fun"))]
    
    if (!length(funs)) {
      
      return(NULL)
      
    } else {
      
      return(sort(unique(funs)))
    }
  }  
}



#' @noRd

get_deps_extra <- function(path = ".", import = NULL) { 

  if (is.null(import)) {
    return(NULL)
  }
  
  if (!dir.exists(file.path(path, import))) {
    return(NULL)
  }
  
  x <- list.files(path = file.path(path, import), pattern = "\\.R$|\\.Rmd$", 
                  full.names = TRUE, ignore.case = TRUE, recursive = TRUE)
  
  if (!length(x)) {
    
    ui_oops("The {ui_value(paste0(import, '/'))} folder is empty")
    
    return(NULL)
    
  } else {
    
    
    ## Read R files ----
    
    x <- lapply(x, function(x) readLines(con = x, warn = FALSE))
    
    
    ## Remove comments ----
    
    x <- lapply(x, function(x) {
      comments <- grep("^\\s*#", x)
      if (length(comments)) x[-comments] else x })
    
    
    ## Functions called as pkg::fun() ----
    
    pattern <- "[A-Z|a-z|0-9|\\.]{1,}::[A-Z|a-z|0-9|\\.|_]{1,}"
    
    funs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    
    ## Attached Packages ----
    
    pattern <- c("library\\(([A-Z|a-z|0-9|\\.]{1,}|\"[A-Z|a-z|0-9|\\.]{1,}\")",
                 "require\\(([A-Z|a-z|0-9|\\.]{1,}|\"[A-Z|a-z|0-9|\\.]{1,}\")")
    pattern <- paste0(pattern, collapse = "|")
    
    pkgs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    pkgs <- gsub("library\\(|require\\(|\"", "", pkgs)
    
    
    ## Merge dependencies ----
    
    funs <- sort(unique(c(funs, pkgs)))
    
    
    ## Check if .Rmd ----
    
    x <- list.files(path = file.path(path, import), pattern = "\\.Rmd$", 
                    full.names = TRUE, ignore.case = TRUE, recursive = TRUE)
    
    if (length(x)) funs <- sort(unique(c(funs, "knitr", "rmarkdown")))
    
    
    if (!length(funs)) {
      
      return(NULL)
      
    } else {
      
      return(sort(unique(funs)))
    }
  }  
}



#' @noRd

get_deps_in_vignettes <- function(path = ".", suggest = "vignettes") { 
  
  if (is.null(suggest)) {
    return(NULL)
  }
  
  if (!dir.exists(file.path(path, suggest))) {
    return(NULL)
  }
  
  x <- list.files(path = file.path(path, suggest), pattern = "\\.R$|\\.Rmd$", 
                  full.names = TRUE, ignore.case = TRUE, recursive = TRUE)
  
  if (!length(x)) {
    
    ui_oops("The {ui_value(paste0(suggest, '/'))} folder is empty")
    
    return(NULL)
    
  } else {
    
    
    ## Read R files ----
    
    x <- lapply(x, function(x) readLines(con = x, warn = FALSE))
    
    
    ## Remove comments ----
    
    x <- lapply(x, function(x) {
      comments <- grep("^\\s*#", x)
      if (length(comments)) x[-comments] else x })
    
    
    ## Functions called as pkg::fun() ----
    
    pattern <- "[A-Z|a-z|0-9|\\.]{1,}::[A-Z|a-z|0-9|\\.|_]{1,}"
    
    funs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    
    ## Attached Packages ----
    
    pattern <- c("library\\(([A-Z|a-z|0-9|\\.]{1,}|\"[A-Z|a-z|0-9|\\.]{1,}\")",
                 "require\\(([A-Z|a-z|0-9|\\.]{1,}|\"[A-Z|a-z|0-9|\\.]{1,}\")")
    pattern <- paste0(pattern, collapse = "|")
    
    pkgs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    pkgs <- gsub("library\\(|require\\(|\"", "", pkgs)
    
    
    ## Merge dependencies ----
    
    funs <- sort(unique(c(funs, pkgs)))
    
    
    ## Check if .Rmd ----
    
    x <- list.files(path = file.path(path, suggest), pattern = "\\.Rmd$", 
                    full.names = TRUE, ignore.case = TRUE, recursive = TRUE)
    
    if (length(x)) funs <- sort(unique(c(funs, "knitr", "rmarkdown")))
    
    
    if (!length(funs)) {
      
      return(NULL)
      
    } else {
      
      return(sort(unique(funs)))
    }
  } 
}



#' @noRd

get_deps_in_depends <- function(path = ".") {
  
  descr <- read_descr(path)
  
  if (!is.null(descr$"Depends")) {
    depends <- unlist(strsplit(descr$"Depends", "\n\\s+|,|,\\s+"))
    
    r_version <- grep("R \\(", depends)
    if (length(r_version)) depends <- depends[-r_version]
    
    return(depends[!(depends == "")])
  
  } else {
    
    return(NULL)
  }
}


#' @noRd

read_descr <- function(path = ".") { 
  
  is_package(path)
  
  descr <- read.dcf(file.path(path, "DESCRIPTION"), 
                    keep.white = c("Authors@R", "Depends", "Imports", 
                                   "Suggests"))
  
  if (nrow(descr) != 1) stop("Malformed 'DESCRIPTION' file")
  
  as.data.frame(descr)
}



#' @noRd

write_descr <- function(path = ".", descr_file) { 
  
  is_package(path)
  
  write.dcf(descr_file, file = file.path(path, "DESCRIPTION"), indent = 4, 
            width = 80, keep.white = c("Authors@R", "Depends", "Imports", 
                                       "Suggests"))
}


