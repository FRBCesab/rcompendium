#' Add a LICENSE
#' 
#' @description 
#' This function adds a license to the project.
#'
#' @param license a character of length 1. The chosen license. Use 
#'   [get_licenses()]) to select an appropriate one.
#' 
#' @param given a character of length 1. User given name of the copyright 
#'   holder. Only required if `license = 'MIT'`. If is `NULL` (default) and 
#'   `license = 'MIT'`, this function will try to retrieve the value of this 
#'   parameter from the `.Rprofile` file (edited with [set_credentials()]).
#'   
#' @param family a character of length 1. User family name of the copyright 
#'   holder. Only required if `license = 'MIT'`. If is `NULL` (default) and 
#'   `license = 'MIT'`, this function will try to retrieve the value of this 
#'   parameter from the `.Rprofile` file (edited with [set_credentials()]).
#'   
#' @param quiet a logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#'   
#' @export
#' 
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_license(license = "MIT")
#' add_license(license = "GPL (>= 2)")
#' }

add_license <- function(license = NULL, given = NULL, family = NULL, 
                        quiet = FALSE) {
  
  
  ## Check Input ----
  
  if (is.null(license)) {
    stop("Please specify your license with the argument `license`. Run ", 
         "`get_licenses()` to select an appropriate one.")
  }
  
  license_id <- which(licenses$tag == license)
  
  if (!length(license_id)) {
    stop("Invalid license. Please use `get_licenses()` to select an ",
         "appropriate one.")
  }
  
  if (license == "MIT") {
    
    if (is.null(given)) {
      given <- getOption("given")
      if (is.null(given)) {
        stop("Given name of the coypright holder is mandatory with the ",
             "license MIT. Please use the argument `given` or the function ",
             "`set_credentials()`.")
      }
    }
    
    if (is.null(family)) {
      family <- getOption("family")
      if (is.null(family)) {
        stop("Family name of the coypright holder is mandatory with the ",
             "license MIT. Please use the argument `family` or the function ",
             "`set_credentials()`.")
      }
    }
    
    year <- format(Sys.Date(), "%Y")
  }

  
  ## Check if new license ----
  
  descr_license <- read_descr()$"License"
  descr_license <- gsub(" \\+ file LICENSE", "", descr_license)
  
  if (!is.null(descr_license)) {
    
    if (descr_license == license) {
    
      if (!quiet) ui_done("License {ui_value(license)} is already used")
      return(invisible(NULL))
    }
  }
  
  
  ## Replace field in DESCRIPTION ----
  
  descr <- read_descr()
  descr$"License" <- ifelse(license == "MIT", "MIT + file LICENSE", license)
  write_descr(descr)
  
  if (!quiet) 
    ui_done(paste0("Setting {ui_field('License')} field in DESCRIPTION to ",
                   "{ui_value(license)}"))
  
  
  ## Copy LICENSE file (MIT) ----
  
  if (license == "MIT") {
    
    invisible(
      file.copy(system.file(file.path("licenses", "copyright-mit"), 
                            package = "rcompendium"),
                here::here("LICENSE"), overwrite = TRUE))
    
    if (!quiet) ui_done("Writing {ui_value('LICENSE')} file")
    
  } else {
    
    if (file.exists(here::here("LICENSE"))) {
      invisible(file.remove(here::here("LICENSE")))
    }
  }
  
  
  ## Copy LICENSE.md ----
  
  license_file <- paste("license", licenses[license_id, "file"], sep = "-")
  
  invisible(
    file.copy(system.file(file.path("licenses", license_file), 
                          package = "rcompendium"),
              here::here("LICENSE.md"), overwrite = TRUE))
  
  if (!quiet) ui_done("Writing {ui_value('LICENSE.md')} file")
  
  add_to_buildignore("LICENSE.md", quiet = quiet)
  
  
  ## Replace field (MIT) in LICENSES docs ----
  
  if (license == "MIT") {
    
    xfun::gsub_file(here::here("LICENSE.md"), "{{given}}", given, 
                    fixed = TRUE)
    xfun::gsub_file(here::here("LICENSE.md"), "{{family}}", family, 
                    fixed = TRUE)
    xfun::gsub_file(here::here("LICENSE.md"), "{{year}}", year, 
                    fixed = TRUE)
    
    xfun::gsub_file(here::here("LICENSE"), "{{given}}", given, 
                    fixed = TRUE)
    xfun::gsub_file(here::here("LICENSE"), "{{family}}", family, 
                    fixed = TRUE)
    xfun::gsub_file(here::here("LICENSE"), "{{year}}", year, 
                    fixed = TRUE)
  }
  
  invisible(NULL)
}