#' Error if a file exists and if overwrite is FALSE
#' @param path a character of length of 1. The relative path of the file
#' @param overwrite a logical of length 1.
#' @noRd
stop_if_file_exists <- function(path, overwrite) {
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


#' Helper function to download a file from the template GitHub repo
#' @param slug a character of length 1. End of the file URL
#'   (e.g. `package/CITATION`)
#' @param filename a character of length 1. The absolute path of the file.
#' @noRd
download_template <- function(slug, filename) {
  stop_if_not_string(slug)
  stop_if_not_string(filename)

  url <- paste0(get_template_file_url(), slug)
  req <- httr2::request(url)
  req <- httr2::req_method(req, "GET")

  resp <- httr2::req_perform(req)

  httr2::resp_check_status(resp)

  writeBin(httr2::resp_body_raw(resp), filename)

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


#' URL of the templates repo (API)
#' @noRd
get_template_repo_url <- function() {
  "/repos/frbcesab/r-templates/contents/"
}


#' URL of the template GitHub repository
#' @noRd
get_template_file_url <- function() {
  "https://raw.githubusercontent.com/FRBCesab/r-templates/refs/heads/main/"
}
