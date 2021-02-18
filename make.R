#' @title Research Compendium of...
#' 
#' @description A paragraph providing a full description of the project and
#' describing each step of the workflow.
#' 
#' @author Nicolas CASAJUS \email{nicolas.casajus@@fondationbiodiversite.fr}
#' 
#' @date 2021/02/17



## Install Dependencies (listed in DESCRIPTION) ----

if (!("remotes" %in% installed.packages())) install.packages("remotes")
remotes::install_deps(upgrade = "never")



## Load Project Addins (R Functions and Packages) ----

devtools::load_all()



## Run Project ----

# source(here::here("analysis", "Rscripts", "filename_1.R"))
# source(here::here("analysis", "Rscripts", "filename_2.R"))
