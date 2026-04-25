## create_r_profile_content() ----

test_that("create_r_profile_content() works", {
  meta <- list(given = "John", family = "Doe")

  output <- create_r_profile_content(meta)

  expect_true(inherits(output, "character"))
  expect_equal(length(output), 2L)

  expect_equal(
    output[1],
    "## rcompendium credentials ----",
    fixed = TRUE
  )

  expect_equal(
    output[2],
    "options(\n  given = \"John\", \n  family = \"Doe\"\n)",
    fixed = TRUE
  )
})
