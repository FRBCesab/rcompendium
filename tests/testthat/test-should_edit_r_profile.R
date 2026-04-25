## should_edit_r_profile() ----

test_that("should_edit_r_profile() works - Return FALSE", {
  expect_false(
    should_edit_r_profile(list())
  )

  expect_false(
    should_edit_r_profile(NULL)
  )
})

test_that("should_edit_r_profile() works - Return TRUE", {
  expect_true(
    should_edit_r_profile(list(given = "John"))
  )
  expect_true(
    should_edit_r_profile(list(given = "John", family = "Doe"))
  )
})
