#' **Add Template sticker**
#'
#' @param overwrite a logical value. If a file is already present and
#'   `overwrite = TRUE`, it will be erased and replaced.
#'
#' @param quiet a logical value. If `TRUE` messages are deleted. Default is
#'   `FALSE`.
#'
#' @noRd

add_sticker <- function(type, overwrite = FALSE, quiet = FALSE) {
  if (missing(type)) {
    stop("Argument 'type' is required.")
  }

  if (is.null(type)) {
    stop("Argument 'type' must be 'package' or 'compendium'.")
  }

  if (length(type) != 1) {
    stop("Argument 'type' must be 'package' or 'compendium'.")
  }

  if (!(tolower(type) %in% c("package", "compendium"))) {
    stop("Argument 'type' must be 'package' or 'compendium'.")
  }

  type <- tolower(type)

  stop_if_not_logical(overwrite)
  stop_if_not_logical(quiet)

  if (type == "package") {
    path <- build_abs_path(
      "man",
      "figures",
      "logo.png"
    )

    pathdir <- build_abs_path("man", "figures")
  } else {
    path <- build_abs_path(
      "figures",
      "readme",
      "logo.png"
    )

    pathdir <- file.path("figures", "readme")
  }

  if (file.exists(path) && !overwrite) {
    stop(paste0(
      "A '",
      pathdir,
      "/",
      "logo.png' is already present. ",
      "If you want to replace it, please use `overwrite = TRUE`."
    ))
  }

  if (!dir.exists(build_abs_path(pathdir))) {
    dir.create(
      build_abs_path(pathdir),
      showWarnings = FALSE,
      recursive = TRUE
    )
  }

  download_template(
    slug = paste0("hexsticker/", type, "-sticker.png"),
    filename = build_abs_path(pathdir, "logo.png")
  )

  if (type == "package") {
    if (!dir.exists(build_abs_path("inst", "package-sticker"))) {
      dir.create(
        build_abs_path("inst", "package-sticker"),
        showWarnings = FALSE,
        recursive = TRUE
      )
    }

    path <- build_abs_path("inst", "package-sticker", "r_logo.png")

    if (!file.exists(path)) {
      download_template(
        slug = "hexsticker/r_logo.png",
        filename = path
      )
    }

    path <- build_abs_path(
      "inst",
      "package-sticker",
      "create_package_sticker.R"
    )

    if (!file.exists(path)) {
      download_template(
        slug = "hexsticker/create_package_sticker.R",
        filename = path
      )
    }
  }

  if (!quiet) {
    ui_done(paste0(
      "Adding {ui_value('package-sticker.png')} to ",
      "{ui_value('README.Rmd')}"
    ))
  }

  invisible(NULL)
}
