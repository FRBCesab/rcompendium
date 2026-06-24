## create_folder_if_needed() ----

test_that("create_folder_if_needed() works - dir not exists", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path("R")

    expect_silent({
      x <- create_folder_if_needed(path)
    })
    expect_null(x)
    expect_true(dir.exists(path))

    path <- build_abs_path("tests", "testthat")

    expect_silent({
      x <- create_folder_if_needed(path)
    })
    expect_null(x)
    expect_true(dir.exists(path))
  })
})

test_that("create_folder_if_needed() works - dir exists", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path("man")
    dir.create(path, recursive = TRUE, showWarnings = FALSE)

    expect_silent({
      x <- create_folder_if_needed(path)
    })
    expect_null(x)
    expect_true(dir.exists(path))

    path <- build_abs_path("man", "figures")
    dir.create(path, recursive = TRUE, showWarnings = FALSE)

    expect_silent({
      x <- create_folder_if_needed(path)
    })
    expect_null(x)
    expect_true(dir.exists(path))
  })
})
