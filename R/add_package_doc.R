#' Create a package-level documentation file
#'
#' @description
#' This function adds a package-level documentation file (`pkg-package.R`) in
#' the `R/` folder. This file will make help available to the user via `?pkg`
#' (where `pkg` is the name of the package). It a good place to put general
#' directives like `@import` and `@importFrom`.
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
#' add_package_doc()
#' }

add_package_doc <- function(
  open = TRUE,
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_project()

  stop_if_not_logical(open)
  stop_if_not_logical(overwrite)
  stop_if_not_logical(quiet)

  meta <- resolve_project_meta()

  path <- build_abs_path("R", paste0(meta$project_name, "-package.R"))

  assert_file_not_exists_or_overwrite(path, overwrite)

  if (should_create_file(path, overwrite)) {
    ensure_dir_exists(dirname(path))

    create_template("package/package-package.R", path, meta)

    ui_file_written(path, quiet)
  }

  open_file_if_needed(path, open)

  invisible(NULL)
}
