#' **Detect dependencies in R functions**
#' 
#' Detect dependencies in R functions as `pkg::fun()`.
#' 
#' @noRd

get_deps_in_functions_r <- function() {
  
  if (!dir.exists(here::here("R"))) {
    stop("The directory 'R/' cannot be found.")
  }
  
  
  x <- list.files(path = here::here("R"), pattern = "\\.R$", 
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



#' **Detect dependencies in NAMESPACE**
#' 
#' Detect dependencies in NAMESPACE as `import(pkg)` and `importFrom(pkg,fun)`.
#' 
#' @noRd

get_deps_in_namespace <- function() {
  
  if (file.exists(here::here("NAMESPACE"))) {
    
    namespace <- readLines(con = here::here("NAMESPACE"), warn = FALSE)
    
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



#' **Detect dependencies in @examples**
#' 
#' Detect dependencies in **@examples** as `pkg::fun()`, `library(pkg)`, and
#' `require(pkg)`.
#' 
#' @noRd

get_deps_in_examples <- function() { 
  
  if (!dir.exists(here::here("R"))) {
    stop("The directory 'R/' cannot be found.")
  }
  
  x <- list.files(path = here::here("R"), pattern = "\\.R$", 
                  full.names = TRUE, ignore.case = TRUE)
  
  if (!length(x)) {
    
    return(NULL)
    
  } else {
    
    
    ## Read R files ----
    
    x <- lapply(x, function(x) readLines(con = x, warn = FALSE))
    
    
    ## Select comments ----
    
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



#' **Detect dependencies in EXTRA folder**
#' 
#' Detect dependencies in additional folder as `pkg::fun()`, `library(pkg)`, 
#' and `require(pkg)`. If `.Rmd` files are detected packages `knitr` and 
#' `rmarkdown` are added to function return.
#' 
#' @noRd

get_deps_extra <- function(import = NULL) { 
  
  if (is.null(import)) {
    return(NULL)
  }
  
  if (!dir.exists(here::here(import))) {
    return(NULL)
  }
  
  x <- list.files(path = here::here(import), pattern = "\\.R$|\\.Rmd$", 
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
    
    x <- list.files(path = here::here(import), pattern = "\\.Rmd$", 
                    full.names = TRUE, ignore.case = TRUE, recursive = TRUE)
    
    if (length(x)) funs <- sort(unique(c(funs, "knitr", "rmarkdown")))
    
    
    if (!length(funs)) {
      
      return(NULL)
      
    } else {
      
      return(sort(unique(funs)))
    }
  }  
}



#' **Detect dependencies in VIGNETTES**
#' 
#' Detect dependencies in Vignettes as `pkg::fun()`, `library(pkg)`, 
#' and `require(pkg)`. If `.Rmd` files are detected packages `knitr` and 
#' `rmarkdown` are added to function return.
#' 
#' @noRd

get_deps_in_vignettes <- function(suggest = "vignettes") { 
  
  if (is.null(suggest)) {
    return(NULL)
  }
  
  if (!dir.exists(here::here(suggest))) {
    return(NULL)
  }
  
  x <- list.files(path = here::here(suggest), pattern = "\\.R$|\\.Rmd$", 
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
    
    x <- list.files(path = here::here(suggest), pattern = "\\.Rmd$", 
                    full.names = TRUE, ignore.case = TRUE, recursive = TRUE)
    
    if (length(x)) funs <- sort(unique(c(funs, "knitr", "rmarkdown")))
    
    
    if (!length(funs)) {
      
      return(NULL)
      
    } else {
      
      return(sort(unique(funs)))
    }
  } 
}



#' **Detect dependencies in Depends field of DESCRIPTION**
#' 
#' Detect dependencies in the `Depends` field of **DESCRIPTION**.
#' 
#' @noRd

get_deps_in_depends <- function() {
  
  descr <- read_descr()
  
  if (!is.null(descr$"Depends")) {
    depends <- unlist(strsplit(descr$"Depends", "\n\\s+|,|,\\s+"))
    
    r_version <- grep("R \\(", depends)
    if (length(r_version)) depends <- depends[-r_version]
    
    return(depends[!(depends == "")])
    
  } else {
    
    return(NULL)
  }
}
