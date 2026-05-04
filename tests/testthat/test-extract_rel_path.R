## extract_rel_path() ----

test_that("extract_rel_path() - No project", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path()
    expect_equal(extract_rel_path(path), "")

    path <- build_abs_path("DESCRIPTION")
    expect_equal(extract_rel_path(path), "DESCRIPTION")

    path <- build_abs_path("inst", "CITATION")
    expect_equal(extract_rel_path(path), file.path("inst", "CITATION"))
  })
})
