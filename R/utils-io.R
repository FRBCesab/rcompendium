## Utilities functions - Handle files ----



#' **Open a file in editor**
#' 
#' @noRd

edit_file <- function(path) {
  
  
  if (rstudioapi::isAvailable() && rstudioapi::hasFun("navigateToFile")) {
    
    rstudioapi::navigateToFile(path)
    
  } else {
    
    utils::file.edit(path)  
  }
  
  invisible(NULL)
}



#' **Import DESCRIPTION content**
#' 
#' @noRd

read_descr <- function() { 
  
  
  is_package()
  
  path <- path_proj()
  
  col_names <- colnames(read.dcf(file.path(path, "DESCRIPTION")))
  
  descr <- read.dcf(file.path(path, "DESCRIPTION"), keep.white = col_names)
  
  if (nrow(descr) != 1) stop("Malformed 'DESCRIPTION' file")
  
  as.data.frame(descr, stringsAsFactors = FALSE)
}



#' **Write DESCRIPTION (erase content)**
#' 
#' @noRd

write_descr <- function(descr_file) { 
  
  
  is_package()
  
  path <- path_proj()
  
  write.dcf(descr_file, file = file.path(path, "DESCRIPTION"), indent = 4, 
            width = 80, keep.white = colnames(descr_file))
  
  invisible(NULL)
}



#' **Add a badge to the README.Rmd**
#' 
#' @param badge a Markdown expression.
#' @param pattern a special tag (i.e. 'LifeCycle', 'Project Status', 
#'   'CRAN status', 'License', 'R-CMD-check')
#' 
#' @noRd

add_badge <- function(badge, pattern) {
  
  
  path <- path_proj()
  
  ## Checks ----
  
  if (missing(badge))   stop("No badge to add in the 'README.Rmd'.")  
  if (missing(pattern)) stop("Argument 'pattern' is missing.")  
  
  if (!file.exists(file.path(path, "README.Rmd"))) {
    stop("The file 'README.Rmd' cannot be found.")
  }
  
  
  ## Read README.Rmd ----
  
  read_me <- readLines(con = file.path(path, "README.Rmd"))
  
  
  ## Check if Badges Locations are present ----
  
  badge_start <- grep("<!-- badges: start -->", read_me)
  badge_end   <- grep("<!-- badges: end -->", read_me)
  
  if (!length(badge_start) || !length(badge_start)) {
    stop("Unable to parse badges location in 'README.Rmd' file.\n",
         "Did you remove the tag '<!-- badges: start -->' and/or ",
         "'<!-- badges: end -->'?")
  }
  
  
  ## Extract existing badges (if exist) ----
  
  if ((badge_start + 1) == badge_end) {
    
    badges <- character(0)
    
  } else {
    
    badges <- paste0(read_me[(badge_start + 1):(badge_end - 1)], 
                     collapse = "\n")
    badges <- unlist(strsplit(badges, "\n"))
    badges <- badges[!(badges == "")]
  }
  
  
  ## Replace/Add badge ----
  
  pos <- grep(paste0("^\\s{0,}\\[!\\[", pattern), badges)
  
  if (length(pos)) badges[pos] <- badge else badges <- c(badges, badge)
  
  read_me <- c(read_me[1:badge_start], 
               badges, 
               read_me[badge_end:length(read_me)])
  
  
  ## Replace README.Rmd ----
  
  writeLines(read_me, con = file.path(path, "README.Rmd"))
  
  invisible(NULL)
}



#' **Add Template sticker**
#' 
#' @param overwrite a logical value. If a file is already present and 
#'   `overwrite = TRUE`, it will be erased and replaced.
#'   
#' @param quiet a logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#'   
#' @noRd

add_sticker <- function(overwrite = FALSE, quiet = FALSE) {
  
  
  stop_if_not_logical(overwrite, quiet)
  
  path <- file.path(path_proj(), "man", "figures", "hexsticker.png")
  
  if (file.exists(path) && !overwrite) {
    
    stop("A 'man/figures/hexsticker.png' is already present. If you want to ",
         "replace it, please use `overwrite = TRUE`.")
  }
  
  
  if (!dir.exists(file.path(path_proj(), "man", "figures")))
    dir.create(file.path(path_proj(), "man", "figures"), showWarnings = FALSE, 
               recursive = TRUE)
    
  invisible(
    file.copy(system.file(file.path("templates", "hexsticker.png"), 
                          package = "rcompendium"), path, overwrite = TRUE))
  
  
  if (!quiet) {
    ui_done("Adding {ui_value('hexsticker.png')} to {ui_value('README.Rmd')}")
  }
  
  invisible(NULL)
}
