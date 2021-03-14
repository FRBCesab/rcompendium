## DESCRIPTION FILE ----

#' @note Need to use GitHub organization to test functions on GH servers.

test_that("Check Inputs", {
  
  
  ## Init temporary folder ----
  
  create_temp_compendium()
  
  
  ## Check logical ----
  
  expect_error(add_description(open = 0))
  expect_error(add_description(quiet = 0))
  expect_error(add_description(overwrite = 0))
  
  expect_error(add_description(open = NULL))
  expect_error(add_description(quiet = NULL))
  expect_error(add_description(overwrite = NULL))
  
  expect_error(add_description(open = "false"))
  expect_error(add_description(quiet = "false"))
  expect_error(add_description(overwrite = "false"))
  
  
  ## No Rprofile + Missing arguments ----
  
  # Simulation of no Rprofile (set_credentials() not used)...
  withr::local_options(list("given" = NULL, "family" = NULL, "email" = NULL,
                            "orcid" = NULL)) 
  
  expect_error(
    add_description(organisation = "society", open = FALSE, overwrite = FALSE, 
                    quiet = TRUE)
  )
  
  expect_error(
    add_description(given = "John", organisation = "society", open = FALSE, 
                    overwrite = FALSE, quiet = TRUE)
  )

  expect_error(
    add_description(c("John", "Doe"), organisation = "society", open = FALSE, 
                    overwrite = FALSE, quiet = TRUE)
  )
  
  expect_error(
    add_description(given = "John", family = "Doe", organisation = "society", 
                    open = FALSE, overwrite = FALSE, quiet = TRUE)
  )
})

test_that("Check Creation - Credentials on the fly", {
  
  create_temp_compendium()
  
  expect_invisible(
    add_description("John", "Doe", "john.doe@gmail.com", "9999-9999-9999-9999", 
                    organisation = "society", open = FALSE, overwrite = FALSE, 
                    quiet = TRUE)
  )
  
  expect_true("DESCRIPTION" %in% list.files(getwd()))
})


test_that("Check Creation - Credentials in Rprofile", {
  
  create_temp_compendium()
  
  withr::local_options(list("given" = "john", "family" = "doe", 
                            "email" = "john.doe@gmail.com",
                            "orcid" = "9999-9999-9999-9999"))

  expect_invisible(
    add_description(organisation = "society", open = FALSE, overwrite = FALSE, 
                    quiet = TRUE)
  )
  
  expect_true("DESCRIPTION" %in% list.files(getwd()))
})

test_that("Check Overwrite", {
  
  create_temp_compendium()
  
  withr::local_options(list("given" = "john", "family" = "doe", 
                            "email" = "john.doe@gmail.com",
                            "orcid" = "9999-9999-9999-9999"))
  
  expect_invisible(
    add_description(organisation = "society", open = FALSE, overwrite = FALSE, 
                    quiet = TRUE)
  )
  
  expect_true("DESCRIPTION" %in% list.files(getwd()))
  
  expect_error(
    add_description(organisation = "society", open = FALSE, overwrite = FALSE, 
                    quiet = TRUE)
  )
})

test_that("Check File Content", {
  
  create_temp_compendium()
  
  withr::local_options(list("given" = "john", "family" = "doe", 
                            "email" = "john.doe@gmail.com",
                            "orcid" = "9999-9999-9999-9999"))
  
  add_description(organisation = "society", open = FALSE, overwrite = FALSE, 
                  quiet = TRUE)
  
  expect_length(grep(options()$given,  read_descr()$`Authors@R`), n = 1)
  expect_length(grep(options()$family, read_descr()$`Authors@R`), n = 1)
  expect_length(grep(options()$email,  read_descr()$`Authors@R`), n = 1)
  expect_length(grep(options()$orcid,  read_descr()$`Authors@R`), n = 1)
  
  expect_equal(read_descr()$"Package", "pkgtest")
})

test_that("Check Creation - GitHub Organisation", {
  
  create_temp_compendium()
  
  withr::local_options(list("given" = "john", "family" = "doe", 
                            "email" = "john.doe@gmail.com",
                            "orcid" = "9999-9999-9999-9999"))
 
  add_description(organisation = "society", open = FALSE, overwrite = FALSE, 
                    quiet = TRUE)
  
  expect_equal(read_descr()$"URL", 
               "https://github.com/society/pkgtest")
  
  expect_equal(read_descr()$"BugReports", 
               "https://github.com/society/pkgtest/issues")
})
