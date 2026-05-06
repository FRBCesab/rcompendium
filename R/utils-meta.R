#' Retrieve project metadata
#' @param ... any metadata options (given, email, etc.) or empty
#' @param include a vector of valid blocks
#' @noRd
resolve_project_meta <- function(..., include = .DEFAULT_BLOCKS) {
  valid_blocks <- .DEFAULT_BLOCKS

  if (any(is.na(include))) {
    stop(
      "Argument 'include' cannot contain NA values.",
      call. = FALSE
    )
  }

  if (any(!(include %in% valid_blocks))) {
    stop(
      sprintf(
        "Invalid 'include' value(s): '%s'. Valid values are '%s'.",
        paste(setdiff(include, valid_blocks), collapse = "', '"),
        paste(valid_blocks, collapse = "', '")
      ),
      call. = FALSE
    )
  }

  add_block <- function(cond, fn) if (cond) fn() else list()

  meta <- c(
    add_block("user" %in% include, function() collect_user_meta(...)),
    add_block("project" %in% include, collect_project_meta),
    add_block("git" %in% include, collect_git_meta),
    add_block("runtime" %in% include, collect_runtime_meta)
  )

  meta
}


#' Collect user metadata
#' @param ... any metadata options (given, email, etc.) or empty
#' @noRd
collect_user_meta <- function(...) {
  args <- list(...)

  get_or_option <- function(name) args[[name]] %||% getOption(name)

  list(
    given = get_or_option("given"),
    family = get_or_option("family"),
    email = get_or_option("email"),
    orcid = get_or_option("orcid"),
    github_user = get_or_option("github_user"),
    github_account = args[["organisation"]] %||% get_or_option("github_user")
  )
}


#' Collect project metadata
#' @noRd
collect_project_meta <- function() {
  list(
    project_name = get_project_name(),
    project_version = get_project_version(),
    license = get_project_license_name(),
    license_url = get_project_license_url()
  )
}


#' Collect git metadata
#' @noRd
collect_git_meta <- function() {
  branch <- get_git_branch_name()
  list(
    git_branch = branch,
    git_available = !is.null(branch)
  )
}


#' Collect runtime metadata
#' @noRd
collect_runtime_meta <- function() {
  list(
    r_version = get_r_version(),
    roxygen2_version = get_roxygen2_version(),
    renv_version = get_renv_version(),
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

  valid_types <- c("package", "compendium")

  if (!(type %in% valid_types)) {
    stop(
      sprintf(
        "Argument 'type' must be one of '%s'.",
        paste(valid_types, collapse = "', '")
      ),
      call. = FALSE
    )
  }

  invisible(NULL)
}


#' Get the project name
#' @noRd
get_project_name <- function() {
  basename(build_abs_path())
}


#' Get the project version
#' @noRd
get_project_version <- function() {
  path <- build_abs_path("DESCRIPTION")

  if (!file.exists(path)) {
    return(NULL)
  }

  desc <- read_descr()

  desc[["Version"]] %||% NULL
}


#' Get roxygen2 version
#' @noRd
get_roxygen2_version <- function() {
  if (!requireNamespace("roxygen2", quietly = TRUE)) {
    stop("The package 'roxygen2' is required.", call. = FALSE)
  }

  as.character(utils::packageVersion("roxygen2"))
}


#' Get renv version
#' @noRd
get_renv_version <- function() {
  if (!requireNamespace("renv", quietly = TRUE)) {
    return(NULL)
  }

  as.character(utils::packageVersion("renv"))
}


#' Get installed R version
#' @noRd
get_r_version <- function() {
  paste0(
    R.version[["major"]],
    ".",
    strsplit(R.version[["minor"]], ".", fixed = TRUE)[[1]][1]
  )
}
