#' Get project full path
#' @noRd
get_proj_path <- function() usethis::proj_get()


#' Build an absolute path
#' @param ... one or several folder/file names
#' @noRd
build_full_path <- function(...) {
  file.path(get_proj_path(), ...)
}


#' Build a path relative to the project root
#' @param ... one or several folder/file names
#' @noRd
build_rel_path <- function(...) {
  file.path(...)
}


#' Error if a file exists and if overwrite is FALSE
#' @param path a character of length of 1. The relative path of the file
#' @param overwrite a logical of length 1.
#' @noRd
assert_file_not_exists_or_overwrite <- function(path, overwrite) {
  if (file.exists(build_full_path(path)) && !overwrite) {
    stop(
      paste0(
        "The file '",
        path,
        "' already exists. ",
        "To replace it, please use `overwrite = TRUE`."
      ),
      call. = FALSE
    )
  }

  invisible(NULL)
}


#' Retrieve and assert project metadata
#' @param ... any metadata options (given, email, etc.) or empty
#' @noRd
resolve_project_meta <- function(...) {
  args <- list(...)

  given <- args$given %||% getOption("given")
  family <- args$family %||% getOption("family")
  email <- args$email %||% getOption("email")
  orcid <- args$orcid %||% getOption("orcid")

  stop_if_null_or_empty(given, "given")
  stop_if_null_or_empty(family, "family")

  list(
    given = given,
    family = family,
    email = email,
    orcid = orcid,
    github_user = get_github_user(),
    github_account = resolve_github_account(args$organisation),
    package_name = get_package_name(),
    year = format(Sys.Date(), "%Y")
  )
}


#' Retrieve GitHub account of the repo
#' @param organisation a character of length 1 (optional). The name of the GH
#'   organisation. If `NULL` (default), the user account is used.
#' @noRd
resolve_github_account <- function(organisation = NULL) {
  if (!is.null(organisation)) {
    stop_if_not_string(organisation)
    return(organisation)
  }

  get_github_user()
}


#' Retrieve GitHub account name
#' @noRd
get_github_user <- function() {
  github <- gh::gh_whoami()$"login"

  if (is.null(github)) {
    stop(
      "Unable to find GitHub username. Please run ",
      "`?gh::gh_whoami` for more information."
    )
  }

  github
}


#' Return TRUE if a file does not exist or if overwrite is TRUE
#' @param path a character of length of 1. The absolute path of the file.
#' @param overwrite a logical of length 1.
#' @noRd
should_create_file <- function(path, overwrite) {
  !file.exists(path) || overwrite
}


#' Create a directory if required
#' @param path a character of length of 1. The absolute path of the directory.
#' @noRd
ensure_dir_exists <- function(path) {
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }

  invisible(NULL)
}


#' Download the CITATION file and replace default values
#' @param path a character of length of 1. The absolute path of the file.
#' @param meta a list of the project metadata.
#' @noRd
create_citation_template <- function(path, meta) {
  download_template(
    slug = "package/CITATION",
    filename = basename(path),
    outdir = dirname(path)
  )

  populate_citation_template(build_full_path(path), meta)

  invisible(NULL)
}


#' Replace default values in the CITATION file
#' @param path a character of length of 1. The absolute path of the file.
#' @param meta a list of the project metadata.
#' @noRd
populate_citation_template <- function(path, meta) {
  xfun::gsub_file(path, "{{project_name}}", meta$package_name, fixed = TRUE)
  xfun::gsub_file(path, "{{given}}", meta$given, fixed = TRUE)
  xfun::gsub_file(path, "{{family}}", meta$family, fixed = TRUE)
  xfun::gsub_file(path, "{{github}}", meta$github_account, fixed = TRUE)
  xfun::gsub_file(path, "{{year}}", meta$year, fixed = TRUE)

  invisible(NULL)
}


#' Inform user that a file has been written
#' @param path a character of length of 1. The absolute path of the file.
#' @param quiet a logical of length 1.
#' @noRd
ui_file_written <- function(path, quiet = FALSE) {
  if (!quiet) {
    cli::cli_alert_success("Writing {.file {path}} file")
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


#' Helper: if x is NULL then y
#' @noRd
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}


#' Error if an argument is NULL or empty
#' @noRd
stop_if_null_or_empty <- function(value, name) {
  if (is.null(value) || identical(value, "") || length(value) == 0) {
    stop(
      paste0(
        "Argument '",
        name,
        "' is required but is NULL or empty."
      )
    )
  }

  invisible(NULL)
}
