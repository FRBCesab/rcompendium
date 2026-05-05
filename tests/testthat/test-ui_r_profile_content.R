## ui_r_profile_content() ----

test_that("ui_r_profile_content() works - No quiet", {
  with_local_project({
    r_profile <- file.path(".Rprofile")

    withr::local_envvar(
      list(R_PROFILE_USER = r_profile)
    )

    expect_snapshot({
      ui_r_profile_content("This is a message")
    })
  })
})
