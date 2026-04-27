## build_full_path() ----

test_that("build_full_path() works", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- file.path("README")
    output <- build_full_path(path)

    expect_true(inherits(output, "character"))
    expect_equal(length(output), 1L)
    expect_equal(output, file.path(path_proj(), path))

    path <- file.path("README")
    output <- build_full_path(path, path = "/fake/root")

    expect_true(inherits(output, "character"))
    expect_equal(length(output), 1L)
    expect_equal(output, file.path("/fake/root", path))

    path <- file.path("subdir", "README")
    output <- build_full_path(path)

    expect_true(inherits(output, "character"))
    expect_equal(length(output), 1L)
    expect_equal(output, file.path(path_proj(), path))

    path <- file.path("subdir", "README")
    output <- build_full_path(path, path = "/fake/root")

    expect_true(inherits(output, "character"))
    expect_equal(length(output), 1L)
    expect_equal(output, file.path("/fake/root", path))
  })
})
