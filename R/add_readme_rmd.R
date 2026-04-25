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
  assert_valid_project_type(type)
  stop_if_not_logical(open, overwrite, quiet)

  full_path <- build_full_path("README.Rmd")
  rel_path <- build_rel_path("README.Rmd")

  assert_file_not_exists_or_overwrite(rel_path, overwrite)

  meta <- resolve_project_meta(
    given = given,
    family = family,
    organisation = organisation
  )

  stop_if_null_or_empty(meta$given, "given")
  stop_if_null_or_empty(meta$family, "family")

  if (should_create_file(full_path, overwrite)) {
    ensure_dir_exists(dirname(full_path))

    create_template(paste0("readme/README-", type, ".Rmd"), rel_path, meta)

    ui_file_written(rel_path, quiet)
    add_to_buildignore("README.Rmd", quiet = quiet)
    add_to_buildignore("README.html", quiet = TRUE)
  }

  open_file_if_needed(full_path, open)

  invisible(NULL)
}
