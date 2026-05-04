## get_arg_name() ----

test_that("get_arg_name() works - Character", {
  given <- "John"
  expect_equal(get_arg_label(given), "given")

  meta <- list()
  meta$given <- "John"
  expect_equal(get_arg_label(meta$given), "given")
})

test_that("get_arg_name() works - Logical", {
  open <- TRUE
  expect_equal(get_arg_label(open), "open")

  meta <- list()
  meta$open <- TRUE
  expect_equal(get_arg_label(meta$open), "open")
})
