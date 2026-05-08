## open_file_if_needed() ----

test_that("open_file_if_needed() works - No open", {
  with_local_project({
    initialize_project(quiet = TRUE)
    create_dummy_desc_file()

    expect_invisible(open_file_if_needed("DESCRIPTION", FALSE))
  })
})
