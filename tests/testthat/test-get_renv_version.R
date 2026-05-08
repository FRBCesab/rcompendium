## get_renv_version() ----

test_that("get_renv_version() works", {
  skip_if_not_installed("renv")

  expected <- as.character(utils::packageVersion("renv"))

  res <- get_renv_version()
  expect_type(res, "character")
  expect_length(res, 1L)
  expect_match(res, "^[0-9]+\\.[0-9]+(\\.[0-9]+)?")
  expect_equal(res, expected)
})


test_that("get_renv_version() errors", {
  local_mocked_bindings(
    is_pkg_installed = function(...) FALSE
  )

  expect_null(get_renv_version())
})
