## ui_success() ----

test_that("ui_success() works - No quiet", {
  texte <- "This is a success!"

  expect_snapshot({
    ui_success(texte, quiet = FALSE)
  })
})

test_that("ui_success() works - Quiet", {
  texte <- "This is a success!"

  expect_no_message({
    ui_success(texte, quiet = TRUE)
  })
})
