#' @noRd
add_package_doc <- function() { 
  
  dir.create(here::here("R"), showWarnings = FALSE)
  
  filename <- paste0(get_project_name(), "-package.R")
  
  invisible(
    file.copy(system.file(file.path("templates", "INDEX"), 
                          package = "rcompendium"),
              here::here("R", filename)))
  
  ui_done("Writing {ui_value(paste0('R/', filename))} file")
  
  invisible(NULL)
}



#' @noRd
get_project_name <- function() {
  
  if (!("here" %in% utils::installed.packages())) {
    stop("The package `here` cannot be found.")
  }
  
  exploded_path <- unlist(strsplit(here::here(), .Platform$"file.sep"))
  exploded_path[length(exploded_path)]    
}



#' @noRd
get_roxygen2_version <- function() {
  
  if (!("roxygen2" %in% utils::installed.packages())) {
    stop("The package `roxygen2` cannot be found.")
  }
  
  as.character(utils::packageVersion("roxygen2"))
}



#' @noRd
get_r_version <- function() {
  
  r_version <- paste(utils::sessionInfo()["R.version"][[1]]["major"], 
                     utils::sessionInfo()["R.version"][[1]]["minor"], 
                     sep = ".")
  r_version <- unlist(strsplit(r_version, "\\."))
  r_version <- paste(r_version[1], r_version[2], sep = ".")
  
  paste0("R (>= ", r_version, ")")
}




#' @noRd
get_pkg_version <- function() { 
  
  descr <- read.dcf(here::here("DESCRIPTION"))
  
  if (nrow(descr) != 1) stop("Malformed 'DESCRIPTION' file")
  
  unname(descr[1, "Version"])
}



#' **Function to Add a Badge to the README.Rmd**
#' 
#' @param badge a Markdown expression.
#' @param pattern a special tag (i.e. 'LifeCycle', 'Project Status', 
#'   'CRAN status', 'License', 'R-CMD-check')
#' 
#' @noRd

add_badge <- function(badge, pattern) {
  
  
  ## Checks ----
  
  if (missing(badge)) {
    stop("No badge to add in the **README.Rmd**.")  
  }
  
  if (missing(pattern)) {
    stop("Argument `pattern` is missing.")  
  }
  
  if (!file.exists(here::here("README.Rmd"))) {
    stop("The file **README.Rmd** cannot be found.")
  }
  
  
  ## Read README.Rmd ----
  
  read_me <- readLines(con = here::here("README.Rmd"))
  
  
  ## Check if Badges Locations are present ----
  
  badge_start <- grep("<!-- badges: start -->", read_me)
  badge_end   <- grep("<!-- badges: end -->", read_me)
  
  if (!length(badge_start) || !length(badge_start)) {
    stop("Unable to parse **README.Rmd** file.")
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
  
  writeLines(read_me, con = here::here("README.Rmd"))
  invisible(NULL)
}



#' @noRd

get_package_name <- function(path = ".") {
  
  is_package(path)
  
  package_name <- read.dcf(file.path(path, "DESCRIPTION"))
  
  pkg_name <- as.character(package_name[1, "Package"])
  
  if (!length(pkg_name)) stop("Malformed 'DESCRIPTION' file")
  
  return(pkg_name)
}

