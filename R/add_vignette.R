#' Create a vignette document
#'
#' @description 
#' This function adds a vignette in the folder `vignettes/`. It also adds
#' dependencies [`knitr`](https://yihui.org/knitr/) and 
#' [`rmarkdown`](https://rmarkdown.rstudio.com/) in the
#' field `Suggests` of the `DESCRIPTION` file (if not already present in
#' fields `Imports`).
#' 
#' @param filename a character of length 1
#' 
#'   The name of the `.Rmd` file to be created. If `NULL` (default )the `.Rmd` 
#'   file will be named `pkg.Rmd` where `pkg` is your package name.
#'   
#' @param title a character of length 1
#' 
#'   The title of the vignette. If `NULL` (default) the title will be 
#'   `Introduction to pkg` (where `pkg` is your package name).
#'   
#' @param open a logical value
#' 
#'   If `TRUE` (default) the file is opened in the editor.
#' 
#' @param overwrite a logical value
#' 
#'   If this file is already present and `overwrite = TRUE`, it will be erased 
#'   and replaced. Default is `FALSE`.
#'   
#' @param quiet a logical value
#' 
#'   If `TRUE` messages are deleted. Default is `FALSE`.
#' 
#' @return None
#'
#' @export
#' 
#' @family create files
#'
#' @examples
#' \dontrun{
#' ## Default vignette ----
#' add_vignette()
#' 
#' ## Custom vignette ----
#' add_vignette(filename = "get_started", title = "Get started")
#' }

add_vignette <- function(filename = NULL, title = NULL, open = TRUE, 
                         overwrite = FALSE, quiet = FALSE) { 
  
  
  stop_if_not_logical(open, overwrite, quiet)
  
  path <- path_proj()
  package_name <- get_package_name()
  
  
  if (is.null(title) && !is.null(filename)) {
    title <- gsub("\\.Rmd$", "", filename)
  }
  
  if (!is.null(title) && is.null(filename)) {
    
    filename <- gsub("[[:punct:]]|\\s", "_", title)
    filename <- gsub("_{1,}", "_", filename)
    filename <- tolower(filename)
  }
  
  if (is.null(filename)) {
    filename <- package_name
  } else {
    filename <- gsub("\\.Rmd$", "", filename)
  }
  
  filename <- paste0(filename, ".Rmd")
  path     <- file.path(path, "vignettes", filename)
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
    
    if (!open) {
      
      stop("A 'vignettes/", filename, "' file is already present. If you want ",
           "to replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  
    
  if (!dir.exists(file.path(path_proj(), "vignettes")))
    dir.create(file.path(path_proj(), "vignettes"), showWarnings = FALSE)
  
  invisible(
    file.copy(system.file(file.path("templates", "__VIGNETTE__"), 
                          package = "rcompendium"), path, overwrite = TRUE))
  
  
  ## Replace default values ----
  
  if (is.null(title)) 
    title <- "Introduction to {{project_name}}"
  
  xfun::gsub_file(path, "{{title}}", title, fixed = TRUE)
  xfun::gsub_file(path, "{{project_name}}", package_name, fixed = TRUE)
  
  
  ## Message ----
  
  if (!quiet) 
    ui_done("Writing {ui_value(paste0('vignettes/', filename))} file")
  
  
  ## Vignette .gitignore ----
  
  x <- c("*.html", "*.R")
  
  if (file.exists(file.path(path_proj(), "vignettes", ".gitignore"))) {
    
    git_ignore <- readLines(file.path(path_proj(), "vignettes", ".gitignore"))
    
    x <- x[!(x %in% git_ignore)]
    
    if (length(x)) {
      
      git_ignore <- c(git_ignore, x)
      writeLines(git_ignore, con = file.path(path_proj(), "vignettes", 
                                             ".gitignore"))
    }
    
  } else {
    
    if (!quiet) {
      ui_done(paste0("Writing {ui_value('vignettes/.gitignore')} file"))
    }
    
    writeLines(x, con = file.path(path_proj(), "vignettes", ".gitignore"))
  }
  
  
  ## Add dependencies ----
  
  descr <- read_descr()
  
  if (is.null(descr$"VignetteBuilder")) {
    
    descr$"VignetteBuilder" <- "knitr"
    
    if (!quiet) 
      ui_done(paste0("Adding the following line in ",
                     "{ui_value('DESCRIPTION')}: ",
                     "{ui_code('VignetteBuilder: knitr')}"))
  }
  
  deps <- c(get_deps_in_depends(), read_descr()$"Imports",
            read_descr()$"Suggests", read_descr()$"LinkingTo")

  deps_to_add <- c("knitr", "rmarkdown")
  
  if (!is.null(deps)) {

    deps <- unlist(strsplit(deps, "\n\\s+|,|,\\s+"))
    deps <- deps[!(deps == "")]
    deps_to_add <- deps_to_add[!(deps_to_add %in% deps)]
  }
  
  
  
  if (length(deps_to_add)) {
    
    if (!is.null(descr$"Suggests")) {
      
      deps_in_suggests <- unlist(strsplit(descr$"Suggests", "\n\\s+|,|,\\s+")) 
      deps_in_suggests <- deps_in_suggests[!(deps_in_suggests == "")]
      
    } else {
      
      deps_in_suggests <- character(0) 
    }
    
    deps_in_suggests <- sort(unique(c(deps_in_suggests, deps_to_add)))
    deps_in_suggests <- paste0(deps_in_suggests, collapse = ",\n    ")
    
    descr$"Suggests" <- paste0("\n    ", deps_in_suggests)
    
    if (!quiet) {
      msg <- paste0("Suggests: ", gsub(",\n    ", ", ", deps_in_suggests))
      ui_done(paste0("Adding the following line in ",
                     "{ui_value('DESCRIPTION')}: {ui_code(msg)}"))
    }
  }
  
  write_descr(descr)
  
  
  if (open) edit_file(path)
  invisible(NULL)
}
