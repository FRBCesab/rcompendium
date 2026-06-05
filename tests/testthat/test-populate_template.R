## populate_template() ----

test_that("populate_template() works - no metadata", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path("LICENSE")

    content <- c("YEAR: {{year}}", "COPYRIGHT HOLDER: {{given}} {{family}}")
    writeLines(text = content, con = path)

    meta <- list()

    x <- expect_silent(populate_template(path, meta))
    expect_null(x)

    output <- readLines(path)

    expect_equal(output[1], "YEAR: {{year}}")
    expect_equal(output[2], "COPYRIGHT HOLDER: {{given}} {{family}}")
  })
})

test_that("populate_template() works - unused metadata", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path("LICENSE")

    content <- c("YEAR: {{year}}", "COPYRIGHT HOLDER: {{given}} {{family}}")
    writeLines(text = content, con = path)

    meta <- list(orcid = "0000-0000-0000-0000", github_user = "jdoe")

    x <- expect_silent(populate_template(path, meta))
    expect_null(x)

    output <- readLines(path)

    expect_equal(output[1], "YEAR: {{year}}")
    expect_equal(output[2], "COPYRIGHT HOLDER: {{given}} {{family}}")
  })
})

test_that("populate_template() works - one used metadata", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path("LICENSE")

    content <- c("YEAR: {{year}}", "COPYRIGHT HOLDER: {{given}} {{family}}")
    writeLines(text = content, con = path)

    meta <- list(given = "John", github_user = "jdoe")

    x <- expect_silent(populate_template(path, meta))
    expect_null(x)

    output <- readLines(path)

    expect_equal(output[1], "YEAR: {{year}}")
    expect_equal(output[2], "COPYRIGHT HOLDER: John {{family}}")
  })
})

test_that("populate_template() works - one used metadata & one is NULL", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path("LICENSE")

    content <- c("YEAR: {{year}}", "COPYRIGHT HOLDER: {{given}} {{family}}")
    writeLines(text = content, con = path)

    meta <- list(given = "John", family = NULL, github_user = "jdoe")

    x <- expect_silent(populate_template(path, meta))
    expect_null(x)

    output <- readLines(path)

    expect_equal(output[1], "YEAR: {{year}}")
    expect_equal(output[2], "COPYRIGHT HOLDER: John {{family}}")
  })
})

test_that("populate_template() works - many used metadata", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path("LICENSE")

    content <- c("YEAR: {{year}}", "COPYRIGHT HOLDER: {{given}} {{family}}")
    writeLines(text = content, con = path)

    meta <- list(
      given = "John",
      family = "Doe",
      year = "2026",
      github_user = "jdoe"
    )

    x <- expect_silent(populate_template(path, meta))
    expect_null(x)

    output <- readLines(path)

    expect_equal(output[1], "YEAR: 2026")
    expect_equal(output[2], "COPYRIGHT HOLDER: John Doe")
  })
})
