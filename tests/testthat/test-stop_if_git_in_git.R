## stop_if_git_in_git() ----

test_that("stop_if_git_in_git() works", {
  with_local_project(name = "pkgtest", {
    initialize_project(quiet = TRUE)

    dir.create("project")

    expect_invisible(
      stop_if_git_in_git("project")
    )
  })
})


test_that("stop_if_git_in_git() errors - git in parents", {
  with_local_project(name = "pkgtest", {
    initialize_project(quiet = TRUE)

    dir.create(".git")
    dir.create("project")

    expect_error(
      stop_if_git_in_git("project"),
      regexp = "You are going to create a '.git' inside a folder that is"
    )
  })
})


test_that("stop_if_git_in_git() errors - Linux/macOS Root creation", {
  skip_on_os("windows")

  expect_error(
    stop_if_git_in_git("/"),
    "Creating a '.git' at the system root is forbidden"
  )
})

# test_that("stop_if_git_in_git() errors - Windows Root creation", {
#   skip_on_os(c("linux", "mac"))

#   expect_error(
#     stop_if_git_in_git("C:"),
#     regexp = "Creating a '.git' at the system root is forbidden"
#   )
# })
