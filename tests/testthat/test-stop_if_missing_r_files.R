## stop_if_missing_r_files() ----

test_that("stop_if_missing_r_files() errors - empty R/", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create("R")

    expect_error(
      stop_if_missing_r_files(path = getwd()),
      "The 'R/' folder is empty.",
      fixed = TRUE
    )
  })
})

test_that("stop_if_missing_r_files() works - no .R file in R/", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create("R")
    asserts <- file.path(getwd(), "R", "asserts.Rmd")
    file.create(asserts)

    expect_error(
      stop_if_missing_r_files(path = getwd()),
      "The 'R/' folder is empty.",
      fixed = TRUE
    )
  })
})

test_that("stop_if_missing_r_files() works - not empty R/", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create("R")
    asserts <- file.path(getwd(), "R", "asserts.R")
    file.create(asserts)

    expect_silent(stop_if_missing_r_files(path = getwd()))
    expect_null(x <- stop_if_missing_r_files(path = getwd()))

    helpers <- file.path(getwd(), "R", "helpers.R")
    file.create(helpers)

    expect_silent(stop_if_missing_r_files(path = getwd()))
    expect_null(x <- stop_if_missing_r_files(path = getwd()))
  })
})
