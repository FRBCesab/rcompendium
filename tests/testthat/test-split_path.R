## split_path() ----

test_that("split_path() works - Linux/macOS absolute path", {
  skip_on_os("windows")

  path <- "/home/jdoe/pkgtest"
  expect_equal(split_path(path), c("/", "home", "jdoe", "pkgtest"))
})


test_that("split_path() works - Windows absolute path", {
  skip_on_os(c("linux", "mac"))

  path <- "C:/Users/jdoe/pkgtest"
  expect_equal(split_path(path), c("C:/", "Users", "jdoe", "pkgtest"))
})


test_that("split_path() works - Linux/macOS root path", {
  skip_on_os("windows")
  expect_equal(split_path("/"), "/")
})


# test_that("split_path() works - Windows root path", {
#   skip_on_os(c("linux", "mac"))
#   expect_equal(split_path("C:"), "C:")
# })

test_that("split_path() works - Relative paths", {
  path <- "folder/subfolder/file"
  result <- split_path(path)
  expect_true(length(result) >= 1)
  expect_equal(result[length(result)], "file")
})
