#' Initialize renv
#' 
#' @description 
#' This function initializes an `renv` environment for the project by running 
#' [renv::init()]. See \url{https://rstudio.github.io/renv/} for further detail.
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
#' add_renv()
#' }

add_renv <- function(quiet = FALSE) {
  
  stop_if_not_logical(quiet)
  
  if (!file.exists(file.path(path_proj(), "renv.lock"))) {
    
    
    ## Disable renv messages ----
    
    renv_verbose <- options()$"renv.verbose"
    on.exit(options("renv.verbose" = renv_verbose))
    options("renv.verbose" = FALSE)

    
    ## Init renv ----
    
    renv::init(bare = FALSE, restart = FALSE)

    if (!quiet) {
      
      ui_done("Creating {ui_value('renv/')}")
      ui_done("Writing {ui_value('.Rprofile')}")
      ui_done("Writing {ui_value('renv.lock')}")
      ui_line()
      ui_todo("Call {ui_code('renv::install()')} to install packages")
      ui_todo("Call {ui_code('renv::snapshot()')} to update the lockfile")  
    }
    
    
    ## Add renv files to .Rbuildignore ----
    
    add_to_buildignore("renv/")
    add_to_buildignore(".Rprofile")
    add_to_buildignore("renv.lock")
    
    
    ## Add renv files to .Rbuildignore ----
    
    add_to_gitignore("renv/")
    add_to_gitignore(".Rprofile")
    
    
    ## Add renv to Import tag in DESCRIPTION ----
    
    descr <- read_descr()
    
    deps <- c(get_deps_in_depends(), read_descr()$"Imports",
              read_descr()$"Suggests", read_descr()$"LinkingTo")
    
    deps_to_add <- c("renv")
    
    if (!is.null(deps)) {
      
      deps <- unlist(strsplit(deps, "\n\\s+|,|,\\s+"))
      deps <- deps[!(deps == "")]
      deps_to_add <- deps_to_add[!(deps_to_add %in% deps)]
    }
    
    
    if (length(deps_to_add)) {
      
      if (!is.null(descr$"Imports")) {
        
        deps_in_imports <- unlist(strsplit(descr$"Imports", "\n\\s+|,|,\\s+")) 
        deps_in_imports <- deps_in_imports[!(deps_in_imports == "")]
        
      } else {
        
        deps_in_imports <- character(0) 
      }
      
      deps_in_imports <- sort(unique(c(deps_in_imports, deps_to_add)))
      deps_in_imports <- paste0(deps_in_imports, collapse = ",\n    ")
      
      descr$"Imports" <- paste0("\n    ", deps_in_imports)
      
      if (!quiet) {
        msg <- paste0("Imports: ", gsub(",\n    ", ", ", deps_in_imports))
        ui_done(paste0("Adding the following line in ",
                       "{ui_value('DESCRIPTION')}: {ui_code(msg)}"))
      }
    }
    
    write_descr(descr)
    
    
    ## Update makefile ----
    
    path <- file.path(path_proj(), "make.R")
    
    if (file.exists(path)) {
      
      xfun::gsub_file(path, "devtools::install_deps(upgrade = \"never\")", 
                      "renv::restore()", fixed = TRUE)
    }
  }
  
  invisible(NULL)
}
