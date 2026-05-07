## stop_if_invalid_issue_template_name() ----

test_that("stop_if_invalid_issue_template_name() works", {
  vcr::use_cassette("stop_if_invalid_issue_template_name_success", {
    expect_invisible(
      stop_if_invalid_issue_template_name("bug_report")
    )

    # Nom invalide
    expect_error(
      stop_if_invalid_issue_template_name("this_template_does_not_exist"),
      "The issue template 'this_template_does_not_exist' is not available"
    )
  })
})


test_that("stop_if_invalid_issue_template_name() errors", {
  vcr::use_cassette("stop_if_invalid_issue_template_name_error", {
    expect_error(
      stop_if_invalid_issue_template_name("invalid_issue"),
      "The issue template 'invalid_issue' is not available"
    )
  })
})
