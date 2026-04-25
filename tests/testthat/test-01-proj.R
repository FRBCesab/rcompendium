## PROJECT ---

test_that("Check Project Found", {
  create_temp_compendium()

  expect_equal(get_project_name(), "pkgtest")
})
