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

  url <- paste0(.TEMPLATE_FILE_URL, slug)
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

      gsub_in_file(path, placeholder, as.character(value))
    }
  }

  invisible(NULL)
}


#' List templates of a directory
#' @param directory a character of length of 1. The name of the GH directory.
#' @noRd
list_template_files <- function(directory = NULL) {
  if (!is.null(directory)) {
    endpoint <- paste0(.GITHUB_API_ENDPOINT, directory)
  } else {
    endpoint <- .GITHUB_API_ENDPOINT
  }

  req <- httr2::request(.GITHUB_API_URL)
  req <- httr2::req_url_path_append(req, endpoint)
  req <- httr2::req_headers(
    req,
    `Accept` = "application/vnd.github.raw+json",
    `Content-Type` = "application/json",
    `X-GitHub-Api-Version` = .GITHUB_API_VERSION
  )

  resp <- httr2::req_perform(req)

  httr2::resp_check_status(resp)

  content <- httr2::resp_body_json(resp)

  files <- vapply(content, function(x) x$name %||% NA_character_, character(1))
  types <- vapply(content, function(x) x$type %||% NA_character_, character(1))

  files[!is.na(files) & types %in% "file" & files != "README.md"]
}
