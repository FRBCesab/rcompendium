## stop_if_missing_r_files() ----

test_that("stop_if_missing_r_files() errors - empty R/", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(build_abs_path("R"))

    expect_error(
      stop_if_missing_r_files(),
      "The 'R/' folder is empty.",
      fixed = TRUE
    )
  })
})

test_that("stop_if_missing_r_files() works - no .R file in R/", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(build_abs_path("R"))

    asserts <- build_abs_path("R", "asserts.Rmd")
    file.create(asserts)

    expect_error(
      stop_if_missing_r_files(),
      "The 'R/' folder is empty.",
      fixed = TRUE
    )
  })
})

test_that("stop_if_missing_r_files() works - not empty R/", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(build_abs_path("R"))

    asserts <- build_abs_path("R", "asserts.R")
    file.create(asserts)

    expect_silent(stop_if_missing_r_files())

    helpers <- build_abs_path("R", "helpers.R")
    file.create(helpers)

    expect_silent(stop_if_missing_r_files())
  })
})
