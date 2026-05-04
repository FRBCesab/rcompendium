## get_r_file_paths() ----

test_that("get_r_file_paths() works - empty R/", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(build_abs_path("R"))

    expect_silent(x <- get_r_file_paths())
    expect_equal(length(x), 0L)
  })
})

test_that("get_r_file_paths() works - no .R file in R/", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(build_abs_path("R"))

    asserts <- build_abs_path("R", "asserts.Rmd")
    file.create(asserts)

    expect_silent(x <- get_r_file_paths())
    expect_equal(length(x), 0L)
  })
})

test_that("get_r_file_paths() works - not empty R/", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(build_abs_path("R"))

    asserts <- build_abs_path("R", "asserts.R")
    file.create(asserts)

    expect_silent(x <- get_r_file_paths())
    expect_true(inherits(x, "character"))
    expect_equal(length(x), 1L)
    expect_equal(x[1], asserts)

    helpers <- build_abs_path("R", "helpers.R")
    file.create(helpers)

    expect_silent(x <- get_r_file_paths())
    expect_true(inherits(x, "character"))
    expect_equal(length(x), 2L)
    expect_equal(x[1], asserts)
    expect_equal(x[2], helpers)
  })
})
