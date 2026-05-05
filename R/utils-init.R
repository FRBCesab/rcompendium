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
}


#' Git Inception
#' @noRd
stop_if_git_in_git <- function() {
  paths <- unlist(strsplit(build_abs_path(), .Platform$file.sep))

  for (i in 1:(length(paths) - 1)) {
    recursive_path <- paste0(
      c(paths[1:i], ".git"),
      collapse = .Platform$file.sep
    )

    if (dir.exists(recursive_path)) {
      stop(
        "You are going to create a '.git' inside a folder that is ",
        "already versioned.\n  < ",
        recursive_path,
        " >"
      )
    }
  }

  invisible(NULL)
}


#' Rproj Inception
#' @noRd
stop_if_proj_in_proj <- function() {
  paths <- unlist(strsplit(build_abs_path(), .Platform$file.sep))

  for (i in 1:(length(paths) - 1)) {
    recursive_path <- paste0(paths[1:i], collapse = .Platform$file.sep)
    recursive_path <- paste0(recursive_path, .Platform$file.sep)

    if (length(list.files(recursive_path, pattern = "\\.Rproj$"))) {
      stop(
        "You have created an 'RStudio Project' inside a folder that ",
        "is already an 'RStudio Project'."
      )
    }
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
