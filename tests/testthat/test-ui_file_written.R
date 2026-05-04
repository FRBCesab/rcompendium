## ui_file_written() ----

test_that("ui_file_written() works - verbose", {
  with_local_project({
    initialize_project(quiet = TRUE)
    path <- build_abs_path(".github", "dependabot.yaml")

    expect_no_message(suppressMessages(ui_file_written(path)))
    expect_null(x <- suppressMessages(ui_file_written(path)))

    expect_no_message(suppressMessages(ui_file_written(path, quiet = FALSE)))
    expect_null(x <- suppressMessages(ui_file_written(path, quiet = FALSE)))
  })
})

test_that("ui_file_written() works - quiet", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path(".github", "dependabot.yaml")

    expect_silent(ui_file_written(path, quiet = TRUE))
    expect_null(x <- ui_file_written(path, quiet = TRUE))
  })
})
