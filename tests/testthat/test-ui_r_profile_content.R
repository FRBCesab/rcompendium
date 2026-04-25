## ui_r_profile_content() ----

test_that("ui_r_profile_content() works", {
  with_local_project({
    r_profile <- file.path(getwd(), ".Rprofile")

    withr::local_envvar(
      list(R_PROFILE_USER = r_profile)
    )

    expect_message(
      ui_r_profile_content("This is a message")
    )
  })
})
