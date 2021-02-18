#' Create a Research Compendium
#' 
#' This function creates a new files and folders structure according to the
#' research compendium paradigm. The project will be installed as a package.
#' 
#' @param overwrite a logical value. If a `make.R` is already present and 
#' `overwrite = TRUE`, this file will be erased and replaced.
#' 
#' @export

new_compendium <- function(overwrite = FALSE) {
  
  
  cat(clisymbols::symbol$radio_on, 
      crayon::bold(crayon::underline("Initializing Versioning")))
  ui_line()
  
  
  
  usethis::ui_line()
  if (!dir.exists(".git")) {
    gert::git_init(here::here())
    ui_done("Init {ui_value('git')} versioning.")
  }
  
  if (file.exists(".gitignore")) {
    invisible(file.remove(here::here(".gitignore")))
  }
  
  add_to_gitignore()
  
  
  
  usethis::ui_line()
  cat(clisymbols::symbol$radio_on, 
      crayon::bold(crayon::underline("Creating Package Structure")))
  ui_line()
  
  
  
  ui_line()
  add_to_buildignore(paste0(get_project_name(), ".Rproj"))
  
  ui_line()
  add_description(open = FALSE, overwrite = overwrite)
  ui_todo("Edit project metadata in the {ui_value('DESCRIPTION')} file.")
  
  ui_line()
  ui_done("Writing {ui_value('LICENSE.md (GPL >= 2)')} file.")
  add_to_buildignore("LICENSE.md")
  
  ui_line()
  dir.create(here::here("R"), showWarnings = FALSE)
  ui_done("Creating {ui_value('R/')} directory.")
  ui_todo("Write your R functions in the {ui_value('R/')} directory.")
  
  ui_line()
  dir.create(here::here("man"), showWarnings = FALSE)
  ui_done("Creating {ui_value('man/')} directory.")
  ui_todo("Use {ui_code('devtools::document()')} to add functions helps in {ui_value('man/')} directory.")
  
  ui_line()
  add_package_doc()
  
  
  
  ui_line()
  cat(clisymbols::symbol$radio_on, 
      crayon::bold(crayon::underline("Creating Compendium")))
  ui_line()
  
  
  
  ui_line()
  add_makefile(open = FALSE, overwrite = overwrite)
  add_to_buildignore("make.R")
  ui_todo("Call your R scripts with {ui_code('source()')} in the {ui_value('make.R')} file.")
  
  ui_line()
  dir.create(here::here("analysis"), showWarnings = FALSE)
  ui_done("Creating {ui_value('analysis/')} directory.")
  ui_done("Adding {ui_value('^analysis$')} to {ui_value('.Rbuildignore')}")
  
  ui_line()
  dir.create(here::here("analysis", "data"), showWarnings = FALSE)
  ui_done("Creating {ui_value('analysis/data/')} directory.")
  ui_todo("Add your raw data in the {ui_value('analysis/data/')} directory.")
  
  ui_line()
  dir.create(here::here("analysis", "rscripts"), showWarnings = FALSE)
  ui_done("Creating {ui_value('analysis/rscripts/')} directory.")
  ui_todo("Add your analyses (R scripts) in the {ui_value('analysis/rscripts/')} directory.")
  
  ui_line()
  dir.create(here::here("analysis", "outputs"), showWarnings = FALSE)
  ui_done("Creating {ui_value('analysis/outputs/')} directory.")
  ui_todo("Export your results in the {ui_value('analysis/outputs/')} directory.")
  
  ui_line()
  dir.create(here::here("analysis", "figures"), showWarnings = FALSE)
  ui_done("Creating {ui_value('analysis/figures/')} directory.")
  ui_todo("Export your figures in the {ui_value('analysis/figures/')} directory.")
  
  # add_readme()
  # add_github_actions()
  
  ui_line()
  cat(clisymbols::symbol$radio_on, 
      crayon::bold(crayon::underline("Done!")))
  
  invisible(NULL)
}
