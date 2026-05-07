## stop_if_invalid_project_name() ----

test_that("stop_if_invalid_project_name() errors", {
  with_local_project(name = "pkg-test", {
    initialize_project(quiet = TRUE)

    expect_error(
      stop_if_invalid_project_name(),
      paste0(
        "The project name is invalid. ",
        "Only letters, numbers and the dot are allowed."
      ),
      fixed = TRUE
    )
  })

  with_local_project(name = "pkg_test", {
    initialize_project(quiet = TRUE)

    expect_error(
      stop_if_invalid_project_name(),
      paste0(
        "The project name is invalid. ",
        "Only letters, numbers and the dot are allowed."
      ),
      fixed = TRUE
    )
  })

  with_local_project(name = "123pkgtest", {
    initialize_project(quiet = TRUE)

    expect_error(
      stop_if_invalid_project_name(),
      paste0(
        "The project name is invalid. ",
        "Only letters, numbers and the dot are allowed."
      ),
      fixed = TRUE
    )
  })

  with_local_project(name = ".pkgtest", {
    initialize_project(quiet = TRUE)

    expect_error(
      stop_if_invalid_project_name(),
      paste0(
        "The project name is invalid. ",
        "Only letters, numbers and the dot are allowed."
      ),
      fixed = TRUE
    )
  })
})

test_that("stop_if_invalid_project_name() works", {
  with_local_project(name = "pkgtest", {
    initialize_project(quiet = TRUE)

    expect_invisible(
      stop_if_invalid_project_name()
    )
  })

  with_local_project(name = "pkg.test", {
    initialize_project(quiet = TRUE)

    expect_invisible(
      stop_if_invalid_project_name()
    )
  })

  with_local_project(name = "pkg123", {
    initialize_project(quiet = TRUE)

    expect_invisible(
      stop_if_invalid_project_name()
    )
  })

  with_local_project(name = "pkg.123", {
    initialize_project(quiet = TRUE)

    expect_invisible(
      stop_if_invalid_project_name()
    )
  })
})
