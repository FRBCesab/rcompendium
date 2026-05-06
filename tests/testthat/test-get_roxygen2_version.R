## get_roxygen2_version() ----

test_that("get_roxygen2_version() works", {
  skip_if_not_installed("roxygen2")

  expected <- as.character(utils::packageVersion("roxygen2"))

  res <- get_roxygen2_version()
  expect_type(res, "character")
  expect_length(res, 1L)
  expect_match(res, "^[0-9]+\\.[0-9]+(\\.[0-9]+)?")
  expect_equal(res, expected)
})
