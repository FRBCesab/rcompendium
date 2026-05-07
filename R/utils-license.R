#' Error if the license name if not available
#' @param license a character of length of 1. The name of the license.
#' @noRd
stop_if_invalid_license_name <- function(license) {
  stop_if_not_string(license)

  license_id <- which(licenses$tag == license)

  if (length(license_id) == 0) {
    stop(
      "Invalid license. Please use `get_available_licenses()` to select an ",
      "appropriate one."
    )
  }

  invisible(NULL)
}


#' Error if given & family are not provided (MIT only)
#' @param license a character of length of 1. The name of the license.
#' @param meta a list of the project metadata.
#' @noRd
stop_if_invalid_mit_meta <- function(license, meta) {
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


#' Update the License field in the DESCRIPTION file
#' @param license a character of length of 1. The name of the license.
#' @param meta a list of the project metadata.
#' @noRd
create_mit_copyright_holder_file <- function(license, meta, quiet = FALSE) {
  path <- build_abs_path("LICENSE")

  if (license == "MIT") {
    content <- c(
      paste("YEAR:", meta$year),
      paste("COPYRIGHT HOLDER:", meta$given, meta$family)
    )

    writeLines(text = content, con = path)

    ui_file_written("LICENSE", quiet = quiet)
  } else {
    if (file.exists(path)) {
      invisible(
        file.remove(path)
      )
    }
  }

  invisible(NULL)
}


#' Retrieve license information (file name, url, etc.)
#' @param license a character of length of 1. The name of the license.
#' @noRd
get_license_meta <- function(license) {
  if (!is.null(license)) {
    license_id <- which(licenses$tag == license)
    return(as.list(licenses[license_id, ]))
  } else {
    return(NULL)
  }
}


#' Retrieve the name of the license used in the project
#' @noRd
get_project_license_name <- function() {
  if (file.exists(build_abs_path("DESCRIPTION"))) {
    descr_file <- read_descr()
    return(gsub(" \\+ file LICENSE", "", descr_file$License))
  } else {
    return(NULL)
  }
}


#' Retrieve the URL of the license used in the project
#' @noRd
get_project_license_url <- function() {
  license <- get_project_license_name()

  if (!is.null(license)) {
    return(get_license_meta(license)$url)
  } else {
    return(NULL)
  }
}


#' Update the License field in the DESCRIPTION file
#' @param license a character of length of 1. The name of the license.
#' @noRd
update_license_field_in_desc <- function(license, quiet = FALSE) {
  descr <- read_descr()
  descr$"License" <- ifelse(license == "MIT", "MIT + file LICENSE", license)
  write_descr(descr)

  ui_success(
    "Setting {.field License} field in DESCRIPTION to {.val {license}}",
    quiet = quiet
  )

  invisible(NULL)
}


#' Return TRUE if the license should be added/updated
#' @param license a character of length of 1. The name of the license.
#' @noRd
should_update_license <- function(license) {
  if (!is.null(license)) {
    descr_license <- get_project_license_name()

    if (!is.null(descr_license)) {
      if (descr_license == license) {
        return(FALSE)
      } else {
        return(TRUE)
      }
    } else {
      return(FALSE)
    }
  } else {
    return(FALSE)
  }
}
