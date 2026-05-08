## stop_if_invalid_license_name() ----

test_that("stop_if_invalid_license_name() errors", {
  expect_error(
    stop_if_invalid_license_name("invalid_license"),
    paste0(
      "Invalid license. Please use `get_available_licenses()` to select an ",
      "appropriate one."
    ),
    fixed = TRUE
  )

  expect_error(
    stop_if_invalid_license_name("mit"),
    paste0(
      "Invalid license. Please use `get_available_licenses()` to select an ",
      "appropriate one."
    ),
    fixed = TRUE
  )
})


test_that("stop_if_invalid_license_name() works", {
  expect_silent(
    stop_if_invalid_license_name("MIT")
  )

  expect_silent(
    stop_if_invalid_license_name("GPL (>= 2)")
  )
})
