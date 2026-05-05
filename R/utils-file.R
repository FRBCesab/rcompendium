#' Open a file in editor
#' @noRd
edit_file <- function(path) {
  if (rstudioapi::isAvailable() && rstudioapi::hasFun("navigateToFile")) {
    rstudioapi::navigateToFile(path)
  } else {
    utils::file.edit(path)
  }

  invisible(NULL)
}


#' Open a file if required
#' @param path a character of length of 1. The absolute path of the file.
#' @param open a logical of length 1.
#' @noRd
open_file_if_needed <- function(path, open) {
  if (open) {
    edit_file(path)
  }

  invisible(NULL)
}


#' Search and replace strings in files
#'
#' File version of [gsub()]. Modified from [xfun::gsub_file()] allowing to
#' search for strings in multiple lines.
#' @param file Path of a single file.
#' @param ... Arguments passed to [gsub()].
#' @noRd
gsub_in_file <- function(file, ...) {
  if (!(file.access(file, 2) == 0 && file.access(file, 4) == 0)) {
    stop("Unable to read or write to ", file)
  }

  x1 <- tryCatch(xfun::read_utf8(file, error = TRUE), error = function(e) {
    stop(e)
  })

  if (is.null(x1)) {
    return(invisible(NULL))
  }

  x1 <- paste0(x1, collapse = "\n")
  x2 <- gsub(x = x1, ...)

  if (!identical(x1, x2)) {
    xfun::write_utf8(x2, file)
  }

  invisible(NULL)
}


#' Create a directory if required
#' @param path a character of length of 1. The absolute path of the directory.
#' @noRd
create_folder_if_needed <- function(path) {
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }

  invisible(NULL)
}


#' Return TRUE if a file does not exist or if overwrite is TRUE
#' @param path a character of length of 1. The absolute path of the file.
#' @param overwrite a logical of length 1.
#' @noRd
should_create_file <- function(path, overwrite) {
  !file.exists(path) || overwrite
}
