#' Detect common files of a project root
#' @noRd
detect_project_files <- function() {
  criteria <-
    rprojroot::has_file(".here") |
    rprojroot::is_r_package |
    rprojroot::is_rstudio_project |
    rprojroot::is_vscode_project |
    rprojroot::is_remake_project |
    rprojroot::is_drake_project |
    rprojroot::is_targets_project |
    rprojroot::is_pkgdown_project |
    rprojroot::is_renv_project |
    rprojroot::is_projectile_project |
    rprojroot::is_quarto_project |
    rprojroot::is_git_root |
    rprojroot::is_svn_root |
    rprojroot::is_vcs_root |
    rprojroot::is_testthat

  criteria
}


#' Try to find the project root
#' @noRd
resolve_project_root <- function() {
  tryCatch(
    rprojroot::find_root(detect_project_files(), normalizePath(".")),
    error = function(e) NULL
  )
}


#' Check if the project root can be found
#' @noRd
stop_if_not_project <- function() {
  if (is.null(resolve_project_root())) {
    stop(
      "Cannot determine project root. ",
      "Make sure you are inside an R project or a directory containing ",
      "a '.here' file.",
      call. = FALSE
    )
  }

  invisible(NULL)
}


#' Build an absolute path by adding the project root
#' @param ... one or several folder/file names
#' @noRd
build_abs_path <- function(...) {
  if (!is.null(resolve_project_root())) {
    file.path(resolve_project_root(), ...)
  } else {
    stop(
      "Cannot determine project root. ",
      "Make sure you are inside an R project or a directory containing ",
      "a '.here' file.",
      call. = FALSE
    )
  }
}


#' Extract a relative path from an absolute path
#' @param path an absolute path
#' @noRd
extract_rel_path <- function(path) {
  path <- gsub(resolve_project_root(), "", path)
  path <- gsub(paste0("^", .Platform$file.sep), "", path)
  path
}
