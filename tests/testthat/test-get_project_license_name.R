## get_project_license_name() ----

test_that("get_project_license_name() works - GPL", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c(
      "Package: pkgtest",
      "License: GPL (>= 2)"
    )

    writeLines(content, "DESCRIPTION")

    res <- get_project_license_name()

    expect_true(inherits(res, "character"))
    expect_length(res, 1L)
    expect_equal(res, "GPL (>= 2)")
  })
})


test_that("get_project_license_name() works - MIT", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c(
      "Package: pkgtest",
      "License: MIT + file LICENSE"
    )

    writeLines(content, "DESCRIPTION")

    res <- get_project_license_name()

    expect_true(inherits(res, "character"))
    expect_length(res, 1L)
    expect_equal(res, "MIT")
  })
})


test_that("get_project_license_name() works - No License", {
  with_local_project({
    initialize_project(quiet = TRUE)

    res <- get_project_license_name()
    expect_null(res)
  })
})
