## get_template_file_url() ----

test_that("get_template_file_url() works", {
  expect_type(get_template_file_url(), "character")
  expect_length(get_template_file_url(), 1L)
  expect_equal(
    get_template_file_url(),
    "https://raw.githubusercontent.com/FRBCesab/r-templates/refs/heads/main/"
  )
})
