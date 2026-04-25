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
  stop_if_not_logical(open, overwrite, quiet)

  meta <- resolve_project_meta()

  rel_path <- build_rel_path("R", paste0(meta$project_name, "-package.R"))
  full_path <- build_full_path(rel_path)

  assert_file_not_exists_or_overwrite(rel_path, overwrite)

  if (should_create_file(full_path, overwrite)) {
    ensure_dir_exists(dirname(full_path))

    create_template("package/package-package.R", rel_path, meta)

    ui_file_written(rel_path, quiet)
  }

  open_file_if_needed(full_path, open)

  invisible(NULL)
}
