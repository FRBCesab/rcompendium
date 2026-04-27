## get_r_file_paths() ----

test_that("get_r_file_paths() works - empty R/", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create("R")

    expect_silent(x <- get_r_file_paths())
    expect_equal(length(x), 0L)

    expect_silent(x <- get_r_file_paths(path = getwd()))
    expect_equal(length(x), 0L)
  })
})

test_that("get_r_file_paths() works - no .R file in R/", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create("R")
    asserts <- file.path("R", "asserts.Rmd")
    file.create(asserts)

    expect_silent(x <- get_r_file_paths())
    expect_equal(length(x), 0L)

    expect_silent(x <- get_r_file_paths(path = getwd()))
    expect_equal(length(x), 0L)
  })
})

test_that("get_r_file_paths() works - not empty R/", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create("R")
    asserts <- file.path(getwd(), "R", "asserts.R")
    file.create(asserts)

    expect_silent(x <- get_r_file_paths(path = getwd()))
    expect_true(inherits(x, "character"))
    expect_equal(length(x), 1L)
    expect_equal(x[1], asserts)

    helpers <- file.path(getwd(), "R", "helpers.R")
    file.create(helpers)

    expect_silent(x <- get_r_file_paths(path = getwd()))
    expect_true(inherits(x, "character"))
    expect_equal(length(x), 2L)
    expect_equal(x[1], asserts)
    expect_equal(x[2], helpers)
  })
})
