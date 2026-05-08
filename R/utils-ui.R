#' Display information message to edit the user .Rprofile
#' @param content a character of length 1.
#' @noRd
ui_r_profile_content <- function(content) {
  cli::cli_alert_warning(
    paste0(
      "Please copy and paste the following lines to the ",
      "{.file {build_r_profile_path()}}:"
    )
  )

  cat("\n")
  cli::cli_code(format(content))

  invisible(NULL)
}


#' Inform user that a file has been written
#' @param path a character of length of 1. The absolute path of the file.
#' @param quiet a logical of length 1.
#' @noRd
ui_file_written <- function(path, quiet = FALSE) {
  if (!quiet) {
    path <- extract_rel_path(path)
    cli::cli_alert_success("Writing {.file {path}} file")
  }

  invisible(NULL)
}


#' Inform user that a file has been written
#' @param path a character of length of 1. The absolute path of the file.
#' @param quiet a logical of length 1.
#' @noRd
ui_file_not_written <- function(path, quiet = FALSE) {
  if (!quiet) {
    cli::cli_alert_danger("The {.file {path}} file already exists")
  }

  invisible(NULL)
}


#' Inform user that the project has been initiliazed
#' @param path a character of length of 1. The absolute path of the project.
#' @param quiet a logical of length 1.
#' @noRd
ui_project_initialized <- function(path, quiet = FALSE) {
  if (!quiet) {
    cli::cli_alert_success("Setting active project to {.val {path}}")
  }

  invisible(NULL)
}


#' Custom ui_*() message
#' @noRd
ui_title <- function(texte, quiet = FALSE) {
  if (!quiet) {
    cli::cat_line()
    cat(cli::symbol$radio_on, cli::style_bold(cli::style_underline(texte)))
    cli::cat_line()
    cli::cat_line()
  }

  invisible(NULL)
}

ui_success <- function(texte, quiet = FALSE) {
  if (!quiet) {
    cli::cli_alert_success(texte)
  }

  invisible(NULL)
}
