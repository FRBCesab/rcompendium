## read_r_files() ----

test_that("read_r_files() works - empty R files", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(build_abs_path("R"))

    asserts <- build_abs_path("R", "asserts.R")
    file.create(asserts)

    path <- get_r_file_paths()

    x <- expect_silent(read_r_files(path))
    expect_true(inherits(x, "list"))
    expect_equal(length(x), length(path))
    expect_equal(length(x[[1]]), 0L)

    helpers <- build_abs_path("R", "helpers.R")
    file.create(helpers)

    path <- get_r_file_paths()

    x <- expect_silent(read_r_files(path))
    expect_true(inherits(x, "list"))
    expect_equal(length(x), length(path))
    expect_equal(length(x[[1]]), 0L)
    expect_equal(length(x[[2]]), 0L)
  })
})

test_that("read_r_files() works - R files w/ content", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(build_abs_path("R"))

    asserts <- build_abs_path("R", "asserts.R")
    content <- c(
      "#' @noRd",
      "`%||%` <- function(x, y) {",
      "  if (is.null(x)) y else x",
      "}",
      "",
      "path_proj <- function() usethis::proj_get()"
    )

    writeLines(content, asserts)

    path <- get_r_file_paths()

    x <- expect_silent(read_r_files(path))
    expect_true(inherits(x, "list"))
    expect_equal(length(x), length(path))
    expect_equal(length(x[[1]]), 6L)

    expect_equal(x[[1]][1], "#' @noRd")
    expect_equal(x[[1]][5], "")

    helpers <- build_abs_path("R", "helpers.R")
    content <- c(
      "#' @noRd",
      "try_read <- function(file) {",
      "  tryCatch(read_utf8(file), error = function(e) {",
      "    stop(e)",
      "  })",
      "}"
    )

    writeLines(content, helpers)

    path <- get_r_file_paths()

    x <- expect_silent(read_r_files(path))
    expect_true(inherits(x, "list"))

    expect_equal(length(x), length(path))
    expect_equal(length(x[[1]]), 6L)
    expect_equal(length(x[[2]]), 6L)

    expect_equal(x[[1]][1], "#' @noRd")
    expect_equal(x[[1]][5], "")

    expect_equal(x[[2]][1], "#' @noRd")
    expect_equal(x[[2]][4], "    stop(e)")

    zzz <- build_abs_path("R", "zzz.R")
    file.create(zzz)

    path <- get_r_file_paths()

    x <- expect_silent(read_r_files(path))
    expect_true(inherits(x, "list"))

    expect_equal(length(x), length(path))
    expect_equal(length(x[[1]]), 6L)
    expect_equal(length(x[[2]]), 6L)
    expect_equal(length(x[[3]]), 0L)

    expect_equal(x[[1]][1], "#' @noRd")
    expect_equal(x[[1]][5], "")

    expect_equal(x[[2]][1], "#' @noRd")
    expect_equal(x[[2]][4], "    stop(e)")
  })
})
