## stop_if_invalid_project_type() ----

test_that("stop_if_invalid_project_type() errors", {
  expect_error(
    stop_if_invalid_project_type("website"),
    "Argument 'type' must be one of 'package', 'compendium'.",
    fixed = TRUE
  )
})

test_that("stop_if_invalid_project_type() works", {
  expect_invisible(
    stop_if_invalid_project_type("package")
  )
  expect_invisible(
    stop_if_invalid_project_type("compendium")
  )
})
