## stop_if_not_project() ---

test_that("stop_if_not_project() errors", {
  with_local_project({
    expect_error(
      stop_if_not_project(),
      paste0(
        "The path '",
        getwd(),
        "' does not appear to be inside a project or package."
      ),
      fixed = TRUE
    )
  })
})

test_that("stop_if_not_project() works", {
  with_local_project({
    file.create(".here")
    expect_silent(stop_if_not_project())
  })

  with_local_project({
    file.create("DESCRIPTION")
    expect_silent(stop_if_not_project())
  })

  with_local_project({
    dir.create(".git")
    expect_silent(stop_if_not_project())
  })

  with_local_project({
    dir.create(".vscode")
    file.create(file.path(".vscode", "settings.json"))
    expect_silent(stop_if_not_project())
  })

  with_local_project({
    file.create("renv.lock")
    expect_silent(stop_if_not_project())
  })

  with_local_project({
    file.create("pkgtest.Rproj")
    expect_silent(stop_if_not_project())
  })
})
