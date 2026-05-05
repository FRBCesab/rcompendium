#' Retrieve and assert project metadata
#' @param ... any metadata options (given, email, etc.) or empty
#' @noRd
resolve_project_meta <- function(...) {
  args <- list(...)

  given <- args$given %||% getOption("given")
  family <- args$family %||% getOption("family")
  email <- args$email %||% getOption("email")
  orcid <- args$orcid %||% getOption("orcid")
  github_user <- args$github_user %||% getOption("github_user")
  github_account <- args$organisation %||% github_user

  list(
    given = given,
    family = family,
    email = email,
    orcid = orcid,

    project_name = get_project_name(),
    project_version = get_project_version(),
    license = get_project_license_name(),
    license_url = get_project_license_url(),

    github_user = github_user,
    github_account = github_account,
    git_branch = get_git_branch_name(),

    r_version = get_r_version(),
    roxygen2_version = get_roxygen2_version(),
    renv_version = utils::packageVersion("renv"),

    year = format(Sys.Date(), "%Y"),
    date = format(Sys.time(), "%Y/%m/%d")
  )
}


#' Assert user information
#' @param meta a list of the user information.
#' @noRd
stop_if_invalid_credentials <- function(meta) {
  if (!is.null(meta)) {
    if ("given" %in% names(meta)) {
      stop_if_not_string(meta$given)
    }

    if ("family" %in% names(meta)) {
      stop_if_not_string(meta$family)
    }

    if ("email" %in% names(meta)) {
      stop_if_not_string(meta$email)
    }

    if ("orcid" %in% names(meta)) {
      stop_if_not_string(meta$orcid)
    }

    if ("github_user" %in% names(meta)) {
      stop_if_not_string(meta$github_user)
    }

    if (!is.null(meta[["protocol"]])) {
      if ("protocol" %in% names(meta)) {
        stop_if_not_string(meta$protocol)
      }
    }
  }

  invisible(NULL)
}


#' Error if the project is not package or compendium
#' @param type a character of length of 1. The type of the project.
#' @noRd
stop_if_invalid_project_type <- function(type) {
  stop_if_not_string(type)

  if (!(type %in% c("package", "compendium"))) {
    stop("Argument 'type' must be 'package' or 'compendium'.", call. = FALSE)
  }

  invisible(NULL)
}


#' Get the project name
#' @noRd
get_project_name <- function() {
  dirname(build_abs_path())
}


#' Get the project version
#' @noRd
get_project_version <- function() {
  if (file.exists(build_abs_path("DESCRIPTION"))) {
    return(read_descr()$"Version")
  } else {
    return(NULL)
  }
}


#' Get roxygen2 version
#' @noRd
get_roxygen2_version <- function() {
  if (!length(find.package("roxygen2", quiet = TRUE))) {
    stop("The package 'roxygen2' is required.", call. = FALSE)
  }

  as.character(utils::packageVersion("roxygen2"))
}


#' Get installed R version
#' @noRd
get_r_version <- function() {
  r_version <- paste(
    utils::sessionInfo()["R.version"][[1]]["major"],
    utils::sessionInfo()["R.version"][[1]]["minor"],
    sep = "."
  )

  r_version <- unlist(strsplit(r_version, "\\."))
  r_version <- paste(r_version[1], r_version[2], sep = ".")
  r_version
}
