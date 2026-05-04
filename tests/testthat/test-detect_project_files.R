## detect_project_files() ----

test_that("detect_project_files() works - Not a project", {
  with_local_project({
    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(!all(y))
  })
})

test_that("detect_project_files() works - Is a project", {
  with_local_project({
    file.create(".here")

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })

  with_local_project({
    create_dummy_desc_file()

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })

  with_local_project({
    dir.create(".git")

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })

  with_local_project({
    dir.create(".vscode")
    file.create(file.path(".vscode", "settings.json"))

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })

  with_local_project({
    content <- "\"Packages\": { }"
    writeLines(content, "renv.lock")

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })

  with_local_project({
    content <- "Version: 0.0.0"
    writeLines(content, "pkgtest.Rproj")

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })

  with_local_project({
    file.create("_pkgdown.yaml")

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })

  with_local_project({
    file.create("_pkgdown.yml")

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })

  with_local_project({
    file.create("_quarto.yml")

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })

  with_local_project({
    file.create(".projectile")

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })

  with_local_project({
    file.create("_targets.R")

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })

  with_local_project({
    file.create("remake.yml")

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })

  with_local_project({
    dir.create(".drake")

    x <- detect_project_files()
    y <- unlist(lapply(x$testfun, function(z) z(".")))

    expect_true(inherits(x, "root_criterion"))
    expect_true(any(y))
  })
})
