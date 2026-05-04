## stop_if_not_project() ---

test_that("stop_if_not_project() errors", {
  with_local_project({
    expect_error(
      stop_if_not_project(),
      paste0(
        "Cannot determine project root. ",
        "Make sure you are inside an R project or a directory containing ",
        "a '.here' file."
      ),
      fixed = TRUE
    )
  })
})

test_that("stop_if_not_project() works", {
  with_local_project({
    initialize_project(quiet = TRUE)

    expect_silent(stop_if_not_project())
  })

  with_local_project({
    file.create(".here")

    expect_silent(stop_if_not_project())
  })

  with_local_project({
    create_dummy_desc_file()

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
    content <- "\"Packages\": { }"
    writeLines(content, "renv.lock")

    expect_silent(stop_if_not_project())
  })

  with_local_project({
    content <- "Version: 0.0.0"
    writeLines(content, "pkgtest.Rproj")

    expect_silent(stop_if_not_project())
  })

  with_local_project({
    file.create("_pkgdown.yaml")

    expect_silent(stop_if_not_project())
  })

  with_local_project({
    file.create("_pkgdown.yml")

    expect_silent(stop_if_not_project())
  })

  with_local_project({
    file.create("_quarto.yml")

    expect_silent(stop_if_not_project())
  })

  with_local_project({
    file.create(".projectile")

    expect_silent(stop_if_not_project())
  })

  with_local_project({
    file.create("_targets.R")

    expect_silent(stop_if_not_project())
  })

  with_local_project({
    file.create("remake.yml")

    expect_silent(stop_if_not_project())
  })

  with_local_project({
    dir.create(".drake")

    expect_silent(stop_if_not_project())
  })
})
