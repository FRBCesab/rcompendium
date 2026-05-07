## get_template_repo_url() ----

test_that("get_template_repo_url() works", {
  expect_type(get_template_repo_url(), "character")
  expect_length(get_template_repo_url(), 1L)
  expect_equal(
    get_template_repo_url(),
    "/repos/frbcesab/r-templates/contents/"
  )
})
