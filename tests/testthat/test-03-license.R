## LICENSE FILE ----

test_that("Check Inputs", {
  
  # Simulation of no Rprofile...
  withr::local_options(list("given" = NULL, "family" = NULL, "email" = NULL,
                            "orcid" = NULL, "github" = NULL)) 
  
  expect_error(add_license(quiet = TRUE), "No 'DESCRIPTION' file found.")
  
  create_temp_compendium()
  add_description("John", "Doe", "john.doe@gmail.com", "9999-9999-9999-9999", 
                  organisation = "society", open = FALSE, overwrite = FALSE, 
                  quiet = TRUE)
  
  expect_error(add_license(quiet = TRUE))
  expect_error(add_license(license = NA, quiet = TRUE))
  expect_error(add_license(license = numeric(0), quiet = TRUE))
  expect_error(add_license(license = c("MIT", "GPL-2"), quiet = TRUE))
  expect_error(add_license(license = "GPL2", quiet = TRUE))
  expect_error(add_license(license = "GPL 2", quiet = TRUE))
  
  expect_error(add_license(quiet = 0))
  expect_error(add_license(quiet = NULL))
  expect_error(add_license(quiet = "false"))
  
  expect_error(add_license(license = "MIT", quiet = TRUE))
  expect_error(add_license(license = "MIT", "John", quiet = TRUE))
  expect_error(add_license(license = "MIT", "John Doe", quiet = TRUE))
  expect_error(add_license(license = "MIT", c("John", "Doe"), quiet = TRUE))
  expect_error(add_license(license = "MIT", family = "Doe", quiet = TRUE))
  
  expect_invisible(add_license(license = "MIT", "John", "Doe", quiet = TRUE))
})


test_that("Check Credentials", {
  
  withr::local_options(list("given" = "john", "family" = "doe", 
                            "email" = "john.doe@gmail.com",
                            "orcid" = "9999-9999-9999-9999"))
  
  create_temp_compendium()
  add_description(organisation = "society", open = FALSE, overwrite = FALSE, 
                  quiet = TRUE)
  
  expect_invisible(add_license(license = "MIT", quiet = TRUE))
})


test_that("Check Files and Overwrite", {
  
  withr::local_options(list("given" = "john", "family" = "doe", 
                            "email" = "john.doe@gmail.com",
                            "orcid" = "9999-9999-9999-9999"))
  
  create_temp_compendium()
  add_description(organisation = "society", open = FALSE, overwrite = FALSE,
                  quiet = TRUE)
  
  add_license(license = "MIT", quiet = TRUE)
  
  expect_true("LICENSE" %in% list.files(getwd()))
  expect_true("LICENSE.md" %in% list.files(getwd()))
  
  content <- readLines("LICENSE.md")
  expect_length(grep("MIT License", content[1]), n = 1)
  
  
  add_license(license = "GPL-2", quiet = TRUE)
  
  expect_false("LICENSE" %in% list.files(getwd()))
  
  content <- readLines("LICENSE.md")
  expect_length(grep("GNU General Public License", content[1]), n = 1)
})

test_that("Check DESCRIPTION Fields", {
  
  withr::local_options(list("given" = "john", "family" = "doe", 
                            "email" = "john.doe@gmail.com",
                            "orcid" = "9999-9999-9999-9999"))
  
  create_temp_compendium()
  add_description(organisation = "society", open = FALSE, overwrite = FALSE, 
                  quiet = TRUE)
  
  add_license(license = "MIT", quiet = TRUE)
  expect_equal(read_descr()$"License", "MIT + file LICENSE")
  
  add_license(license = "LGPL (>= 3)", quiet = TRUE)
  expect_equal(read_descr()$"License", "LGPL (>= 3)")
})
