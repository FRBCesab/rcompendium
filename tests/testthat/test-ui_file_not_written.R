## ui_file_not_written() ----

test_that("ui_file_not_written() works - No quiet", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- file.path(".github", "dependabot.yaml")

    expect_snapshot({
      ui_file_not_written(path, quiet = FALSE)
    })
  })
})

test_that("ui_file_not_written() works - Quiet", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- file.path(".github", "dependabot.yaml")

    expect_no_message({
      ui_file_not_written(path, quiet = TRUE)
    })

    expect_silent({
      ui_file_not_written(path, quiet = TRUE)
    })
  })
})
