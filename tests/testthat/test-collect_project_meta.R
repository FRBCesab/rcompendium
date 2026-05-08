## collect_project_meta() ----

test_that("collect_project_meta() works - No DESCRIPTION file", {
  with_local_project({
    initialize_project(quiet = TRUE)

    meta <- collect_project_meta()

    expect_type(meta, "list")
    expect_equal(meta$project_name, "pkgtest")
    expect_null(meta$project_version)
    expect_null(meta$license)
    expect_null(meta$license_url)
  })
})

test_that("collect_project_meta() works - With DESCRIPTION", {
  with_local_project({
    initialize_project(quiet = TRUE)
    create_dummy_desc_file()

    meta <- collect_project_meta()

    expect_type(meta, "list")
    expect_equal(meta$project_name, "pkgtest")
    expect_equal(meta$project_version, "1.2.3")
    expect_equal(meta$license, "GPL (>= 2)")
    expect_equal(
      meta$license_url,
      "https://choosealicense.com/licenses/gpl-2.0/"
    )
  })
})

test_that("collect_project_meta() works - With DESCRIPTION incomplete", {
  with_local_project({
    initialize_project(quiet = TRUE)
    content <- c("Package: pkgtest", "Type: Package", "License: GPL (>= 2)")

    writeLines(content, "DESCRIPTION")

    meta <- collect_project_meta()

    expect_type(meta, "list")
    expect_equal(meta$project_name, "pkgtest")
    expect_null(meta$project_version)
    expect_equal(meta$license, "GPL (>= 2)")
    expect_equal(
      meta$license_url,
      "https://choosealicense.com/licenses/gpl-2.0/"
    )
  })
})
