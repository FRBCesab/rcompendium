#' Return TRUE if the user provide information
#' @param meta a list of the user information.
#' @noRd
should_edit_r_profile <- function(meta) {
  if (length(meta) > 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}


#' Create information message to edit the user .Rprofile
#' @param meta a list of the user information.
#' @noRd
create_r_profile_content <- function(meta) {
  r_prof <- "## rcompendium credentials ----"

  opts <- paste0("\n  ", names(meta), " = \"", unlist(meta), "\"")
  opts <- paste0(opts, collapse = ", ")

  c(r_prof, paste0("options(", opts, "\n)", ""))
}


#' Build the path to the user .Rprofile
#' @noRd
build_r_profile_path <- function() {
  custom_r_profile_path <- Sys.getenv("R_PROFILE_USER")
  if (custom_r_profile_path != "") {
    r_profile_path <- custom_r_profile_path
  } else {
    r_profile_path <- file.path(fs::path_home_r(), ".Rprofile")
  }

  r_profile_path
}


#' Create the user .Rprofile (if required) and return the path
#' @noRd
create_r_profile_if_needed <- function() {
  r_profile_path <- build_r_profile_path()
  if (!file.exists((r_profile_path))) {
    invisible(file.create(r_profile_path))
  }

  invisible(r_profile_path)
}
