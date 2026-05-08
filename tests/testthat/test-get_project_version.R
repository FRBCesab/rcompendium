## get_project_version() ----

test_that("get_project_version() works - Description exists", {
  with_local_project({
    initialize_project(quiet = TRUE)
    create_dummy_desc_file()

    res <- get_project_version()

    expect_type(res, "character")
    expect_length(res, 1L)
    expect_match(res, "^[0-9]+\\.[0-9]+\\.[0-9]$")

    content <- "Package: pkgtest\nType: Package"
    writeLines(content, "DESCRIPTION")

    res <- get_project_version()
    expect_null(res)
  })
})

test_that("get_project_version() works - No DESCRIPTION file", {
  with_local_project({
    initialize_project(quiet = TRUE)

    res <- get_project_version()
    expect_null(res)
  })
})
