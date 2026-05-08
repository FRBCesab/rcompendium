## list_template_files() ----

test_that("list_template_files() works", {
  vcr::use_cassette("list_template_files_success_root", {
    res <- list_template_files()
  })

  expect_true(inherits(res, "character"))
  expect_true(length(res) > 0)
  expect_true("LICENSE" %in% res)

  vcr::use_cassette("list_template_files_success_git", {
    res <- list_template_files("git")
  })

  expect_true(inherits(res, "character"))
  expect_true(length(res) > 0)
  expect_true("gitignore" %in% res)
})


test_that("list_template_files() errors", {
  vcr::use_cassette("list_template_files_error", {
    expect_error(
      list_template_files("invalid"),
      regexp = "404",
      fixed = TRUE
    )
  })
})
