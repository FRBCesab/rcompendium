## Utilities functions - External Dependencies ----



#' **Detect dependencies in R functions**
#' 
#' Detect dependencies in R functions as `pkg::fun()`.
#' 
#' @noRd

get_deps_in_functions_r <- function() {
  
  
  is_package()
  path <- path_proj()
  
  # if (!dir.exists(file.path(path, "R"))) {
  #   stop("The directory 'R/' cannot be found.")
  # }
  
  
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
    
    
    ## Remove messages ----
    
    x <- lapply(x, function(x) gsub("\".{0,}\'.{0,}\'.{0,}\"", "", x))
    x <- lapply(x, function(x) gsub("\'.{0,}\".{0,}\".{0,}\'", "", x))
    x <- lapply(x, function(x) gsub("\".{0,}\\\".{0,}\\\".{0,}\"", "", x))
    x <- lapply(x, function(x) gsub("\'.{0,}\\\'.{0,}\\\'.{0,}\'", "", x))
    
    
    ## Functions called as pkg::fun() ----
    
    pattern <- paste0("[A-Z|a-z|0-9|\\.]{1,}\\s{0,}", 
                      "::", 
                      "\\s{0,}[A-Z|a-z|0-9|\\.|_]{1,}")
    
    funs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    funs <- gsub("\\s", "", funs)
    
    
    ## Attached Packages ----
    
    pattern <- c(paste0("library\\s{0,}\\(\\s{0,}([A-Z|a-z|0-9|\\.]{1,}|",
                        "\"\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\"|",
                        "\'\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\')"),
                 paste0("require\\s{0,}\\(\\s{0,}([A-Z|a-z|0-9|\\.]{1,}|",
                        "\"\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\"|",
                        "\'\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\')"))
    pattern <- paste0(pattern, collapse = "|")
    
    pkgs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    pkgs <- gsub("\\s", "", pkgs)
    pkgs <- gsub("library\\(|require\\(|\"|\'", "", pkgs)
    
    
    ## Merge dependencies ----
    
    funs <- sort(unique(c(funs, pkgs)))
    
    
    if (!length(funs)) {
      
      return(NULL)
      
    } else {
      
      pos <- grep(get_package_name(), funs)
      if (length(pos)) funs <- funs[-pos]
      
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
  
  
  is_package()
  path <- path_proj()
  
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



#' **Detect dependencies in @examples**
#' 
#' Detect dependencies in **@examples** as `pkg::fun()`, `library(pkg)`, and
#' `require(pkg)`.
#' 
#' @note Not perfect - Need to detect exactly @@examples
#' 
#' @noRd

get_deps_in_examples <- function() { 
  
  
  is_package()
  path <- path_proj()
  
  if (!dir.exists(file.path(path, "R"))) {
    stop("The directory 'R/' cannot be found.")
  }
  
  x <- list.files(path = file.path(path, "R"), pattern = "\\.R$", 
                  full.names = TRUE, ignore.case = TRUE)
  
  if (!length(x)) {
    
    return(NULL)
    
  } else {
    
    
    ## Read R files ----
    
    x <- lapply(x, function(x) readLines(con = x, warn = FALSE))
    
    
    ## Select roxygen2 headers ----
    
    x <- lapply(x, function(x) x[grep("^\\s*#'", x)])
    
    
    ## Select @examples sections (dirty code, but working) ----
    
    ex_start <- lapply(x, function(x) grep("#'\\s{0,}@examples", x))
    ex_end   <- lapply(x, function(x) grep("#'\\s{0,}@", x))
    
    examples <- list()
    
    for (i in seq_len(length(ex_start))) {
      
      examples[[i]] <- character(0)
      
      if (length(ex_start[[i]])) {
        
        for (j in seq_len(length(ex_start[[i]]))) {
          
          pos <- ex_end[[i]][ex_end[[i]] > ex_start[[i]][j]] 
          
          if (length(pos)) {
            examples[[i]] <- c(examples[[i]], 
                               x[[i]][(ex_start[[i]][j] + 1):(pos[1] - 1)])
          } else {
            examples[[i]] <- c(examples[[i]], 
                               x[[i]][(ex_start[[i]][j] + 1):length(x[[i]])])
          }
        }
      }
    }
    
    x <- examples
    
    
    ## Functions called as pkg::fun() ----
    
    pattern <- paste0("[A-Z|a-z|0-9|\\.]{1,}\\s{0,}", 
                      "::", 
                      "\\s{0,}[A-Z|a-z|0-9|\\.|_]{1,}")
    
    funs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    funs <- gsub("\\s", "", funs)
    
    
    ## Attached Packages ----
    
    pattern <- c(paste0("library\\s{0,}\\(\\s{0,}([A-Z|a-z|0-9|\\.]{1,}|",
                        "\"\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\"|",
                        "\'\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\')"),
                 paste0("require\\s{0,}\\(\\s{0,}([A-Z|a-z|0-9|\\.]{1,}|",
                        "\"\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\"|",
                        "\'\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\')"))
    pattern <- paste0(pattern, collapse = "|")
    
    pkgs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    pkgs <- gsub("\\s", "", pkgs)
    pkgs <- gsub("library\\(|require\\(|\"|\'", "", pkgs)
    
    
    ## Merge dependencies ----
    
    funs <- sort(unique(c(funs, pkgs)))
    funs <- funs[!(funs %in% c("pkg", "pkg::fun"))]
    
    if (!length(funs)) {
      
      return(NULL)
      
    } else {
      
      pos <- grep(get_package_name(), funs)
      if (length(pos)) funs <- funs[-pos]
      
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

get_deps_extra <- function(compendium = NULL) { 
  
  
  if (is.null(compendium)) return(NULL)
  
  stop_if_not_string(compendium)
  
  is_package()
  path <- path_proj()
  
  if (compendium != "." && compendium != getwd() && compendium != path) {
    path <- file.path(path, compendium)
  }
  
  if (!dir.exists(path)) return(NULL)
  
  x <- list.files(path, 
                  pattern = "\\.R$|\\.Rmd$", full.names = TRUE, 
                  ignore.case = TRUE, recursive = TRUE)
  
  pos <- grep(paste0(.Platform$file.sep, 
                     "(tests|vignettes|inst|renv)", 
                     .Platform$file.sep, "|README"), x)
  
  if (length(pos)) x <- x[-pos]
  
  if (!length(x)) {
    
    ui_oops("The {ui_value(paste0(compendium, '/'))} folder is empty")
    
    return(NULL)
    
  } else {
    
    
    ## Read R files ----
    
    x <- lapply(x, function(x) readLines(con = x, warn = FALSE))
    
    
    ## Remove comments ----
    
    x <- lapply(x, function(x) {
      comments <- grep("^\\s*#", x)
      if (length(comments)) x[-comments] else x })
    
    
    ## Remove messages ----
    
    x <- lapply(x, function(x) gsub("\".{0,}\'.{0,}\'.{0,}\"", "", x))
    x <- lapply(x, function(x) gsub("\'.{0,}\".{0,}\".{0,}\'", "", x))
    x <- lapply(x, function(x) gsub("\".{0,}\\\".{0,}\\\".{0,}\"", "", x))
    x <- lapply(x, function(x) gsub("\'.{0,}\\\'.{0,}\\\'.{0,}\'", "", x))
    
    
    ## Functions called as pkg::fun() ----
    
    pattern <- paste0("[A-Z|a-z|0-9|\\.]{1,}\\s{0,}", 
                      "::", 
                      "\\s{0,}[A-Z|a-z|0-9|\\.|_]{1,}")
    
    funs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    funs <- gsub("\\s", "", funs)
    
    
    ## Attached Packages ----
    
    pattern <- c(paste0("library\\s{0,}\\(\\s{0,}([A-Z|a-z|0-9|\\.]{1,}|",
                        "\"\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\"|",
                        "\'\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\')"),
                 paste0("require\\s{0,}\\(\\s{0,}([A-Z|a-z|0-9|\\.]{1,}|",
                        "\"\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\"|",
                        "\'\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\')"))
    pattern <- paste0(pattern, collapse = "|")
    
    pkgs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    pkgs <- gsub("\\s", "", pkgs)
    pkgs <- gsub("library\\(|require\\(|\"|\'", "", pkgs)
    
    
    ## Merge dependencies ----
    
    funs <- sort(unique(c(funs, pkgs)))
    
    
    ## Check if .Rmd ----
    
    x <- list.files(path, pattern = "\\.Rmd$", 
                    full.names = TRUE, ignore.case = TRUE, recursive = TRUE)
    
    pos <- grep(paste0(.Platform$file.sep, 
                       "(tests|vignettes|inst|renv)", 
                       .Platform$file.sep, "|README"), x)
    
    if (length(pos)) x <- x[-pos]
    
    if (length(x)) funs <- sort(unique(c(funs, "knitr", "rmarkdown")))
    
    
    if (!length(funs)) {
      
      return(NULL)
      
    } else {
      
      pos <- grep(get_package_name(), funs)
      if (length(pos)) funs <- funs[-pos]
      
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

get_deps_in_vignettes <- function() { 
  
  
  is_package()
  path <- path_proj()
  
  
  if (!dir.exists(file.path(path, "vignettes"))) {
    # ui_oops("No {ui_value('vignettes/')} folder found.")
    return(NULL)
  }
  
  x <- list.files(path = file.path(path, "vignettes"), 
                  pattern = "\\.R$|\\.Rmd$|\\.qmd$", full.names = TRUE, 
                  ignore.case = TRUE, recursive = TRUE)
  
  if (!length(x)) {
    
    ui_oops("The {ui_value('vignettes/')} folder is empty")
    
    return(NULL)
    
  } else {
    
    
    ## Read R files ----
    
    x <- lapply(x, function(x) readLines(con = x, warn = FALSE))
    
    
    ## Remove comments ----
    
    x <- lapply(x, function(x) {
      comments <- grep("^\\s*#", x)
      if (length(comments)) x[-comments] else x })
    
    
    ## Remove messages ----
    
    x <- lapply(x, function(x) gsub("\".{0,}\'.{0,}\'.{0,}\"", "", x))
    x <- lapply(x, function(x) gsub("\'.{0,}\".{0,}\".{0,}\'", "", x))
    x <- lapply(x, function(x) gsub("\".{0,}\\\".{0,}\\\".{0,}\"", "", x))
    x <- lapply(x, function(x) gsub("\'.{0,}\\\'.{0,}\\\'.{0,}\'", "", x))
    
    
    ## Remove inline code (not evaluated) ----
    
    pattern <- paste0("`[A-Z|a-z|0-9|\\.]{1,}\\s{0,}", 
                      "::", 
                      "\\s{0,}[A-Z|a-z|0-9|\\.|_]{1,}")
    
    x <- lapply(x, function(x) gsub(pattern, "", x))
    
    
    ## Functions called as pkg::fun() ----
    
    pattern <- paste0("[A-Z|a-z|0-9|\\.]{1,}\\s{0,}", 
                      "::", 
                      "\\s{0,}[A-Z|a-z|0-9|\\.|_]{1,}")
    
    funs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    funs <- gsub("\\s", "", funs)
    
    
    ## Attached Packages ----
    
    pattern <- c(paste0("library\\s{0,}\\(\\s{0,}([A-Z|a-z|0-9|\\.]{1,}|",
                        "\"\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\"|",
                        "\'\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\')"),
                 paste0("require\\s{0,}\\(\\s{0,}([A-Z|a-z|0-9|\\.]{1,}|",
                        "\"\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\"|",
                        "\'\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\')"))
    pattern <- paste0(pattern, collapse = "|")
    
    pkgs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    pkgs <- gsub("\\s", "", pkgs)
    pkgs <- gsub("library\\(|require\\(|\"|\'", "", pkgs)
    
    
    ## Merge dependencies ----
    
    funs <- sort(unique(c(funs, pkgs)))
    
    
    ## Check if .Rmd ----
    
    x <- list.files(path = file.path(path, "vignettes"), pattern = "\\.Rmd$", 
                    full.names = TRUE, ignore.case = TRUE, recursive = TRUE)
    
    if (length(x)) funs <- sort(unique(c(funs, "knitr", "rmarkdown")))
    
    
    if (!length(funs)) {
      
      return(NULL)
      
    } else {
      
      pos <- grep(get_package_name(), funs)
      if (length(pos)) funs <- funs[-pos]
      
      return(sort(unique(funs)))
    }
  } 
}



#' **Detect dependencies in TESTS**
#' 
#' Detect dependencies in Tests as `pkg::fun()`, `library(pkg)`, 
#' and `require(pkg)`.
#' 
#' @noRd

get_deps_in_tests <- function() { 
  
  
  is_package()
  path <- path_proj()
  
  
  if (!dir.exists(file.path(path, "tests"))) {
    # ui_oops("No {ui_value('tests/')} folder found.")
    return(NULL)
  }
  
  x <- list.files(path = file.path(path, "tests"), 
                  pattern = "\\.R$", full.names = TRUE, 
                  ignore.case = TRUE, recursive = TRUE)
  
  if (!length(x)) {
    
    ui_oops("The {ui_value('tests/')} folder is empty")
    
    return(NULL)
    
  } else {
    
    
    ## Read R files ----
    
    x <- lapply(x, function(x) readLines(con = x, warn = FALSE))
    
    
    ## Remove comments ----
    
    x <- lapply(x, function(x) {
      comments <- grep("^\\s*#", x)
      if (length(comments)) x[-comments] else x })
    
    
    ## Remove messages ----
    
    x <- lapply(x, function(x) gsub("\".{0,}\'.{0,}\'.{0,}\"", "", x))
    x <- lapply(x, function(x) gsub("\'.{0,}\".{0,}\".{0,}\'", "", x))
    x <- lapply(x, function(x) gsub("\".{0,}\\\".{0,}\\\".{0,}\"", "", x))
    x <- lapply(x, function(x) gsub("\'.{0,}\\\'.{0,}\\\'.{0,}\'", "", x))
    
    
    ## Functions called as pkg::fun() ----
    
    pattern <- paste0("[A-Z|a-z|0-9|\\.]{1,}\\s{0,}", 
                      "::", 
                      "\\s{0,}[A-Z|a-z|0-9|\\.|_]{1,}")
    
    funs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    funs <- gsub("\\s", "", funs)
    
    
    ## Attached Packages ----
    
    pattern <- c(paste0("library\\s{0,}\\(\\s{0,}([A-Z|a-z|0-9|\\.]{1,}|",
                        "\"\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\"|",
                        "\'\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\')"),
                 paste0("require\\s{0,}\\(\\s{0,}([A-Z|a-z|0-9|\\.]{1,}|",
                        "\"\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\"|",
                        "\'\\s{0,}[A-Z|a-z|0-9|\\.]{1,}\\s{0,}\')"))
    pattern <- paste0(pattern, collapse = "|")
    
    pkgs <- unlist(lapply(x, function(x) {
      unlist(stringr::str_extract_all(x, pattern))
    }))
    
    pkgs <- gsub("\\s", "", pkgs)
    pkgs <- gsub("library\\(|require\\(|\"|\'", "", pkgs)
    
    
    ## Merge dependencies ----
    
    funs <- sort(unique(c(funs, pkgs)))
    
    
    if (!length(funs)) {
      
      return(NULL)
      
    } else {
      
      pos <- grep(get_package_name(), funs)
      if (length(pos)) funs <- funs[-pos]
      
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
    
    deps <- unlist(strsplit(descr$"Depends", "\n\\s+|,|,\\s+"))
    
    r_version <- grep("R \\(", deps)
    if (length(r_version)) deps <- deps[-r_version]
    
    deps <- deps[!(deps == "")]
    return(gsub("\\s{0,}\\(.*\\)", "", deps))
    
  } else {
    
    return(NULL)
  }
}



#' **Detect dependencies in Imports field of DESCRIPTION**
#' 
#' Detect dependencies in the `Imports` field of **DESCRIPTION**.
#' 
#' @noRd

get_deps_in_imports <- function() {
  
  descr <- read_descr()
  
  if (!is.null(descr$"Imports")) {
    
    deps <- unlist(strsplit(descr$"Imports", "\n\\s+|,|,\\s+"))
    
    return(deps[!(deps == "")])
    
  } else {
    
    return(NULL)
  }
}



#' **Detect dependencies in Suggests field of DESCRIPTION**
#' 
#' Detect dependencies in the `Suggests` field of **DESCRIPTION**.
#' 
#' @noRd

get_deps_in_suggests <- function() {
  
  descr <- read_descr()
  
  if (!is.null(descr$"Suggests")) {
    
    deps <- unlist(strsplit(descr$"Suggests", "\n\\s+|,|,\\s+"))
    
    return(deps[!(deps == "")])
    
  } else {
    
    return(NULL)
  }
}
