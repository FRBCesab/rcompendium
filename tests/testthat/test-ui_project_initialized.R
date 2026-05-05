## ui_project_initialized() ----

test_that("ui_project_initialized() works - No quiet", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- basename(build_abs_path())

    expect_snapshot({
      ui_project_initialized(path, quiet = FALSE)
    })
  })
})

test_that("ui_project_initialized() works - Quiet", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- basename(build_abs_path())

    expect_no_message({
      ui_project_initialized(path, quiet = TRUE)
    })

    expect_silent({
      ui_project_initialized(path, quiet = TRUE)
    })
  })
})
