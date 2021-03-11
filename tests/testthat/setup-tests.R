#' Setup Tests Infrastructure
#' 

## Temporary Directory ----

create_temp_compendium <- function(pkg = file.path(tempdir(), "pkgtest")) {
  
  old_wd <- getwd()
  
  withr::defer(fs::dir_delete(pkg), envir = parent.frame())
  
  dir.create(pkg)
  
  setwd(pkg)
  invisible(file.create(".here"))
  
  withr::defer(setwd(old_wd), envir = parent.frame())
  
  invisible(pkg)
}
