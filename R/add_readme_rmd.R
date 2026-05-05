#' Create a README file
#'
#' This function creates a `README.Rmd` file at the root of the project based
#' on a template. Once edited user needs to knit it into a `README.md`.
#'
#' @param type A character of length 1. If `package` (default) a GitHub
#'   `README.Rmd` specific to an R package will be created. If `compendium` a
#'   GitHub `README.Rmd` specific to a research compendium will be created.
#'
#' @inheritParams add_citation
#' @inheritParams set_credentials
#'
#' @inheritParams set_credentials
#'
#' @return No return value.
#'
#' @export
#'
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_readme_rmd(type = "package")
#' }

add_readme_rmd <- function(
  type = "package",
  given = NULL,
  family = NULL,
  organisation = NULL,
  open = TRUE,
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_project()

  stop_if_not_logical(open)
  stop_if_not_logical(overwrite)
  stop_if_not_logical(quiet)

  stop_if_invalid_project_type(type)

  path <- build_abs_path("README.Rmd")

  stop_if_file_exists(path, overwrite)

  meta <- resolve_project_meta(
    given = given,
    family = family,
    organisation = organisation
  )

  stop_if_not_string(meta$given)
  stop_if_not_string(meta$family)

  if (should_create_file(path, overwrite)) {
    create_folder_if_needed(dirname(path))

    create_template(paste0("readme/README-", type, ".Rmd"), path, meta)

    ui_file_written(path, quiet)
    add_to_buildignore("README.Rmd", quiet = quiet)
    add_to_buildignore("README.html", quiet = TRUE)
  }

  open_file_if_needed(path, open)

  invisible(NULL)
}
