## Test demo ----

test_that("Test demo", {
  expect_invisible(print_msg())
  
  x <- print_msg()
  expect_equal(x, "Hello world")
  
  x <- print_msg("Bonjour le monde")
  expect_equal(x, "Bonjour le monde")
  
  expect_error(print_msg(c("Hello", "world")))
  expect_error(print_msg(1), "Argument 'x' must be a character of length 1.")
})
