## stop_if_not_string() ----

test_that("stop_if_not_string() errors - Vector", {
  given <- NULL

  expect_error(
    stop_if_not_string(given),
    "The argument 'given' cannot be NULL.",
    fixed = TRUE
  )

  given <- 12

  expect_error(
    stop_if_not_string(given),
    "The argument 'given' must be a character of length 1.",
    fixed = TRUE
  )

  given <- TRUE

  expect_error(
    stop_if_not_string(given),
    "The argument 'given' must be a character of length 1.",
    fixed = TRUE
  )

  given <- c("Marie", "Jeanne")

  expect_error(
    stop_if_not_string(given),
    "The argument 'given' must be a character of length 1.",
    fixed = TRUE
  )

  given <- NA_character_

  expect_error(
    stop_if_not_string(given),
    "The argument 'given' cannot be NA.",
    fixed = TRUE
  )

  given <- ""

  expect_error(
    stop_if_not_string(given),
    "The argument 'given' cannot be empty.",
    fixed = TRUE
  )
})


test_that("stop_if_not_string() errors - List", {
  meta <- list()
  meta$given <- NULL

  expect_error(
    stop_if_not_string(meta$given),
    "The argument 'given' cannot be NULL.",
    fixed = TRUE
  )

  meta <- list()
  meta$given <- 12

  expect_error(
    stop_if_not_string(meta$given),
    "The argument 'given' must be a character of length 1.",
    fixed = TRUE
  )

  meta <- list()
  meta$given <- TRUE

  expect_error(
    stop_if_not_string(meta$given),
    "The argument 'given' must be a character of length 1.",
    fixed = TRUE
  )

  meta <- list()
  meta$given <- c("Marie", "Jeanne")

  expect_error(
    stop_if_not_string(meta$given),
    "The argument 'given' must be a character of length 1.",
    fixed = TRUE
  )

  meta <- list()
  meta$given <- NA_character_

  expect_error(
    stop_if_not_string(meta$given),
    "The argument 'given' cannot be NA.",
    fixed = TRUE
  )

  meta <- list()
  meta$given <- ""

  expect_error(
    stop_if_not_string(meta$given),
    "The argument 'given' cannot be empty.",
    fixed = TRUE
  )
})


test_that("stop_if_not_string() works - Vector", {
  given <- "John"

  expect_silent(stop_if_not_string(given))
})


test_that("stop_if_not_string() works - List", {
  meta <- list()
  meta$given <- "John"

  expect_silent(stop_if_not_string(meta$given))
})
