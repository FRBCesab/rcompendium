#' Create compendium folders
#' 
#' @description
#' This function creates the following additional folders `data/`, `rscripts/`, 
#' `outputs/`, `figures/`, and `paper/`. Each folder has a README to provide
#' instructions. The argument compendium allows user to choose if these folders
#' are created at the root of the project (default) or nested inside a parent
#' directory. All theses folders area added to `.Rbuildignore`.
#' 
#' @param compendium a character of length 1
#' 
#'   By default, compendium folders are created at the root of the project. 
#'   User can change their location with this argument. For instance, if
#'   `compendium = 'analysis'`, compendium folders will be created inside the 
#'   directory `analysis/`.
#' 
#' @return None
#'
#' @export
#' 
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_compendium()
#' }

add_compendium <- function(compendium = ".") {
  
  
  if (is.null(compendium)) return(invisible(NULL))
  
  stop_if_not_string(compendium)
  
  path <- path_proj()
  
  if (compendium != "." && compendium != getwd() && compendium != path) {
    
    if (length(strsplit(compendium, "/|\\\\")[[1]]) > 1)
      stop("Argument 'compendium' must be a non-nested folder.")
    
    path <- file.path(path, compendium)
  
  } else {
    
    compendium <- NULL
  }
  
  
  if (!dir.exists(path)) {
    
    dir.create(path, recursive = TRUE)
    
    if (!is.null(compendium)) {
      
      ui_done("Creating {ui_value(compendium)} directory")
      add_to_buildignore(compendium)
      ui_line()
    }
  }
  
  
  ## Create data/ folder ----
  
  if (!dir.exists(file.path(path, "data"))) {
    
    dir.create(file.path(path, "data"), recursive = TRUE)
    
    readme <- c("# README",
                "", 
                "This folder contains all raw data.", 
                paste0("**NEVER** modify these data: modified data must be ", 
                       "exported in the outputs/ folder."))
    
    writeLines(readme, con = file.path(path, "data", "README"))
    
    
    if (!is.null(compendium)) {
      
      msg <- paste0(compendium, "/data/")
      
    } else {
      
      msg <- "data/"
    }
    
    ui_done("Creating {ui_value(msg)} directory")
    
    if (is.null(compendium)) {
      
      add_to_buildignore("data")
      
    } else {
      
      add_to_gitignore(paste0(compendium, "/data"))
    }
    ui_line()
  }
  
  
  ## Create outputs/ folder ----
  
  if (!dir.exists(file.path(path, "outputs"))) {
    
    dir.create(file.path(path, "outputs"), recursive = TRUE)
    
    readme <- c("# README",
                "", 
                paste0("This folder contains all results created by user ", 
                       "(including modified raw data)."))
    
    writeLines(readme, con = file.path(path, "outputs", "README"))
    
    
    if (!is.null(compendium)) {
      
      msg <- paste0(compendium, "/outputs/")
      
    } else {
      
      msg <- "outputs/"
    }
    
    ui_done("Creating {ui_value(msg)} directory")
    
    if (is.null(compendium)) add_to_buildignore("outputs")
    
    ui_line()
  }
  
  
  ## Create figures/ folder ----
  
  if (!dir.exists(file.path(path, "figures"))) {
    
    dir.create(file.path(path, "figures"), recursive = TRUE)
    
    readme <- c("# README",
                "", 
                paste0("This folder contains all figures created by user."))
    
    writeLines(readme, con = file.path(path, "figures", "README"))
    
    
    if (!is.null(compendium)) {
      
      msg <- paste0(compendium, "/figures/")
      
    } else {
      
      msg <- "figures/"
    }
    
    ui_done("Creating {ui_value(msg)} directory")
    
    if (is.null(compendium)) add_to_buildignore("figures")
    
    ui_line()
  }
  
  
  ## Create rscripts/ folder ----
  
  if (!dir.exists(file.path(path, "rscripts"))) {
    
    dir.create(file.path(path, "rscripts"), recursive = TRUE)
    
    readme <- c("# README",
                "", 
                paste0("This folder contains all analyses of the project."),
                paste0("It contains only R scripts (R functions must be ", 
                       "stored in the R/ folder)."))
    
    writeLines(readme, con = file.path(path, "rscripts", "README"))
    
    
    if (!is.null(compendium)) {
      
      msg <- paste0(compendium, "/rscripts/")
      
    } else {
      
      msg <- "rscripts/"
    }
    
    ui_done("Creating {ui_value(msg)} directory")
    
    if (is.null(compendium)) add_to_buildignore("rscripts")
    
    ui_line()
  }
  
  
  ## Create paper/ folder ----
  
  if (!dir.exists(file.path(path, "paper"))) {
    
    dir.create(file.path(path, "paper"), recursive = TRUE)
    
    readme <- c("# README",
                "", 
                paste0("This folder contains manuscript materials ",
                       "(biblio, templates, Rmd, etc.)."))
    
    writeLines(readme, con = file.path(path, "paper", "README"))
    
    
    if (!is.null(compendium)) {
      
      msg <- paste0(compendium, "/paper/")
      
    } else {
      
      msg <- "paper/"
    }
    
    ui_done("Creating {ui_value(msg)} directory")
    
    if (is.null(compendium)) add_to_buildignore("paper")
    
    ui_line()
  }
  
  invisible(NULL)
}
