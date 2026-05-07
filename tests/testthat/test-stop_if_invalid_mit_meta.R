## stop_if_invalid_mit_meta() ----

test_that("stop_if_invalid_mit_meta() errors", {
  meta <- list(given = NULL)

  expect_error(
    stop_if_invalid_mit_meta("MIT", meta),
    paste0(
      "Given name of the coypright holder is mandatory with the ",
      "license MIT. Please use the argument `given` or the function ",
      "`set_credentials()`."
    ),
    fixed = TRUE
  )

  meta <- list(given = "John", family = NULL)

  expect_error(
    stop_if_invalid_mit_meta("MIT", meta),
    paste0(
      "Family name of the coypright holder is mandatory with the ",
      "license MIT. Please use the argument `family` or the function ",
      "`set_credentials()`."
    ),
    fixed = TRUE
  )

  meta <- list(given = 12, family = "Doe")

  expect_error(
    stop_if_invalid_mit_meta("MIT", meta),
    paste0(
      "The argument 'given' must be a character of length 1."
    ),
    fixed = TRUE
  )

  meta <- list(given = "John", family = 12)

  expect_error(
    stop_if_invalid_mit_meta("MIT", meta),
    paste0(
      "The argument 'family' must be a character of length 1."
    ),
    fixed = TRUE
  )
})


test_that("stop_if_invalid_mit_meta() works", {
  expect_silent(
    stop_if_invalid_mit_meta("GPL (>= 2)", list())
  )

  meta <- list(given = "John", family = "Doe")

  expect_silent(
    stop_if_invalid_mit_meta("MIT", meta)
  )
})
