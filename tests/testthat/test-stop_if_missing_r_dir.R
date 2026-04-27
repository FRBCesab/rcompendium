## stop_if_missing_r_dir() ----

test_that("stop_if_missing_r_dir() errors", {
  with_local_project({
    initialize_project(quiet = TRUE)

    expect_error(
      stop_if_missing_r_dir(),
      "The directory 'R/' cannot be found.",
      fixed = TRUE
    )

    expect_error(
      stop_if_missing_r_dir(path = getwd()),
      "The directory 'R/' cannot be found.",
      fixed = TRUE
    )
  })
})

test_that("stop_if_missing_r_dir() works", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create("R")

    expect_silent(stop_if_missing_r_dir())
    expect_silent(stop_if_missing_r_dir(path = getwd()))
  })
})
