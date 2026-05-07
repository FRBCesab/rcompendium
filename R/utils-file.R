#' Open a file if required
#' @param path a character of length of 1. The absolute path of the file.
#' @param open a logical of length 1.
#' @noRd
open_file_if_needed <- function(path, open) {
  if (open) {
    utils::file.edit(path)
  }

  invisible(NULL)
}


#' Search and replace strings in files
#' @param file a character of length 1. The path of a single file.
#' @param pattern a character of length 1. The pattern to replace.
#' @param replacement a character of length 1. The replacement of the pattern.
#' @noRd
gsub_in_file <- function(file, pattern, replacement) {
  stop_if_not_string(file)
  stop_if_not_string(pattern)
  stop_if_not_string(replacement)

  if (!file.exists(file)) {
    stop("The file '", file, "' does not exist", call. = FALSE)
  }

  if (file.access(file, 4) != 0) {
    stop("Cannot read the '", file, "' file", call. = FALSE)
  }

  if (file.access(file, 2) != 0) {
    stop("Cannot write the '", file, "' file", call. = FALSE)
  }

  opts <- options(encoding = "native.enc")
  on.exit(options(opts), add = TRUE)

  x <- tryCatch(
    readLines(file, encoding = "UTF-8", warn = FALSE),
    error = function(e) {
      stop("Cannot read the '", file, "' file", call. = FALSE)
    }
  )

  if (length(x) == 0) {
    return(invisible(NULL))
  }

  text <- paste0(x, collapse = "\n")
  text_new <- gsub(pattern, replacement, text, fixed = TRUE)

  if (!identical(text, text_new)) {
    writeLines(enc2utf8(text_new), file, useBytes = TRUE)
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
