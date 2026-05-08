## get_available_licenses() ----

test_that("get_available_licenses() works", {
  res <- get_available_licenses()
  expect_s3_class(res, "data.frame")

  expect_true(ncol(res) == 2L)
  expect_true("tag" %in% names(res))
  expect_true("url" %in% names(res))

  expect_true(nrow(res) > 0L)
})
