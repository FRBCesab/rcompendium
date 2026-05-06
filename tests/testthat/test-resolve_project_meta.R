## resolve_project_meta() ----

test_that("resolve_project_meta() errors", {
  expect_error(
    resolve_project_meta(include = NA),
    "Argument 'include' cannot contain NA values.",
    fixed = TRUE
  )

  expect_error(
    resolve_project_meta(include = c("user", NA)),
    "Argument 'include' cannot contain NA values.",
    fixed = TRUE
  )

  expect_error(
    resolve_project_meta(include = "invalid_block"),
    paste0(
      "Invalid 'include' value(s): 'invalid_block'. Valid values are 'user', ",
      "'project', 'git', 'runtime'."
    ),
    fixed = TRUE
  )

  expect_error(
    resolve_project_meta(include = c("user", "invalid_block")),
    paste0(
      "Invalid 'include' value(s): 'invalid_block'. Valid values are 'user', ",
      "'project', 'git', 'runtime'."
    ),
    fixed = TRUE
  )
})


test_that("resolve_project_meta() works", {
  meta <- resolve_project_meta()

  expect_type(meta, "list")
  expect_true("given" %in% names(meta))
  expect_true("project_name" %in% names(meta))
  expect_true("git_branch" %in% names(meta))
  expect_true("r_version" %in% names(meta))

  meta <- resolve_project_meta(include = "git")

  expect_type(meta, "list")
  expect_true("git_branch" %in% names(meta))
  expect_false("given" %in% names(meta))
  expect_false("project_name" %in% names(meta))
  expect_false("r_version" %in% names(meta))

  meta <- resolve_project_meta(include = c("user", "git"))

  expect_type(meta, "list")
  expect_true("given" %in% names(meta))
  expect_true("git_branch" %in% names(meta))
  expect_false("project_name" %in% names(meta))
  expect_false("r_version" %in% names(meta))

  meta <- resolve_project_meta(include = NULL)

  expect_type(meta, "list")
  expect_length(meta, 0L)
  expect_false("given" %in% names(meta))
  expect_false("git_branch" %in% names(meta))
  expect_false("project_name" %in% names(meta))
  expect_false("r_version" %in% names(meta))
})
