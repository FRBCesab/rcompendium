## download_template() ----

test_that("download_template() works", {
  with_local_project({
    initialize_project(quiet = TRUE)

    create_folder_if_needed("inst")
    path <- build_abs_path("inst", "CITATION")

    vcr::use_cassette("download_template_success", {
      download_template("package/CITATION", path)
    })

    expect_true(file.exists(path))

    content <- readLines(path, warn = FALSE)
    expect_gt(length(content), 0L)
  })
})

test_that("download_template() errors", {
  with_local_project({
    initialize_project(quiet = TRUE)

    create_folder_if_needed("inst")
    path <- build_abs_path("inst", "CITATION")

    vcr::use_cassette("download_template_error", {
      expect_error(
        download_template("package/INVALID", path),
        regexp = "404",
        fixed = TRUE
      )
    })

    expect_false(file.exists(path))
  })
})
