#' {{project_name}}: A Research Compendium
#' 
#' @description 
#' A paragraph providing a full description of the project and describing each 
#' step of the workflow.
#' 
#' @author {{given}} {{family}} \email{{{email}}}
#' 
#' @date {{date}}



## Install Dependencies (listed in DESCRIPTION) ----

devtools::install_deps(upgrade = "never")


## Load Project Addins (R Functions and Packages) ----

devtools::load_all(here::here())


## Global Variables ----

# You can list global variables here (or in a separate R script)


## Run Project ----

# List all R scripts in a sequential order and using the following form:
# source(here::here("analyses", "script_X.R"))
