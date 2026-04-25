## assert_valid_git_protocol() ----

test_that("assert_valid_git_protocol() errors", {
  expect_error(
    assert_valid_git_protocol(list(protocol = "ftp")),
    "Argument 'protocol' must be equal to 'https' or 'ssh'",
    fixed = TRUE
  )

  expect_error(
    assert_valid_git_protocol(list(protocol = "SSH")),
    "Argument 'protocol' must be equal to 'https' or 'ssh'",
    fixed = TRUE
  )

  expect_error(
    assert_valid_git_protocol(list(protocol = "")),
    "Argument 'protocol' must be equal to 'https' or 'ssh'",
    fixed = TRUE
  )
})

test_that("assert_valid_git_protocol() works", {
  expect_silent(assert_valid_git_protocol(list(protocol = "https")))
  expect_silent(assert_valid_git_protocol(list(protocol = "ssh")))
  expect_null(x <- assert_valid_git_protocol(list(protocol = "ssh")))
})
