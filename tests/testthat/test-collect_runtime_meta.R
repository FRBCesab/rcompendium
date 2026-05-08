## collect_runtime_meta() ----

test_that("collect_runtime_meta() renvoie les versions et dates", {
  meta <- collect_runtime_meta()

  expect_type(meta, "list")
  expect_true("r_version" %in% names(meta))
  expect_true("roxygen2_version" %in% names(meta))
  expect_true("renv_version" %in% names(meta))
  expect_true("year" %in% names(meta))
  expect_true("date" %in% names(meta))

  expect_match(meta$year, "^\\d{4}$")
  parts <- strsplit(meta$date, "[[:punct:]]")[[1]]
  expect_length(parts, 3L)

  expect_type(meta$r_version, "character")
  expect_length(meta$r_version, 1L)
  expect_match(meta$r_version, "^[0-9]+\\.[0-9]+$")

  parts <- strsplit(meta$r_version, "\\.")[[1]]
  expect_length(parts, 2L)
})
