## gsub_in_file() ----

test_that("gsub_in_file() works - One occurrence", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c("Package: {{project_name}}", "License: {{license}}")
    path <- build_abs_path("DESCRIPTION")
    writeLines(content, path)

    gsub_in_file(path, "{{project_name}}", "pkgtest")

    raw <- readLines(path, warn = FALSE)

    expect_equal(raw[1], "Package: pkgtest")
    expect_false(any(grepl("\\{\\{project_name\\}\\}", raw)))

    gsub_in_file(path, "{{license}}", "GPL (>= 2)")

    raw <- readLines(path, warn = FALSE)

    expect_equal(raw[2], "License: GPL (>= 2)")
    expect_false(any(grepl("\\{\\{license\\}\\}", raw)))
  })
})


test_that("gsub_in_file() works - Many occurrences", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c("Package: {{project_name}}", "Package: {{project_name}}")
    path <- build_abs_path("DESCRIPTION")
    writeLines(content, path)

    gsub_in_file(path, "{{project_name}}", "pkgtest")

    raw <- readLines(path, warn = FALSE)

    expect_equal(raw[1], "Package: pkgtest")
    expect_equal(raw[2], "Package: pkgtest")
    expect_false(any(grepl("\\{\\{project_name\\}\\}", raw)))
  })
})


test_that("gsub_in_file() works - No match", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c("Package: {{project_name}}", "License: {{license}}")
    path <- build_abs_path("DESCRIPTION")
    writeLines(content, path)

    gsub_in_file(path, "{{version}}", "0.0.0")

    raw <- readLines(path, warn = FALSE)

    expect_identical(content, raw)
  })
})


test_that("gsub_in_file() works - Empty file", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- build_abs_path("DESCRIPTION")
    file.create(path)

    expect_invisible(
      gsub_in_file(path, "{{project_name}}", "pkgtest")
    )

    raw <- readLines(path, warn = FALSE)

    expect_equal(raw, character(0))
  })
})


test_that("gsub_in_file() errors - No file", {
  with_local_project({
    initialize_project(quiet = TRUE)

    path <- "DESCRIPTION"

    expect_error(
      gsub_in_file(path, "{{project_name}}", "pkgtest"),
      "The file 'DESCRIPTION' does not exist",
      fixed = TRUE
    )
  })
})


test_that("gsub_in_file() errors - No readable file", {
  skip_on_os("windows")

  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c("Package: {{project_name}}", "License: {{license}}")
    path <- "DESCRIPTION"
    writeLines(content, path)

    Sys.chmod(path, mode = "0000")

    expect_error(
      gsub_in_file(path, "{{project_name}}", "pkgtest"),
      "Cannot read the 'DESCRIPTION' file",
      fixed = TRUE
    )
  })
})


test_that("gsub_in_file() errors - No writable file", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c("Package: {{project_name}}", "License: {{license}}")
    path <- "DESCRIPTION"
    writeLines(content, path)

    Sys.chmod(path, mode = "0444")

    expect_error(
      gsub_in_file(path, "{{project_name}}", "pkgtest"),
      "Cannot write the 'DESCRIPTION' file",
      fixed = TRUE
    )
  })
})
