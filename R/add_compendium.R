#' Create additional folders
#' 
#' @description
#' This function creates a compendium, i.e. additional folders to a package 
#' structure. By default, the following directories are created: 
#' `data/raw-data`, `data/derived-data`, `analyses/`, `outputs/`, and 
#' `figures/`. A `README.md` is added to each folder and must be edited. The 
#' argument `compendium` allows user to choose its own compendium structure. 
#' All theses folders are added to the `.Rbuildignore` file.
#' 
#' @param compendium A character vector specifying the folders to be created.
#'   
#' @param quiet A logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
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
#' add_compendium(compendium = "paper")
#' add_compendium(compendium = c("data", "outputs", "code", "manuscript"))
#' }

add_compendium <- function(compendium = NULL, quiet = FALSE) {
  
  stop_if_not_logical(quiet)
  
  if (is.null(compendium)) {
    compendium <- c("data/raw-data", "data/derived-data", "outputs", "figures",
                    "analyses")
  }
  
  if (!is.character(compendium)) {
    stop("Argument 'compendium' must be a character.")
  }
  
  path <- path_proj()
  
  for (i in 1:length(compendium)) {
    
    if (!dir.exists(file.path(path, compendium[i]))) {
      
      dir.create(file.path(path, compendium[i]), recursive = TRUE)
      
      if (!quiet) {
        ui_done("Creating {ui_value(paste0(compendium[i], '/'))} directory")
      }
    }
      
    add_to_buildignore(compendium, quiet = quiet)
    
    
    if (!file.exists(file.path(path, compendium[i], "README.md"))) {
    
      readme <- c("# README",
                  "", 
                  "**{{ PLEASE DESCRIBE THE CONTENT OF THIS FOLDER}}**")
      
      writeLines(readme, con = file.path(path, compendium[i], "README.md"))
      
      if (!quiet) {
        
        ui_done(paste0("Adding a {ui_value('README.md')} to ", 
                       "{ui_value(paste0(compendium[i], '/'))} directory"))
        ui_line()
      }
    }
  }
  
  invisible(NULL)
}
