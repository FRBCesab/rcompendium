## stop_if_invalid_gh_action_name() ----

test_that("stop_if_invalid_gh_action_name() works", {
  vcr::use_cassette("stop_if_invalid_gh_action_name_success", {
    expect_invisible(
      stop_if_invalid_gh_action_name("test-coverage")
    )
  })
})


test_that("stop_if_invalid_gh_action_name() errors", {
  vcr::use_cassette("stop_if_invalid_gh_action_name_error", {
    expect_error(
      stop_if_invalid_gh_action_name("invalid_action"),
      paste0(
        "The action 'invalid_action' is not available. Please run ",
        "`get_available_gh_actions()` to list available GitHub Actions."
      ),
      fixed = TRUE
    )
  })
})
