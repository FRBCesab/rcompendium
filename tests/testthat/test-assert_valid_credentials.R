## assert_valid_credentials() ----

test_that("assert_valid_credentials() errors", {
  expect_error(
    assert_valid_credentials(list(given = 12)),
    "Argument 'given' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(given = TRUE)),
    "Argument 'given' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(given = letters)),
    "Argument 'given' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(family = 12)),
    "Argument 'family' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(family = TRUE)),
    "Argument 'family' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(family = letters)),
    "Argument 'family' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(given = "John", family = letters)),
    "Argument 'family' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(email = 12)),
    "Argument 'email' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(email = TRUE)),
    "Argument 'email' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(email = letters)),
    "Argument 'email' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(given = "John", email = letters)),
    "Argument 'email' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(orcid = 12)),
    "Argument 'orcid' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(orcid = TRUE)),
    "Argument 'orcid' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(orcid = letters)),
    "Argument 'orcid' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(given = "John", orcid = letters)),
    "Argument 'orcid' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(github_user = 12)),
    "Argument 'github_user' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(github_user = TRUE)),
    "Argument 'github_user' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(github_user = letters)),
    "Argument 'github_user' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(given = "John", github_user = letters)),
    "Argument 'github_user' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(protocol = 12)),
    "Argument 'protocol' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(protocol = TRUE)),
    "Argument 'protocol' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(protocol = letters)),
    "Argument 'protocol' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    assert_valid_credentials(list(given = "John", protocol = letters)),
    "Argument 'protocol' must be a character of length 1.",
    fixed = TRUE
  )
})

test_that("assert_valid_credentials() works", {
  meta <- list()

  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(given = "John")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(family = "Doe")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(given = "John", family = "Doe")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(email = "john.doe@mail.com")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(email = "john.doe@mail.com", family = "Doe")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(orcid = "0000-0000-0000-0000")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(given = "John", orcid = "0000-0000-0000-0000")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(github_user = "jdoe")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(github_user = "jdoe", family = "Doe")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(protocol = "https")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(protocol = "https", family = "Doe")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(protocol = "ssh")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(protocol = "ssh", family = "Doe")
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))

  meta <- list(
    given = "John",
    family = "Doe",
    email = "john.doe@mail.com",
    orcid = "0000-0000-0000-0000",
    github_user = "jdoe",
    protocol = "ssh"
  )
  
  expect_silent(assert_valid_credentials(meta))
  expect_null(x <- assert_valid_credentials(meta))
})
