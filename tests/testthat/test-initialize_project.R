## initialize_project() ----

test_that("initialize_project() errors - Not empty dir", {
  with_local_project({
    path <- "README.md"
    file.create(path)

    expect_error(
      initialize_project(quiet = TRUE),
      paste0(
        "The path '",
        getwd(),
        "' is not empty and does not appear to be an R project."
      ),
      fixed = TRUE
    )
  })
})

test_that("initialize_project() works - Empty dir", {
  with_local_project({
    expect_no_message(initialize_project(quiet = TRUE))
    expect_true(file.exists(".here"))
  })
})

test_that("initialize_project() works - Is a project", {
  with_local_project({
    file.create(".here")

    expect_no_message(initialize_project(quiet = TRUE))
  })

  with_local_project({
    create_dummy_desc_file()

    expect_no_message(initialize_project(quiet = TRUE))
    expect_false(file.exists(".here"))
  })

  with_local_project({
    dir.create(".git")

    expect_no_message(initialize_project(quiet = TRUE))
    expect_false(file.exists(".here"))
  })

  with_local_project({
    dir.create(".vscode")
    file.create(file.path(".vscode", "settings.json"))

    expect_no_message(initialize_project(quiet = TRUE))
    expect_false(file.exists(".here"))
  })

  with_local_project({
    content <- "\"Packages\": { }"
    writeLines(content, "renv.lock")

    expect_no_message(initialize_project(quiet = TRUE))
    expect_false(file.exists(".here"))
  })

  with_local_project({
    content <- "Version: 0.0.0"
    writeLines(content, "pkgtest.Rproj")

    expect_no_message(initialize_project(quiet = TRUE))
    expect_false(file.exists(".here"))
  })

  with_local_project({
    file.create("_pkgdown.yaml")

    expect_no_message(initialize_project(quiet = TRUE))
    expect_false(file.exists(".here"))
  })

  with_local_project({
    file.create("_pkgdown.yml")

    expect_no_message(initialize_project(quiet = TRUE))
    expect_false(file.exists(".here"))
  })

  with_local_project({
    file.create("_quarto.yml")

    expect_no_message(initialize_project(quiet = TRUE))
    expect_false(file.exists(".here"))
  })

  with_local_project({
    file.create(".projectile")

    expect_no_message(initialize_project(quiet = TRUE))
    expect_false(file.exists(".here"))
  })

  with_local_project({
    file.create("_targets.R")

    expect_no_message(initialize_project(quiet = TRUE))
    expect_false(file.exists(".here"))
  })

  with_local_project({
    file.create("remake.yml")

    expect_no_message(initialize_project(quiet = TRUE))
    expect_false(file.exists(".here"))
  })

  with_local_project({
    dir.create(".drake")

    expect_no_message(initialize_project(quiet = TRUE))
    expect_false(file.exists(".here"))
  })
})
