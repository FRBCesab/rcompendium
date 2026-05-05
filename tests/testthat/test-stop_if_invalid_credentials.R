## stop_if_invalid_credentials() ----

test_that("stop_if_invalid_credentials() errors", {
  expect_error(
    stop_if_invalid_credentials(list(given = NULL)),
    "The argument 'given' cannot be NULL.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(given = NA_character_)),
    "The argument 'given' cannot be NA.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(given = 12)),
    "The argument 'given' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(given = TRUE)),
    "The argument 'given' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(given = letters)),
    "The argument 'given' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(family = NULL)),
    "The argument 'family' cannot be NULL.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(family = NA_character_)),
    "The argument 'family' cannot be NA.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(family = 12)),
    "The argument 'family' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(family = TRUE)),
    "The argument 'family' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(family = letters)),
    "The argument 'family' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(given = "John", family = letters)),
    "The argument 'family' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(email = NULL)),
    "The argument 'email' cannot be NULL.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(email = NA_character_)),
    "The argument 'email' cannot be NA.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(email = 12)),
    "The argument 'email' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(email = TRUE)),
    "The argument 'email' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(email = letters)),
    "The argument 'email' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(given = "John", email = letters)),
    "The argument 'email' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(orcid = NULL)),
    "The argument 'orcid' cannot be NULL.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(orcid = NA_character_)),
    "The argument 'orcid' cannot be NA.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(orcid = 12)),
    "The argument 'orcid' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(orcid = TRUE)),
    "The argument 'orcid' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(orcid = letters)),
    "The argument 'orcid' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(given = "John", orcid = letters)),
    "The argument 'orcid' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(github_user = NULL)),
    "The argument 'github_user' cannot be NULL.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(github_user = NA_character_)),
    "The argument 'github_user' cannot be NA.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(github_user = 12)),
    "The argument 'github_user' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(github_user = TRUE)),
    "The argument 'github_user' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(github_user = letters)),
    "The argument 'github_user' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(given = "John", github_user = letters)),
    "The argument 'github_user' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(protocol = NA_character_)),
    "The argument 'protocol' cannot be NA.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(protocol = 12)),
    "The argument 'protocol' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(protocol = TRUE)),
    "The argument 'protocol' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(protocol = letters)),
    "The argument 'protocol' must be a character of length 1.",
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_credentials(list(given = "John", protocol = letters)),
    "The argument 'protocol' must be a character of length 1.",
    fixed = TRUE
  )
})

test_that("stop_if_invalid_credentials() works", {
  meta <- list()

  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(given = "John")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(family = "Doe")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(given = "John", family = "Doe")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(email = "john.doe@mail.com")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(email = "john.doe@mail.com", family = "Doe")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(orcid = "0000-0000-0000-0000")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(given = "John", orcid = "0000-0000-0000-0000")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(github_user = "jdoe")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(github_user = "jdoe", family = "Doe")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(protocol = "https")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(protocol = "https", family = "Doe")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(protocol = "ssh")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(protocol = "ssh", family = "Doe")
  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))

  meta <- list(
    given = "John",
    family = "Doe",
    email = "john.doe@mail.com",
    orcid = "0000-0000-0000-0000",
    github_user = "jdoe",
    protocol = "ssh"
  )

  expect_silent(stop_if_invalid_credentials(meta))
  expect_null(x <- stop_if_invalid_credentials(meta))
})
