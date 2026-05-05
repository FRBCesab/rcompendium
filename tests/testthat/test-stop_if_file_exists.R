## stop_if_file_exists() ----

test_that("stop_if_file_exists() errors", {
  with_local_project({
    initialize_project(quiet = TRUE)

    invisible(file.create("README"))

    expect_error(
      stop_if_file_exists("README", overwrite = FALSE),
      paste0(
        "The file 'README' already exists. ",
        "To replace it, please use `overwrite = TRUE`."
      ),
      fixed = TRUE
    )
  })
})

test_that("stop_if_file_exists() works - overwrite is TRUE", {
  with_local_project({
    initialize_project(quiet = TRUE)

    expect_silent(
      stop_if_file_exists("README", overwrite = TRUE)
    )

    expect_null(
      x <- stop_if_file_exists("README", overwrite = TRUE)
    )

    invisible(file.create("README"))

    expect_silent(
      stop_if_file_exists("README", overwrite = TRUE)
    )

    expect_null(
      x <- stop_if_file_exists("README", overwrite = TRUE)
    )
  })
})

test_that("stop_if_file_exists() works - file not exists", {
  with_local_project({
    initialize_project(quiet = TRUE)

    expect_silent(
      stop_if_file_exists("README", overwrite = FALSE)
    )

    expect_null(
      x <- stop_if_file_exists("README", overwrite = FALSE)
    )
  })
})
