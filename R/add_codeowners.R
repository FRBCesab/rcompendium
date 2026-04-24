#' Create a CODEOWNERS file
#'
#' @description
#' This function creates a `CODEOWNERS` file in the folder `.github/`. This
#' file is used to define individual that is responsible for code in the
#' repository.
#'
#' @param open A logical value. If `TRUE` (default) the file is opened in the
#'   editor.
#'
#' @param overwrite A logical value. If this file is already present and
#'   `overwrite = TRUE`, it will be erased and replaced. Default is `FALSE`.
#'
#' @param quiet A logical value. If `TRUE` messages are deleted. Default is
#'   `FALSE`.
#'
#' @return No return value.
#'
#' @export
#'
#' @family create files
#'
#' @examples
#' \dontrun{
#' add_codeowners()
#' }

add_codeowners <- function(
  open = FALSE,
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_logical(open, overwrite, quiet)

  ## Check if user is using git ----

  if (!dir.exists(file.path(path_proj(), ".git"))) {
    stop("The project is not versioned with git.")
  }

  ## Get GitHub account name ----

  github <- gh::gh_whoami()$"login"

  if (is.null(github)) {
    stop(
      "Unable to find GitHub username. Please run ",
      "`?gert::git_config_global` for more information."
    )
  }

  ## Define file name & path ----

  filename <- "CODEOWNERS"
  path <- ".github"

  ## Create folder ----

  dir.create(
    file.path(path_proj(), path),
    showWarnings = FALSE,
    recursive = TRUE
  )

  add_to_buildignore(".github", quiet = FALSE)

  ## Do not replace current file but open it if required ----

  if (file.exists(file.path(path_proj(), path, filename)) && !overwrite) {
    if (!open) {
      stop(
        paste0(
          "A '",
          file.path(path, filename),
          "' file already exists. ",
          "If you want to replace it, please use `overwrite = TRUE`."
        )
      )
    } else {
      edit_file(file.path(path_proj(), path, filename))
      return(invisible(NULL))
    }
  }

  codeowner <- paste0("* @", github)

  writeLines(codeowner, con = file.path(path_proj(), path, filename))

  if (!quiet) {
    ui_done(paste0(
      "Writing {ui_value('",
      file.path(path, filename),
      "')} file"
    ))
  }

  if (open) {
    edit_file(path)
  }

  invisible(NULL)
}
