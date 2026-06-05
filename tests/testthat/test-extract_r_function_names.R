## extract_r_function_names() ----

test_that("read_r_files() works", {
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

    zzz <- build_abs_path("R", "zzz.R")
    file.create(zzz)

    path <- get_r_file_paths()
    funs <- read_r_files(path)

    x <- expect_silent(extract_r_function_names(funs))

    expect_true(inherits(x, "character"))
    expect_equal(length(x), 3L)
    expect_equal(x[1], "`%||%`")
    expect_equal(x[2], "path_proj")
    expect_equal(x[3], "try_read")
  })
})
