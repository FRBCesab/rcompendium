#' Add a license badge
#'
#' @description 
#' This function adds or updates the license badge to the `README.Rmd`. This
#' function reads the `License` field of the `DESCRIPTION` file. Be sure to 
#' previously run [add_license()] function.
#' 
#' @param quiet a logical value
#' 
#'   If `TRUE` messages are deleted. Default is `FALSE`.
#' 
#' @return A Markdown badge expression
#'
#' @export
#' 
#' @family adding badges
#'
#' @examples
#' \dontrun{
#' add_license_badge()
#' }

add_license_badge <- function(quiet = FALSE) {
  
  
  stop_if_not_logical(quiet)
  
  user_license <- read_descr()$"License"
  user_license <- gsub(" \\+ file LICENSE", "", user_license)
  
  if (!is.null(user_license)) {
    
    if (user_license %in% licenses$"tag") {
      
      color <- licenses[which(licenses$tag == user_license), "color"]
      
      user_license_encoded <- gsub("-", " v", user_license)
      user_license_encoded <- gsub("\\s", "%20", user_license_encoded)
      user_license_encoded <- gsub("\\(", "%28", user_license_encoded)
      user_license_encoded <- gsub("\\)", "%29", user_license_encoded)
      user_license_encoded <- gsub(">", "%3E", user_license_encoded)
      user_license_encoded <- gsub("=", "%3D", user_license_encoded)
      
      alt  <- paste0("License: ", user_license)
      href <- licenses[which(licenses$tag == user_license), "url"]
      img  <- paste0("https://img.shields.io/badge/License-", 
                     user_license_encoded, "-", color, ".svg")
      
      badge <- paste0("[![", alt, "](", img, ")](", href, ")")
      
      
      ## Add Badge ----
      
      add_badge(badge, pattern = "License")
      
      if (!quiet) {
        ui_done(paste0("Adding {ui_field('License')} badge to ", 
                       "{ui_value('README.Rmd')}"))
      }
      
    } else {
      
      ui_oops("Unknow {ui_field('License')} type in {ui_value('DESCRIPTION')}")
      ui_todo("See {ui_code('?add_license()')} for further information")
    }
  
  } else {
    
    ui_oops("No {ui_field('License')} field in {ui_value('DESCRIPTION')}")
    ui_todo("See {ui_code('?add_license()')} for further information")
  }
  
  invisible(badge)
}
