## set_default_git_protocol() ----

test_that("set_default_git_protocol() works - Protocol set to https", {
  output <- set_default_git_protocol(list(protocol = "https"))

  expect_true(inherits(output, "list"))
  expect_true("usethis.protocol" %in% names(output))
  expect_equal(length(output), 1L)
  expect_equal(output[["usethis.protocol"]], "https")
})

test_that("set_default_git_protocol() works - Protocol is missing", {
  output <- set_default_git_protocol(list(given = "John"))

  expect_true(inherits(output, "list"))
  expect_true("usethis.protocol" %in% names(output))
  expect_equal(length(output), 2L)
  expect_equal(output[["usethis.protocol"]], "https")
})

test_that("set_default_git_protocol() works - Protocol set to ssh", {
  output <- set_default_git_protocol(list(protocol = "ssh"))

  expect_true(inherits(output, "list"))
  expect_true("usethis.protocol" %in% names(output))
  expect_equal(length(output), 1L)
  expect_equal(output[["usethis.protocol"]], "ssh")
})
