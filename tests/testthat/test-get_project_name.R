## get_project_name() ----

test_that("get_project_name() works", {
  with_local_project({
    initialize_project(quiet = TRUE)

    res <- get_project_name()
    expect_type(res, "character")
    expect_length(res, 1L)
    expect_equal(res, "pkgtest")
  })
})
