## Utilities functions - Handle files ----

#' **Open a file in editor**
#'
#' @noRd

edit_file <- function(path) {
  if (rstudioapi::isAvailable() && rstudioapi::hasFun("navigateToFile")) {
    rstudioapi::navigateToFile(path)
  } else {
    utils::file.edit(path)
  }

  invisible(NULL)
}


#' **Import DESCRIPTION content**
#'
#' @noRd

read_descr <- function() {
  stop_if_not_project()

  path <- build_abs_path()

  col_names <- colnames(read.dcf(file.path(path, "DESCRIPTION")))

  descr <- read.dcf(file.path(path, "DESCRIPTION"), keep.white = col_names)

  if (nrow(descr) != 1) {
    stop("Malformed 'DESCRIPTION' file")
  }

  as.data.frame(descr, stringsAsFactors = FALSE)
}


#' **Write DESCRIPTION (erase content)**
#'
#' @noRd

write_descr <- function(descr_file) {
  stop_if_not_project()

  path <- build_abs_path()

  write.dcf(
    descr_file,
    file = file.path(path, "DESCRIPTION"),
    indent = 4,
    width = 80,
    keep.white = colnames(descr_file)
  )

  invisible(NULL)
}


#' **Add a badge to the README.Rmd**
#'
#' @param badge a Markdown expression.
#' @param pattern a special tag (i.e. 'LifeCycle', 'Project Status',
#'   'CRAN status', 'License', 'R-CMD-check')
#'
#' @noRd

add_badge <- function(badge, pattern) {
  path <- build_abs_path()

  ## Checks ----

  if (missing(badge)) {
    stop("No badge to add in the 'README.Rmd'.")
  }
  if (missing(pattern)) {
    stop("Argument 'pattern' is missing.")
  }

  if (!file.exists(file.path(path, "README.Rmd"))) {
    stop("The file 'README.Rmd' cannot be found.")
  }

  ## Read README.Rmd ----

  read_me <- readLines(con = file.path(path, "README.Rmd"))

  ## Check if Badges Locations are present ----

  badge_start <- grep("<!-- badges: start -->", read_me)
  badge_end <- grep("<!-- badges: end -->", read_me)

  if (!length(badge_start) || !length(badge_end)) {
    stop(
      "Unable to parse badges location in 'README.Rmd' file.\n",
      "Did you remove the tag '<!-- badges: start -->' and/or ",
      "'<!-- badges: end -->'?"
    )
  }

  ## Extract existing badges (if exist) ----

  if ((badge_start + 1) == badge_end) {
    badges <- character(0)
  } else {
    badges <- paste0(
      read_me[(badge_start + 1):(badge_end - 1)],
      collapse = "\n"
    )
    badges <- unlist(strsplit(badges, "\n"))
    badges <- badges[!(badges == "")]
  }

  ## Replace/Add badge ----

  pos <- grep(paste0("^\\s{0,}\\[!\\[", pattern), badges)

  if (length(pos)) {
    badges[pos] <- badge
  } else {
    badges <- c(badges, badge)
  }

  read_me <- c(
    read_me[1:badge_start],
    badges,
    read_me[badge_end:length(read_me)]
  )

  ## Replace README.Rmd ----

  writeLines(read_me, con = file.path(path, "README.Rmd"))

  invisible(NULL)
}


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


#' **Search and replace strings in files**
#'
#' File version of [gsub()]. Modified from [xfun::gsub_file()] allowing to
#' search for strings in multiple lines.
#'
#' @param file Path of a single file.
#'
#' @param ... Arguments passed to [gsub()].
#'
#' @noRd

gsub_in_file <- function(file, ...) {
  if (!(file.access(file, 2) == 0 && file.access(file, 4) == 0)) {
    stop("Unable to read or write to ", file)
  }

  x1 <- tryCatch(xfun::read_utf8(file, error = TRUE), error = function(e) {
    stop(e)
  })

  if (is.null(x1)) {
    return(invisible(NULL))
  }

  x1 <- paste0(x1, collapse = "\n")
  x2 <- gsub(x = x1, ...)

  if (!identical(x1, x2)) {
    xfun::write_utf8(x2, file)
  }

  invisible(NULL)
}


#' **URL of the template GitHub repository**
#'
#' @noRd

template_url <- function() {
  "https://raw.githubusercontent.com/FRBCesab/r-templates/refs/heads/main/"
}


#' **Helper function to download a file from the template GitHub repo**
#'
#' @param slug a character of length 1. End of the file URL
#'   (e.g. `package/CITATION`)
#'
#' @param filename a character of length 1. The absolute path of the file.
#'
#' @noRd

download_template <- function(slug, filename) {
  stop_if_not_string(slug)
  stop_if_not_string(filename)

  utils::download.file(
    url = paste0(template_url(), slug),
    destfile = filename,
    mode = "wb",
    quiet = TRUE
  )

  invisible(NULL)
}
