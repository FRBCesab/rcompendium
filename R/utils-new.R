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

  list(
    given = given,
    family = family,
    email = email,
    orcid = orcid,

    project_name = get_package_name(),
    project_version = get_package_version(),
    license = get_project_license_name(),
    license_url = get_project_license_url(),

    github_user = get_github_user(),
    github_account = resolve_github_account(args$organisation),
    git_branch = get_git_branch_name(),

    r_version = paste(
      utils::sessionInfo()$"R.version"$"major",
      utils::sessionInfo()$"R.version"$"minor",
      sep = "."
    ),
    roxygen2_version = get_roxygen2_version(),
    renv_version = utils::packageVersion("renv"),

    year = format(Sys.Date(), "%Y"),
    date = format(Sys.time(), "%Y/%m/%d")
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


#' Download a file template and replace default values
#' @param slug a character of length of 1. The URL slug of the file template.
#' @param path a character of length of 1. The absolute path of the file.
#' @param meta a list of the project metadata.
#' @noRd
create_template <- function(slug, path, meta) {
  download_template(
    slug = slug,
    filename = basename(path),
    outdir = dirname(path)
  )

  populate_template(build_full_path(path), meta)

  invisible(NULL)
}


#' Replace default values in templates
#' @param path a character of length of 1. The absolute path of the file.
#' @param meta a list of the project metadata.
#' @noRd
populate_template <- function(path, meta) {
  for (name in names(meta)) {
    value <- meta[[name]]

    if (!is.null(value)) {
      placeholder <- paste0("{{", name, "}}")

      xfun::gsub_file(
        path,
        pattern = placeholder,
        replacement = as.character(value),
        fixed = TRUE
      )
    }
  }

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


#' Error if the current working directory is not a project/package
#' @noRd
stop_if_not_project <- function() {
  markers <- c(
    "DESCRIPTION",
    ".git",
    ".Rproj",
    ".here",
    "renv.lock",
    ".vscode/settings.json"
  )

  if (all(!file.exists(markers))) {
    stop(paste0(
      "The path '",
      getwd(),
      "' does not appear to be inside a project or package."
    ))
  }

  invisible(NULL)
}


#' Error if the license name if not available
#' @param license a character of length of 1. The name of the license.
#' @noRd
assert_valid_license_name <- function(license) {
  stop_if_null_or_empty(license)
  stop_if_not_string(license)

  license_id <- which(licenses$tag == license)

  if (length(license_id) == 0) {
    stop(
      "Invalid license. Please use `get_licenses()` to select an ",
      "appropriate one."
    )
  }

  invisible(NULL)
}


#' Error if given & family are not provided (MIT only)
#' @param license a character of length of 1. The name of the license.
#' @param meta a list of the project metadata.
#' @noRd
assert_valid_mit_meta <- function(license, meta) {
  if (license == "MIT") {
    if (is.null(meta$given)) {
      stop(
        "Given name of the coypright holder is mandatory with the ",
        "license MIT. Please use the argument `given` or the function ",
        "`set_credentials()`.",
        call. = FALSE
      )
    }

    if (is.null(meta$family)) {
      stop(
        "Family name of the coypright holder is mandatory with the ",
        "license MIT. Please use the argument `family` or the function ",
        "`set_credentials()`.",
        call. = FALSE
      )
    }

    stop_if_not_string(meta$given)
    stop_if_not_string(meta$family)
  }

  invisible(NULL)
}


#' Return TRUE if the license should be added/updated
#' @param license a character of length of 1. The name of the license.
#' @noRd
should_update_license <- function(license) {
  descr_license <- get_project_license_name()

  if (!is.null(descr_license)) {
    if (descr_license == license) {
      return(FALSE)
    } else {
      return(TRUE)
    }
  }
}


#' Update the License field in the DESCRIPTION file
#' @param license a character of length of 1. The name of the license.
#' @noRd
update_license_field_in_desc <- function(license, quiet = FALSE) {
  descr <- read_descr()
  descr$"License" <- ifelse(license == "MIT", "MIT + file LICENSE", license)
  write_descr(descr)

  if (!quiet) {
    cli::cli_alert_success(
      "Setting {.field License} field in DESCRIPTION to {.val {license}}"
    )
  }

  invisible(NULL)
}


#' Update the License field in the DESCRIPTION file
#' @param license a character of length of 1. The name of the license.
#' @param meta a list of the project metadata.
#' @noRd
create_mit_copyright_holder_file <- function(license, meta, quiet = FALSE) {
  full_path <- build_full_path("LICENSE")

  if (license == "MIT") {
    content <- c(
      paste("YEAR:", meta$year),
      paste("COPYRIGHT HOLDER:", meta$given, meta$family)
    )

    writeLines(text = content, con = full_path)

    ui_file_written("LICENSE", quiet = quiet)
  } else {
    if (file.exists(full_path)) {
      invisible(
        file.remove(full_path)
      )
    }
  }

  invisible(NULL)
}


#' Retrive license information (file name, url, etc.)
#' @param license a character of length of 1. The name of the license.
#' @noRd
get_license_meta <- function(license) {
  license_id <- which(licenses$tag == license)
  as.list(licenses[license_id, ])
}


#' Error if the GH Action name if not available
#' @param name a character of length of 1. The name of the GH Action.
#' @noRd
assert_valid_gh_action_name <- function(name) {
  available_actions <- get_available_gh_actions()

  if (!(name %in% available_actions)) {
    stop(
      paste0(
        "The action '",
        name,
        "' is not available. Please run ",
        "`get_available_gh_actions()` to list available GitHub Actions."
      )
    )
  }

  invisible(NULL)
}


#' Error if the project is not package or compendium
#' @param type a character of length of 1. The type of the project.
#' @noRd
assert_valid_project_type <- function(type) {
  stop_if_null_or_empty(type)
  stop_if_not_string(type)

  if (!(type %in% c("package", "compendium"))) {
    stop("Argument 'type' must be 'package' or 'compendium'.", call. = FALSE)
  }

  invisible(NULL)
}


#' Retrieve the name of the license used in the project
#' @noRd
get_project_license_name <- function() {
  descr_file <- read_descr()
  gsub(" \\+ file LICENSE", "", descr_file$License)
}


#' Retrieve the URL of the license used in the project
#' @noRd
get_project_license_url <- function() {
  license <- get_project_license_name()
  get_license_meta(license)$url
}


#' Error if the Issue Template name if not available
#' @param name a character of length of 1. The name of the Issue Template.
#' @noRd
assert_valid_issue_template_name <- function(name) {
  available_issues <- get_available_issue_templates()

  if (!(name %in% available_issues)) {
    stop(
      paste0(
        "The issue template '",
        name,
        "' is not available. Please run ",
        "`get_available_issue_templates()` to list available Issue Templates."
      )
    )
  }

  invisible(NULL)
}
