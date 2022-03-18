#' Create compendium folders
#' 
#' @description
#' This function creates the following additional folders `data/`, `analyses/`, 
#' `outputs/`, and `figures/`. Each folder has a `README.md` to provide
#' instructions. The argument `compendium` allows user to choose if these 
#' folders are created at the root of the project (default) or nested inside a 
#' parent directory. All theses folders are added to the `.Rbuildignore` file.
#' 
#' @param compendium A character of length 1. By default, compendium folders 
#'   are created at the root of the project. User can change their location 
#'   with this argument. For instance, if `compendium = 'analysis'`, compendium
#'   folders will be created inside the directory `analysis/`.
#' 
#' @return No return value.
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
    dir.create(file.path(path, "data", "raw-data"), recursive = TRUE)
    dir.create(file.path(path, "data", "derived-data"), recursive = TRUE)
    
    readme <- c("# README",
                "", 
                "This folder contains all raw data.", 
                "**Do not** modify these data")
    
    writeLines(readme, con = file.path(path, "data", "raw-data", "README.md"))
    
    readme <- c("# README",
                "", 
                "This folder contains all derived data.")
    
    writeLines(readme, con = file.path(path, "data", "derived-data", 
                                       "README.md"))
    
    
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
                "This folder contains all your results")
    
    writeLines(readme, con = file.path(path, "outputs", "README.md"))
    
    
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
                "This folder contains all your figures")
    
    writeLines(readme, con = file.path(path, "figures", "README.md"))
    
    
    if (!is.null(compendium)) {
      
      msg <- paste0(compendium, "/figures/")
      
    } else {
      
      msg <- "figures/"
    }
    
    ui_done("Creating {ui_value(msg)} directory")
    
    if (is.null(compendium)) add_to_buildignore("figures")
    
    ui_line()
  }
  
  
  ## Create analyses/ folder ----
  
  if (!dir.exists(file.path(path, "analyses"))) {
    
    dir.create(file.path(path, "analyses"), recursive = TRUE)
    
    readme <- c("# README",
                "", 
                "This folder contains all your analyses of the project.",
                paste0("It contains only R scripts (R functions must be ", 
                       "stored in the R/ folder)."))
    
    writeLines(readme, con = file.path(path, "analyses", "README.md"))
    
    
    if (!is.null(compendium)) {
      
      msg <- paste0(compendium, "/analyses/")
      
    } else {
      
      msg <- "analyses/"
    }
    
    ui_done("Creating {ui_value(msg)} directory")
    
    if (is.null(compendium)) add_to_buildignore("analyses")
    
    ui_line()
  }
  
  invisible(NULL)
}
