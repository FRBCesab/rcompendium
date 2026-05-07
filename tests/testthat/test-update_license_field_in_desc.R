## update_license_field_in_desc() ----

test_that("update_license_field_in_desc() works - MIT", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c(
      "Package: pkgtest",
      "License: GPL (>= 2)"
    )

    writeLines(content, "DESCRIPTION")

    expect_no_message(
      update_license_field_in_desc("MIT", quiet = TRUE)
    )

    output <- readLines("DESCRIPTION")

    expect_true(inherits(output, "character"))
    expect_length(output, 2L)
    expect_equal(output[2], "License: MIT + file LICENSE")
  })
})


test_that("update_license_field_in_desc() works - GPL", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c(
      "Package: pkgtest",
      "License: MIT + file LICENSE"
    )

    writeLines(content, "DESCRIPTION")

    expect_no_message(
      update_license_field_in_desc("GPL (>= 2)", quiet = TRUE)
    )

    output <- readLines("DESCRIPTION")

    expect_true(inherits(output, "character"))
    expect_length(output, 2L)
    expect_equal(output[2], "License: GPL (>= 2)")
  })
})


test_that("update_license_field_in_desc() works - Same licenses", {
  with_local_project({
    initialize_project(quiet = TRUE)

    content <- c(
      "Package: pkgtest",
      "License: MIT + file LICENSE"
    )

    writeLines(content, "DESCRIPTION")

    expect_no_message(
      update_license_field_in_desc("MIT", quiet = TRUE)
    )

    output <- readLines("DESCRIPTION")

    expect_identical(content, output)
  })
})
