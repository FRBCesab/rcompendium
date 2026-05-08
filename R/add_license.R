#' Add a LICENSE file
#'
#' @description
#' This function adds a license to the project. It will add the license name
#' in the `License` field of the `DESCRIPTION` file and write the content of
#' the license in a `LICENSE.md` file.
#'
#' @param license A character of length 1. The license name.
#'   Run [get_available_licenses()]) to select an appropriate one.
#'
#' @inheritParams add_citation
#'
#' @return No return value.
#'
#' @export
#'
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_license(license = "MIT")
#' add_license(license = "GPL (>= 2)")
#' }

add_license <- function(
  license = NULL,
  given = NULL,
  family = NULL,
  quiet = FALSE
) {
  stop_if_not_project()

  stop_if_not_logical(quiet)
  stop_if_invalid_license_name(license)

  path <- build_abs_path("LICENSE.md")

  meta <- resolve_project_meta(
    given = given,
    family = family
  )

  stop_if_invalid_mit_meta(license, meta)

  if (should_update_license(license)) {
    update_license_field_in_desc(license, quiet)

    create_mit_copyright_holder_file(license, meta, quiet)

    create_template(
      slug = paste0("licenses/license-", get_license_meta(license)[["file"]]),
      path = path,
      meta = meta
    )

    ui_file_written(path, quiet)
    add_to_buildignore("LICENSE.md", quiet = quiet)
  } else {
    cli::cli_alert_danger(
      "The {.val {license}} license is already set"
    )
  }

  invisible(NULL)
}
