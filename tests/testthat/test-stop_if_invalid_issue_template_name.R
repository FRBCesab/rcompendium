## stop_if_invalid_issue_template_name() ----

test_that("stop_if_invalid_issue_template_name() works", {
  vcr::use_cassette("stop_if_invalid_issue_template_name_success", {
    expect_invisible(
      stop_if_invalid_issue_template_name("bug_report")
    )
  })
})


test_that("stop_if_invalid_issue_template_name() errors", {
  vcr::use_cassette("stop_if_invalid_issue_template_name_error", {
    expect_error(
      stop_if_invalid_issue_template_name("invalid_issue"),
      paste0(
        "The issue template 'invalid_issue' is not available. Please run ",
        "`get_available_issue_templates()` to list available Issue Templates."
      ),
      fixed = TRUE
    )
  })
})
