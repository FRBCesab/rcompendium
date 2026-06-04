## stop_if_invalid_git_protocol() ----

test_that("stop_if_invalid_git_protocol() errors", {
  expect_error(
    stop_if_invalid_git_protocol(list(protocol = "ftp")),
    "Argument 'protocol' must be equal to 'https' or 'ssh'",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_git_protocol(list(protocol = "SSH")),
    "Argument 'protocol' must be equal to 'https' or 'ssh'",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_git_protocol(list(protocol = "")),
    "Argument 'protocol' must be equal to 'https' or 'ssh'",
    fixed = TRUE
  )
})

test_that("stop_if_invalid_git_protocol() works", {
  expect_silent(stop_if_invalid_git_protocol(list(protocol = "https")))
  expect_silent(stop_if_invalid_git_protocol(list(protocol = "ssh")))
  x <- stop_if_invalid_git_protocol(list(protocol = "ssh"))
  expect_null(x)
})
