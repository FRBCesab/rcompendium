## get_project_license_url() ----

test_that("get_project_license_url() works - GPL", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c(
      "Package: pkgtest",
      "License: GPL (>= 2)"
    )

    writeLines(content, "DESCRIPTION")

    res <- get_project_license_url()

    expect_true(inherits(res, "character"))
    expect_length(res, 1L)
    expect_equal(res, "https://choosealicense.com/licenses/gpl-2.0/")
  })
})


test_that("get_project_license_url() works - MIT", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c(
      "Package: pkgtest",
      "License: MIT + file LICENSE"
    )

    writeLines(content, "DESCRIPTION")

    res <- get_project_license_url()

    expect_true(inherits(res, "character"))
    expect_length(res, 1L)
    expect_equal(res, "https://choosealicense.com/licenses/mit/")
  })
})


test_that("get_project_license_url() works - No License", {
  with_local_project({
    initialize_project(quiet = TRUE)

    res <- get_project_license_url()
    expect_null(res)
  })
})
