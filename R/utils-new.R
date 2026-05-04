#' Error if a file exists and if overwrite is FALSE
#' @param path a character of length of 1. The relative path of the file
#' @param overwrite a logical of length 1.
#' @noRd
assert_file_not_exists_or_overwrite <- function(path, overwrite) {
  if (file.exists(path) && !overwrite) {
    stop(
      paste0(
        "The file '",
        extract_rel_path(path),
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
  download_template(slug, path)
  populate_template(path, meta)

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


#' Error if the license name if not available
#' @param license a character of length of 1. The name of the license.
#' @noRd
assert_valid_license_name <- function(license) {
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
    if (is.null(given)) {
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
  full_path <- build_abs_path("LICENSE")

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


#' Assert git protocol
#' @param meta a list of the user information.
#' @noRd
assert_valid_git_protocol <- function(meta) {
  if (!is.null(meta$protocol)) {
    if (!(meta$protocol %in% c("https", "ssh"))) {
      stop(
        "Argument 'protocol' must be equal to 'https' or 'ssh'",
        call. = FALSE
      )
    }
  }

  invisible(NULL)
}


#' Assert user information
#' @param meta a list of the user information.
#' @noRd
assert_valid_credentials <- function(meta) {
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


#' Set default git protocol to https and/or rename to 'usethis.protocol'
#' @param meta a list of the user information.
#' @noRd
set_default_git_protocol <- function(meta) {
  if (!("protocol" %in% names(meta))) {
    meta[["usethis.protocol"]] <- "https"
  } else {
    meta[["usethis.protocol"]] <- meta[["protocol"]]
    meta <- meta[!(names(meta) %in% "protocol")]
  }

  meta
}


#' Return TRUE if the user provide information
#' @param meta a list of the user information.
#' @noRd
should_edit_r_profile <- function(meta) {
  if (length(meta) > 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}


#' Create information message to edit the user .Rprofile
#' @param meta a list of the user information.
#' @noRd
create_r_profile_content <- function(meta) {
  r_prof <- "## rcompendium credentials ----"

  opts <- paste0("\n  ", names(meta), " = \"", unlist(meta), "\"")
  opts <- paste0(opts, collapse = ", ")

  c(r_prof, paste0("options(", opts, "\n)", ""))
}


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


#' Build the path to the user .Rprofile
#' @noRd
build_r_profile_path <- function() {
  custom_r_profile_path <- Sys.getenv("R_PROFILE_USER")
  if (custom_r_profile_path != "") {
    r_profile_path <- custom_r_profile_path
  } else {
    r_profile_path <- file.path(fs::path_home_r(), ".Rprofile")
  }

  r_profile_path
}


#' Create the user .Rprofile (if required) and return the path
#' @noRd
create_r_profile_if_needed <- function() {
  r_profile_path <- build_r_profile_path()
  if (!file.exists((r_profile_path))) {
    invisible(file.create(r_profile_path))
  }

  invisible(r_profile_path)
}


#' Initialize project (create .here if require)
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


#' Error if the R/ directory does not exist
#' @noRd
stop_if_missing_r_dir <- function() {
  if (!dir.exists(build_abs_path("R"))) {
    stop("The directory 'R/' cannot be found.", call. = FALSE)
  }

  invisible(NULL)
}


#' List the path of all R files in R/
#' @noRd
get_r_file_paths <- function() {
  list.files(
    path = build_abs_path("R"),
    pattern = "\\.R$",
    full.names = TRUE,
    ignore.case = TRUE
  )
}


#' Error if the R/ directory is empty
#' @noRd
stop_if_missing_r_files <- function() {
  if (length(get_r_file_paths()) == 0) {
    stop("The 'R/' folder is empty.", call. = FALSE)
  }
}


#' Import the content of all R files in R/
#' @param path a vector of the R file paths
#' @noRd
read_r_files <- function(path) {
  lapply(path, function(x) readLines(con = x, warn = FALSE))
}


#' Extract (regex) and clean R function names
#' @param x a list of function definitions
#' @noRd
extract_r_function_names <- function(x) {
  x <- lapply(x, function(x) {
    x[grep("\\s{0,}(<-|=)\\s{0,}function\\s{0,}\\(", x)]
  })

  x <- lapply(x, function(x) gsub("\\s", "", x))
  x <- lapply(x, function(x) gsub("(<-|=)function.*", "", x))
  x <- unlist(x)

  pos <- grep("\\(|^error$", x)
  if (length(pos) > 0) {
    x <- x[-pos]
  }

  sort(unique(x))
}


#' Extract the name of the exported functions in the NAMESPACE
#' @noRd
extract_exported_r_function_names <- function() {
  path <- build_abs_path("NAMESPACE")

  if (file.exists(path)) {
    namespace <- readLines(
      con = path,
      warn = FALSE
    )

    exported_r_functions <- gsub(
      "export\\(|\\)",
      "",
      namespace[grep("^export", namespace)]
    )

    if (length(exported_r_functions) == 0) {
      return(NULL)
    }
  } else {
    exported_r_functions <- NULL
  }

  exported_r_functions
}


#' Main function to extract, clean and return function names
#' (exported & internal)
#' @noRd
detect_r_function_names <- function() {
  funs <- list(
    "external" = NULL,
    "internal" = NULL
  )

  r_files <- get_r_file_paths()
  r_functions <- read_r_files(r_files)
  r_functions <- extract_r_function_names(r_functions)

  if (length(r_functions) > 0) {
    exported_r_functions <- extract_exported_r_function_names()

    if (length(exported_r_functions) > 0) {
      funs$"external" <- r_functions[(r_functions %in% exported_r_functions)]

      funs$"internal" <- r_functions[!(r_functions %in% exported_r_functions)]
    } else {
      funs$"internal" <- r_functions
    }
  }

  funs
}
