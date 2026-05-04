## resolve_project_root() ----

test_that("resolve_project_root() - No project", {
  with_local_project({
    expect_null(resolve_project_root())
  })
})


test_that("resolve_project_root() - In project", {
  with_local_project({
    initialize_project(quiet = TRUE)

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    file.create(".here")

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    create_dummy_desc_file()

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    dir.create(".git")

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    dir.create(".vscode")
    file.create(file.path(".vscode", "settings.json"))

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    content <- "\"Packages\": { }"
    writeLines(content, "renv.lock")

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    content <- "Version: 0.0.0"
    writeLines(content, "pkgtest.Rproj")

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    file.create("_pkgdown.yaml")

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    file.create("_pkgdown.yml")

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    file.create("_quarto.yml")

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    file.create(".projectile")

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    file.create("_targets.R")

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    file.create("remake.yml")

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })

  with_local_project({
    dir.create(".drake")

    expect_equal(resolve_project_root(), normalizePath(getwd()))
  })
})


test_that("resolve_project_root() - In subfolder", {
  with_local_project({
    initialize_project(quiet = TRUE)

    wd <- normalizePath(getwd())
    dir.create("dummy")
    withr::local_dir("dummy")

    expect_equal(resolve_project_root(), wd)
  })

  with_local_project({
    create_dummy_desc_file()

    wd <- normalizePath(getwd())
    dir.create("dummy/dumby", recursive = TRUE)
    withr::local_dir("dummy/dumby")

    expect_equal(resolve_project_root(), wd)
  })
})
