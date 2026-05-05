## ui_title() ----

test_that("ui_title() works - No quiet", {
  with_local_project({
    initialize_project(quiet = TRUE)

    texte <- "Initialize project"

    expect_snapshot({
      ui_title(texte, quiet = FALSE)
    })
  })
})

test_that("ui_title() works - Quiet", {
  with_local_project({
    initialize_project(quiet = TRUE)

    texte <- "Initialize project"

    expect_no_message({
      ui_title(texte, quiet = TRUE)
    })

    expect_silent({
      ui_title(texte, quiet = TRUE)
    })
  })
})
