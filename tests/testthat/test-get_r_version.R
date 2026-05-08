## get_r_version() ----

test_that("get_r_version() works", {
  res <- get_r_version()

  expect_type(res, "character")
  expect_length(res, 1L)
  expect_match(res, "^[0-9]+\\.[0-9]+$")

  parts <- strsplit(res, "\\.")[[1]]
  expect_length(parts, 2L)
})
