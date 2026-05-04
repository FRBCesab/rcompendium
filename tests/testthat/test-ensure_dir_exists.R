## ensure_dir_exists() ----

test_that("ensure_dir_exists() works - dir not exists", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path("R")

    expect_silent(ensure_dir_exists(path))
    expect_null(x <- ensure_dir_exists(path))
    expect_true(dir.exists(path))

    path <- build_abs_path("tests", "testthat")

    expect_silent(ensure_dir_exists(path))
    expect_null(x <- ensure_dir_exists(path))
    expect_true(dir.exists(path))
  })
})

test_that("ensure_dir_exists() works - dir exists", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path("man")
    dir.create(path, recursive = TRUE, showWarnings = FALSE)

    expect_silent(ensure_dir_exists(path))
    expect_null(x <- ensure_dir_exists(path))
    expect_true(dir.exists(path))

    path <- build_abs_path("man", "figures")
    dir.create(path, recursive = TRUE, showWarnings = FALSE)

    expect_silent(ensure_dir_exists(path))
    expect_null(x <- ensure_dir_exists(path))
    expect_true(dir.exists(path))
  })
})
