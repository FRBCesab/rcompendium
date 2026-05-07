## read_descr() ----

test_that("read_descr() errors - No DESCRIPTION", {
  with_local_project({
    initialize_project(quiet = TRUE)

    expect_error(
      read_descr(),
      "The 'DESCRIPTION' file does not exist.",
      fixed = TRUE
    )
  })
})


test_that("read_descr() errors - DESCRIPTION malformed", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c(
      "Package: pkgtest",
      "",
      "Package: pkgtest"
    )

    writeLines(content, "DESCRIPTION")

    expect_error(
      read_descr(),
      "Malformed 'DESCRIPTION' file.",
      fixed = TRUE
    )
  })
})


test_that("read_descr() errors - No DCF format", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c("This is not a DCF file")

    writeLines(content, "DESCRIPTION")

    expect_error(
      read_descr(),
      "The 'DESCRIPTION' file is not a valid DCF file.",
      fixed = TRUE
    )
  })
})


test_that("read_descr() works", {
  with_local_project({
    initialize_project(quiet = TRUE)

    create_dummy_desc_file()

    res <- read_descr()

    expect_s3_class(res, "data.frame")
    expect_equal(res$Package, "pkgtest")
    expect_equal(nrow(res), 1L)
  })
})
