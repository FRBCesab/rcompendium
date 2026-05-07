## should_update_license() ----

test_that("should_update_license() returns FALSE - No DESCRIPTION", {
  with_local_project({
    initialize_project(quiet = TRUE)

    expect_false(should_update_license("GPL (>= 2)"))
  })
})


test_that("should_update_license() returns FALSE - Same license", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c(
      "Package: pkgtest",
      "License: GPL (>= 2)"
    )

    writeLines(content, "DESCRIPTION")

    expect_false(should_update_license("GPL (>= 2)"))
  })
})


test_that("should_update_license() returns FALSE - No license", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c(
      "Package: pkgtest",
      "License: GPL (>= 2)"
    )

    writeLines(content, "DESCRIPTION")

    expect_false(should_update_license(NULL))
  })
})


test_that("should_update_license() returns TRUE", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c(
      "Package: pkgtest",
      "License: GPL (>= 2)"
    )

    writeLines(content, "DESCRIPTION")

    expect_true(should_update_license("MIT"))
  })
})
