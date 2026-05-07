## write_descr() ----

test_that("write_descr() works", {
  with_local_project({
    initialize_project(quiet = TRUE)

    descr <- data.frame(
      Package = "pkgtest",
      Version = "1.0.0"
    )

    expect_invisible(write_descr(descr))

    expect_true(file.exists("DESCRIPTION"))

    content <- readLines("DESCRIPTION")

    expect_equal(content[1], "Package: pkgtest")
    expect_equal(content[2], "Version: 1.0.0")

    raw <- read_descr()

    expect_identical(descr, raw)
  })
})
