#' Check if the project name is valid
#' Inspired from `usethis:::valid_package_name()` - Thanks guys!.
#' @noRd

stop_if_invalid_project_name <- function() {
  pkg <- get_project_name()

  if (!(grepl("^[a-zA-Z][a-zA-Z0-9.]+$", pkg) && !grepl("\\.$", pkg))) {
    stop(
      "The project name is invalid. ",
      "Only letters, numbers and the dot are allowed.",
      call. = FALSE
    )
  }

  invisible(NULL)
}


#' Split a path
#' @noRd
split_path <- function(path) {
  stop_if_not_string(path)

  path <- normalizePath(path, winslash = "/", mustWork = FALSE)
  parts <- character(0)

  while (nchar(path) > 0 && !identical(path, dirname(path))) {
    parts <- c(basename(path), parts)
    path <- dirname(path)
  }

  if (nchar(path) > 0) {
    parts <- c(path, parts)
  }

  parts
}


#' Git Inception & root creation forbidden
#' @noRd
stop_if_git_in_git <- function(path = build_abs_path()) {
  paths <- split_path(path)

  if (length(paths) == 1) {
    stop("Creating a '.git' at the system root is forbidden", call. = FALSE)
  }

  if (length(paths) > 0) {
    if (paths[1] == "/") paths[1] <- ""
  }

  paths <- vapply(
    seq_len(length(paths) - 1),
    function(i) {
      do.call(file.path, as.list(c(paths[1:i], ".git")))
    },
    character(1)
  )

  existing_git <- paths[dir.exists(paths)]
  if (length(existing_git) > 0) {
    stop(
      paste0(
        "You are going to create a '.git' inside a folder that is already ",
        "versioned.\n  < ",
        existing_git[1],
        " >"
      )
    )
  }

  invisible(NULL)
}


#' Initialize project (create .here if required)
#' @param quiet a logical of length 1.
#' @noRd
initialize_project <- function(quiet = FALSE) {
  ui_title("Initializing project", quiet)

  if (is.null(resolve_project_root())) {
    content <- list.files(getwd(), all.files = TRUE, no.. = TRUE)

    if (length(content) == 0) {
      invisible(file.create(".here"))
      ui_file_written(".here", quiet)
    } else {
      stop(
        paste0(
          "The path '",
          getwd(),
          "' is not empty and does not appear to be an R project."
        )
      )
    }
  }

  ui_project_initialized(getwd(), quiet)
  invisible(NULL)
}
