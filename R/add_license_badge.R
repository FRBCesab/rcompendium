#' Add a License badge
#'
#' @description 
#' This function adds or updates the **License** badge to the `README.Rmd`.
#' This function reads the `License` field of the `DESCRIPTION` file. Ensure 
#' that this field is correctly defined. See [add_license()] for further detail.
#' 
#' This function requires the presence of a `DESCRIPTION` file at the project 
#' root. See [add_description()] for further detail.
#' 
#' Make sure that 1) a `README.Rmd` file exists at the project root and 2) it
#' contains a block starting with the line `<!-- badges: start -->` and ending 
#' with the line `<!-- badges: end -->`.
#' 
#' Don't forget to re-render the `README.md`.
#' 
#' @param quiet A logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#' 
#' @return A badge as a markdown expression.
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
  
  
  ## Checks ----
  
  stop_if_not_logical(quiet)
  
  user_license <- read_descr()$"License"
  user_license <- gsub(" \\+ file LICENSE", "", user_license)
  
  
  if (!is.null(user_license)) {
    
    if (user_license %in% licenses$"tag") {
      
      
      ## Create Badge Markdown Expression ----
      
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
