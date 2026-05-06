## collect_user_meta() ----

test_that("collect_user_meta() works - Global options full", {
  withr::local_options(
    list(
      given = "John",
      family = "Doe",
      email = "john.doe@gmail.com",
      orcid = "9999-9999-9999-9999",
      github_user = "jdoe"
    )
  )

  meta <- collect_user_meta()

  expect_type(meta, "list")
  expect_equal(meta$given, "John")
  expect_equal(meta$family, "Doe")
  expect_equal(meta$email, "john.doe@gmail.com")
  expect_equal(meta$orcid, "9999-9999-9999-9999")
  expect_equal(meta$github_user, "jdoe")
  expect_equal(meta$github_account, "jdoe")
})

test_that("collect_user_meta() works - Global options w/ NULL", {
  withr::local_options(
    list(
      given = "John",
      family = "Doe",
      email = "john.doe@gmail.com",
      orcid = NULL,
      github_user = NULL
    )
  )

  meta <- collect_user_meta()

  expect_type(meta, "list")
  expect_equal(meta$given, "John")
  expect_equal(meta$family, "Doe")
  expect_equal(meta$email, "john.doe@gmail.com")
  expect_null(meta$orcid)
  expect_null(meta$github_user)
  expect_null(meta$github_account)
})

test_that("collect_user_meta() works - With arguments", {
  withr::local_options(
    list(
      given = "John",
      family = "Doe",
      email = "john.doe@gmail.com",
      orcid = NULL,
      github_user = NULL
    )
  )

  meta <- collect_user_meta(
    orcid = "9999-9999-9999-9999",
    github_user = "jdoe"
  )

  expect_type(meta, "list")
  expect_equal(meta$given, "John")
  expect_equal(meta$family, "Doe")
  expect_equal(meta$email, "john.doe@gmail.com")
  expect_equal(meta$orcid, "9999-9999-9999-9999")
  expect_equal(meta$github_user, "jdoe")
  expect_equal(meta$github_account, "jdoe")

  withr::local_options(
    list(
      given = "John",
      family = "Doe",
      email = "john.doe@gmail.com",
      orcid = "9999-9999-9999-9999",
      github_user = "jdoe"
    )
  )

  meta <- collect_user_meta(organisation = "ghorga")

  expect_type(meta, "list")
  expect_equal(meta$given, "John")
  expect_equal(meta$family, "Doe")
  expect_equal(meta$email, "john.doe@gmail.com")
  expect_equal(meta$orcid, "9999-9999-9999-9999")
  expect_equal(meta$github_user, "jdoe")
  expect_equal(meta$github_account, "ghorga")
})
