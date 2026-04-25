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
