## create_r_profile_if_needed() ----

test_that("create_r_profile_if_needed() works - .Rprofile is missing", {
  with_local_project({
    r_profile <- file.path(getwd(), ".Rprofile")

    withr::local_envvar(
      list(R_PROFILE_USER = r_profile)
    )

    output <- create_r_profile_if_needed()

    expect_equal(output, r_profile)
    expect_true(file.exists(r_profile))
  })
})

test_that("create_r_profile_if_needed() works - .Rprofile exists", {
  with_local_project({
    r_profile <- file.path(getwd(), ".Rprofile")

    withr::local_envvar(
      list(R_PROFILE_USER = r_profile)
    )

    invisible(file.create(r_profile))

    output <- create_r_profile_if_needed()

    expect_equal(output, r_profile)
    expect_true(file.exists(r_profile))
  })
})
