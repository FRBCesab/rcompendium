## get_available_issue_templates() ----

test_that("get_available_issue_templates() works", {
  vcr::use_cassette("get_available_issue_templates_success", {
    templates <- get_available_issue_templates()
  })

  expect_true(all(!grepl("\\.md$", templates)))
  expect_true(length(templates) > 0)
  expect_true("bug_report" %in% templates)
})
