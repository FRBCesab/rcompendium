## should_init_git() ----

test_that("should_init_git() returns TRUE", {
  with_local_project({
    initialize_project(quiet = TRUE)

    expect_true(should_init_git())
  })
})

test_that("should_init_git() returns FALSE", {
  with_local_project({
    initialize_project(quiet = TRUE)
    dir.create(".git")

    expect_false(should_init_git())
  })
})
