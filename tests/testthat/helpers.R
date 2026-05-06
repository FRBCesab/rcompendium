#' Setup Tests Infrastructure
#'

## Helper for tests ----

local_project <- function(name = "pkgtest") {
  # Crée un dossier temporaire de base
  tmp <- tempfile(pattern = "tempdir")

  # Compose le chemin complet
  dir <- file.path(tmp, name)

  dir.create(dir, recursive = TRUE, showWarnings = FALSE)

  dir
}

with_local_project <- function(expr, name = "pkgtest") {
  dir <- local_project(name)

  stopifnot(dir.exists(dir))

  withr::with_dir(dir, eval(substitute(expr), parent.frame()))
}


create_dummy_desc_file <- function() {
  content <- c(
    "Package: pkgtest",
    "Type: Package",
    "Version: 1.2.3",
    "License: GPL (>= 2)"
  )

  writeLines(content, "DESCRIPTION")
  invisible(NULL)
}


expect_path_equal <- function(object, expected) {
  norm <- function(x) {
    normalizePath(x, winslash = "/", mustWork = FALSE)
  }

  testthat::expect_equal(norm(object), norm(expected))
}


get_arg_label <- function(x) {
  expr <- substitute(x)
  get_arg_name(expr)
}
