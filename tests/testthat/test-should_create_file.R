## should_create_file() ----

test_that("should_create_file() works - file not exists", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path("README.md")

    expect_true(
      should_create_file(path, overwrite = FALSE)
    )

    expect_true(
      should_create_file(path, overwrite = TRUE)
    )
  })
})

test_that("should_create_file() works - file exists", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path("README.md")

    file.create(path)

    expect_false(
      should_create_file(path, overwrite = FALSE)
    )

    expect_true(
      should_create_file(path, overwrite = TRUE)
    )
  })
})
