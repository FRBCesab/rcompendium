## build_abs_path() ----

test_that("build_abs_path() errors - Not a project", {
  with_local_project({
    path <- "README.md"

    expect_error(
      build_abs_path(path),
      paste0(
        "Cannot determine project root. ",
        "Make sure you are inside an R project or a directory containing ",
        "a '.here' file."
      ),
      fixed = TRUE
    )
  })
})

test_that("build_abs_path() works - Is a project", {
  with_local_project({
    create_dummy_desc_file()

    path <- "README.md"
    output <- build_abs_path(path)

    expect_true(inherits(output, "character"))
    expect_equal(length(output), 1L)
    expect_equal(output, file.path(resolve_project_root(), path))

    path <- file.path("subdir", "README.md")
    output <- build_abs_path(path)

    expect_true(inherits(output, "character"))
    expect_equal(length(output), 1L)
    expect_equal(output, file.path(resolve_project_root(), path))
  })
})
