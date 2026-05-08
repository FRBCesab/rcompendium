## create_mit_copyright_holder_file() ----

test_that("create_mit_copyright_holder_file() - MIT (new file)", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- "LICENSE"

    meta <- list(given = "John", family = "Doe", year = "2026")

    expect_true(!file.exists(path))

    expect_silent(
      create_mit_copyright_holder_file("MIT", meta, quiet = TRUE)
    )

    expect_true(file.exists(path))

    content <- readLines(path)
    expect_equal(content[1], "YEAR: 2026")
    expect_equal(content[2], "COPYRIGHT HOLDER: John Doe")
  })
})


test_that("create_mit_copyright_holder_file() - MIT (overwrite)", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- "LICENSE"

    original <- c(
      "YEAR: 2026",
      "COPYRIGHT HOLDER: John Doe"
    )

    writeLines(original, path)

    meta <- list(given = "John", family = "Doe", year = "2026")

    expect_silent(
      create_mit_copyright_holder_file("MIT", meta, quiet = TRUE)
    )

    expect_true(file.exists(path))

    content <- readLines(path)
    expect_identical(content, original)
  })

  with_local_project({
    initialize_project(quiet = TRUE)

    path <- "LICENSE"

    original <- c(
      "YEAR: 2025",
      "COPYRIGHT HOLDER: John Doe"
    )

    writeLines(original, path)

    meta <- list(given = "John", family = "Doe", year = "2026")

    expect_silent(
      create_mit_copyright_holder_file("MIT", meta, quiet = TRUE)
    )

    expect_true(file.exists(path))

    content <- readLines(path)
    expect_equal(content[1], "YEAR: 2026")
    expect_equal(content[2], "COPYRIGHT HOLDER: John Doe")
  })
})


test_that("create_mit_copyright_holder_file() - Others licenses", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- "LICENSE"

    original <- c(
      "YEAR: 2026",
      "COPYRIGHT HOLDER: John Doe"
    )

    writeLines(original, path)

    expect_silent(
      create_mit_copyright_holder_file("GPL (>= 2)", list(), quiet = TRUE)
    )

    expect_false(file.exists(path))
  })

  with_local_project({
    initialize_project(quiet = TRUE)

    path <- "LICENSE"

    expect_silent(
      create_mit_copyright_holder_file("GPL (>= 2)", list(), quiet = TRUE)
    )

    expect_false(file.exists(path))
  })
})
