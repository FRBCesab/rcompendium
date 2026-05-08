## create_template() ----

test_that("create_template() works", {
  with_local_project({
    initialize_project(quiet = TRUE)

    create_folder_if_needed("inst")
    path <- build_abs_path("inst", "CITATION")

    meta <- list(project_name = get_project_name())

    vcr::use_cassette("create_template_success", {
      create_template("package/CITATION", path, meta)
    })

    expect_true(file.exists(path))

    content <- readLines(path, warn = FALSE)
    expect_gt(length(content), 0L)

    expect_true(any(grepl("\\bpkgtest\\b", content)))
    expect_false(any(grepl("\\{\\{project_name\\}\\}", content)))
  })
})
