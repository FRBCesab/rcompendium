## build_r_profile_path() ----

test_that("build_r_profile_path() works - Use ~/.Rprofile", {
  with_local_project({
    withr::local_envvar(
      list(R_PROFILE_USER = "")
    )

    expect_equal(
      build_r_profile_path(),
      file.path(fs::path_home_r(), ".Rprofile")
    )
  })
})

test_that("build_r_profile_path() works - Use R_PROFILE_USER", {
  with_local_project({
    withr::local_envvar(
      list(R_PROFILE_USER = "/home/user/.Rprofile")
    )

    expect_equal(
      build_r_profile_path(),
      "/home/user/.Rprofile"
    )
  })
})
