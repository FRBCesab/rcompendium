## get_license_meta() ----

test_that("get_license_meta() works", {
  res <- get_license_meta("MIT")

  expect_true(inherits(res, "list"))

  expect_true("tag" %in% names(res))
  expect_true("url" %in% names(res))
  expect_true("license" %in% names(res))

  expect_true(res$tag == "MIT")
  expect_true(res$license == "mit")
})


test_that("get_license_meta() NULL", {
  expect_null(res <- get_license_meta(NULL))
})
