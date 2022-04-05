#' Create a Dockerfile
#' 
#' @description
#' This function creates a `Dockerfile` at the root of the project based on a 
#' template. The Docker image is based on 
#' [rocker/rstudio](https://hub.docker.com/r/rocker/rstudio). The whole project
#' will be copied in the image and R packages will be installed (using 
#' [`renv::restore()`] or [`remotes::install_deps()`]).
#' 
#' In addition a `.dockerignore` file is added to ignore some files/folders 
#' while building the image.
#' 
#' User can customize this `Dockerfile` (e.g. system dependencies). He/she 
#' can also use a different default Docker image (i.e. `tidyverse`, `verse`, 
#' `geospatial`, etc.). For more information: 
#' https://github.com/rocker-org/rocker-versioned2
#' 
#' By default the versions of R and `renv` (if applicable) specified in the 
#' `Dockerfile` are the same as the local system.
#' 
#' Once the project is ready to be released, user must build the Docker image by
#' running: `docker build -t "image_name" .`
#' 
#' Then to run a container, user must run:
#' `docker run --rm -p 127.0.0.1:8787:8787 -e DISABLE_AUTH=true image_name`
#' 
#' A new instance of RStudio Server is available on the Web browser at the URL:
#' `127.0.0.1:8787`.
#'   
#' @param open A logical value. If `TRUE` (default) the `Dockerfile` is opened 
#'   in the editor.
#' 
#' @param overwrite A logical value. If this file is already present and 
#'   `overwrite = TRUE`, it will be erased and replaced. Default is `FALSE`.
#'   
#' @param quiet A logical value. If `TRUE` messages are deleted. Default is 
#'   `FALSE`.
#'   
#' @inheritParams set_credentials
#' 
#' @return No return value.
#'
#' @export
#' 
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_dockerfile()
#' }

add_dockerfile <- function(given = NULL, family = NULL, email = NULL, 
                           open = TRUE, overwrite = FALSE, quiet = FALSE) { 
  
  
  stop_if_not_logical(open, overwrite, quiet)
  
  path <- file.path(path_proj(), "Dockerfile")
  
  
  ## Do not replace current file but open it if required ----
  
  if (file.exists(path) && !overwrite) {
    
    if (!open) {
      
      stop("A 'Dockerfile' file is already present. If you want to ",
           "replace it, please use `overwrite = TRUE`.")
      
    } else {
      
      edit_file(path)
      return(invisible(NULL))
    }
  }
  
  
  ## Get fields values ----
  
  if (is.null(given))  given  <- getOption("given")
  if (is.null(family)) family <- getOption("family")
  if (is.null(email))  email  <- getOption("email")
  
  stop_if_not_string(given, family, email)
  
  
  r_version <- paste(utils::sessionInfo()$"R.version"$"major", 
                     utils::sessionInfo()$"R.version"$"minor", sep = ".")
  
  renv_version <- utils::packageVersion("renv")
  
  
  ## Copy Templates ----
  
  invisible(
    file.copy(system.file(file.path("templates", "Dockerfile"), 
                          package = "rcompendium"), path, overwrite = TRUE))
  
  path <- file.path(path_proj(), ".dockerignore")
  
  invisible(
    file.copy(system.file(file.path("templates", "dockerignore"), 
                          package = "rcompendium"), path, overwrite = TRUE))
  
  path <- file.path(path_proj(), "Dockerfile")
  
  
  ## Update default values ----
  
  xfun::gsub_file(path, "{{r_version}}", r_version, fixed = TRUE)
  xfun::gsub_file(path, "{{given}}", given, fixed = TRUE)
  xfun::gsub_file(path, "{{family}}", family, fixed = TRUE)
  xfun::gsub_file(path, "{{email}}", email, fixed = TRUE)
  
  
  ## Install R packages ----
  
  if (file.exists(file.path(path_proj(), "renv.lock"))) {
    
    pattern <- "ENV RENV_VERSION {{renv_version}}\n"
    pattern <- paste0(pattern,
                      "\nRUN R -e \"install.packages('remotes', repos = ", 
                      "c(CRAN = 'https://cloud.r-project.org'))\" \\")
    pattern <- paste0(pattern,
                      "\n && R -e \"remotes::install_github('rstudio/", 
                      "renv@${RENV_VERSION}')\" \\")
    pattern <- paste0(pattern,
                      "\n && sudo -u rstudio R -e \"renv::restore()\"")
    
    xfun::gsub_file(path, "{{install_packages}}", pattern, fixed = TRUE)
    xfun::gsub_file(path, "{{renv_version}}", renv_version, fixed = TRUE)
    
  } else {
    
    pattern <- paste0("RUN R -e \"install.packages('remotes', ", 
                      "repos = c(CRAN = 'https://cloud.r-project.org'))\" \\")
    pattern <- paste0(pattern,
                      "\n && R -e \"remotes::install_deps(upgrade = 'never')\"")
    
    xfun::gsub_file(path, "{{install_packages}}", pattern, fixed = TRUE)
  }
  
  
  ## Update README.Rmd ----
  
  if (file.exists(file.path(path_proj(), "README.Rmd"))) {
  
    pattern <- paste0("```\\{r eval = FALSE\\}\n",
                      "source\\(\"make.R\"\\)\n",
                      "```\n")
    replace <- ""
    gsub_in_file(file.path(path_proj(), "README.Rmd"), pattern, replace)
    
    pattern <- paste0("### Usage\n\n",
                      "Clone the repository, open R/RStudio and run:\n\n")
    replace <- "### Usage"
    gsub_in_file(file.path(path_proj(), "README.Rmd"), pattern, replace)
    
    pattern <- "### Usage"
    replace <- paste0("### Usage\n\n", 
                      "- Clone this repository\n",
                      "- Open a terminal\n",
                      "- Build the Docker image with:\n\n",
                      "```sh\n",
                      "docker build -t \"", get_package_name(), "\" .\n",
                      "```\n\n",
                      "- Start a container based on this image:\n\n",
                      "```sh\n",
                      "docker run --rm -p 127.0.0.1:8787:8787 -e ", 
                      "DISABLE_AUTH=true ", get_package_name(), "\n",
                      "```\n\n",
                      "- On a web browser enter this URL: `127.0.0.1:8787`. ", 
                      "A new RStudio Server\ninstance will be available.\n",
                      "- To run the analysis:\n\n",
                      "```{r eval = FALSE}\n",
                      "source(\"make.R\")\n",
                      "```\n")
    gsub_in_file(file.path(path_proj(), "README.Rmd"), pattern, replace)
  }
  
  ## Message ----
  
  if (!quiet) ui_done("Writing {ui_value('Dockerfile')} file")
  
  add_to_buildignore("Dockerfile", quiet = quiet)
  add_to_buildignore(".dockerignore", quiet = quiet)
  
  if (open) edit_file(path)
  
  invisible(NULL)
}
