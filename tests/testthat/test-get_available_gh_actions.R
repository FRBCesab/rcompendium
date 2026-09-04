## get_available_gh_actions() ----

test_that("get_available_gh_actions() works", {
  vcr::use_cassette("get_available_gh_actions_success", {
    templates <- get_available_gh_actions()
  })

  expect_true(!any(grepl("\\.ya?ml$", templates)))
  expect_true(length(templates) > 0)
  expect_true("test-coverage" %in% templates)
  expect_false("dependabot" %in% templates)
})
