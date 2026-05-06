## collect_git_meta() ----

test_that("collect_git_meta() works", {
  meta <- collect_git_meta()

  expect_type(meta, "list")
  expect_true("git_branch" %in% names(meta))
  expect_true("git_available" %in% names(meta))
  expect_true(is.logical(meta$git_available))
  expect_true(is.character(meta$git_branch) || is.null(meta$git_branch))
})

test_that("collect_git_meta() works - Mock", {
  local_mocked_bindings(
    get_git_branch_name = function() "main"
  )

  meta <- collect_git_meta()
  expect_equal(meta$git_branch, "main")
  expect_true(meta$git_available)

  local_mocked_bindings(
    get_git_branch_name = function() NULL
  )
  meta <- collect_git_meta()
  expect_null(meta$git_branch)
  expect_false(meta$git_available)
})
