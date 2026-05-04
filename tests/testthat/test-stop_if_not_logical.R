## stop_if_not_logical() ----

test_that("stop_if_not_logical() errors - Vector", {
  quiet <- NULL

  expect_error(
    stop_if_not_logical(quiet),
    "The argument 'quiet' cannot be NULL.",
    fixed = TRUE
  )

  quiet <- "string"

  expect_error(
    stop_if_not_logical(quiet),
    "The argument 'quiet' must be a logical of length 1.",
    fixed = TRUE
  )

  quiet <- c(TRUE, TRUE)

  expect_error(
    stop_if_not_logical(quiet),
    "The argument 'quiet' must be a logical of length 1.",
    fixed = TRUE
  )

  quiet <- NA

  expect_error(
    stop_if_not_logical(quiet),
    "The argument 'quiet' cannot be NA.",
    fixed = TRUE
  )
})

test_that("stop_if_not_logical() errors - Vector", {
  meta <- list()
  meta$quiet <- NULL

  expect_error(
    stop_if_not_logical(meta$quiet),
    "The argument 'quiet' cannot be NULL.",
    fixed = TRUE
  )

  meta <- list()
  meta$quiet <- "string"

  expect_error(
    stop_if_not_logical(meta$quiet),
    "The argument 'quiet' must be a logical of length 1.",
    fixed = TRUE
  )

  meta <- list()
  meta$quiet <- c(TRUE, TRUE)

  expect_error(
    stop_if_not_logical(meta$quiet),
    "The argument 'quiet' must be a logical of length 1.",
    fixed = TRUE
  )

  meta <- list()
  meta$quiet <- NA

  expect_error(
    stop_if_not_logical(meta$quiet),
    "The argument 'quiet' cannot be NA.",
    fixed = TRUE
  )
})


test_that("stop_if_not_logical() works - Vector", {
  quiet <- TRUE
  expect_silent(stop_if_not_logical(quiet))

  quiet <- FALSE
  expect_silent(stop_if_not_logical(quiet))
})

test_that("stop_if_not_logical() works - List", {
  meta <- list()
  meta$quiet <- TRUE
  expect_silent(stop_if_not_logical(meta$quiet))

  meta <- list()
  meta$quiet <- FALSE
  expect_silent(stop_if_not_logical(meta$quiet))
})
