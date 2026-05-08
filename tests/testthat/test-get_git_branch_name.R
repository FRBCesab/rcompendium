## get_git_branch_name() ----

test_that("get_git_branch_name() - No git", {
  with_local_project({
    initialize_project(quiet = TRUE)

    expect_null(get_git_branch_name())
  })
})

test_that("get_git_branch_name() - git & branch init", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(".git")

    local_mocked_bindings(
      git_branch = function() "main"
    )

    expect_equal(get_git_branch_name(), "main")
  })
})


test_that("get_git_branch_name() - git global config", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(".git")

    local_mocked_bindings(
      git_branch = function() NULL,
      git_config_global = function() {
        data.frame(
          name = "init.defaultbranch",
          value = "main",
          level = "global"
        )
      }
    )

    expect_equal(get_git_branch_name(), "main")
  })
})


test_that("get_git_branch_name() - git system config", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(".git")

    local_mocked_bindings(
      git_branch = function() NULL,
      git_config_global = function() {
        data.frame(
          name = "init.defaultbranch",
          value = "main",
          level = "system"
        )
      }
    )

    expect_equal(get_git_branch_name(), "main")
  })
})


test_that("get_git_branch_name() - default value", {
  with_local_project({
    initialize_project(quiet = TRUE)

    dir.create(".git")

    local_mocked_bindings(
      git_branch = function() NULL,
      git_config_global = function() {
        data.frame()
      }
    )

    expect_equal(get_git_branch_name(), "master")
  })
})
