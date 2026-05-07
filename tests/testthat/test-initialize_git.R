## initialize_git() ----

test_that("initialize_git() - Create .git", {
  with_local_project({
    initialize_project(quiet = TRUE)

    expect_false(dir.exists(".git"))

    expect_snapshot(initialize_git())
    expect_true(dir.exists(".git"))
  })
})


test_that("initialize_git() - Do not create .git", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(".git")
    expect_true(dir.exists(".git"))

    expect_no_message(initialize_git())
    expect_true(dir.exists(".git"))
  })
})
