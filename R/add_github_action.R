#' Set up a GitHub Action workflow
#'
#' @description
#' This function sets up a continuous integration (CI) for an R project hosted
#' on GitHub. It creates a configuration file (`.yaml`) to setup a specific
#' GitHub Action (see below).
#'
#' Available workflows are derived from
#' \url{https://github.com/r-lib/actions/tree/v2-branch/examples} and are
#' hosted on a different repository
#' \url{https://github.com/FRBCesab/r-templates/tree/main/actions}.
#'
#' Configuration files will be written in `.github/workflows/`.
#'
#' @param name A character of length 1. The name of the GitHub Action to set up.
#'   Run [get_available_gh_actions()] to list available GitHub Actions.
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
#' @details
#' Here is a list of commonly used GitHub Actions that will be triggered after
#' each push or pull request:
#'
#' - `R-CMD-check`: check the package integrity on three major operating systems
#' (Ubuntu, macOS, and Windows) using the latest release of R. The package is
#' also checked on Ubuntu (latest version) using the development and previous
#' versions of R.
#'
#' - `test-coverage`: compute and report the code coverage (i.e. the proportion
#' of R code covered by unit tests) to \url{https://about.codecov.io/}.
#'
#' - `pkgdown`: build and publish the `pkgdown` website of the package on a
#' dedicated **gh-pages** branch. The repository may need further configuration
#' (see [usethis::use_pkgdown_github_pages()]).
#'
#' - `check-format`: set up the Air formatter for R and check the code format.
#' This action will fail if any files need to be reformatted with Air.
#'
#' - `render-README`: render the `README.Rmd` only if it has been modified.
#' This action will commit and push the updated `README.md` to the main branch.
#' User need to fetch the new version.
#'
#' - `update-Rd-files`: update the package documentation files (`Rd` files and
#' `NAMESPACE`). This action will commit and push the updated files to the main
#' branch. User need to fetch the new version.
#'
#' - `update-citation-cff`: update the `CITATION.cff`, a human- and
#' machine-readable citation information file. This action is triggered if
#' the `DESCRIPTION` file and/or the `inst/CITATION` file is modified. This
#' action will commit and push the updated `CITATION.cff` to the main branch.
#' User need to fetch the new version.
#'
#' - `update-codemeta`: update the `codemeta.json`, a standardized metadata
#' file for software (not only R packages). This action is triggered if
#' the `DESCRIPTION` file and/or the `inst/CITATION` file and/or the `README.md`
#' is modified. This action will commit and push the updated `codemeta.json` to
#' the main branch. User need to fetch the new version.
#'
#' If one of these GitHub Actions is added to the project, this function will
#' also create a `dependabot.yaml` file in `.github/`. This action will be
#' triggered once a week to check for dependency updates (used by any GitHub
#' Action of the repository). If an update is available, this bot will open a
#' Pull Request and user will be invited to review changes.
#'
#' @return No return value.
#'
#' @export
#'
#' @family development functions
#'
#' @examples
#' \dontrun{
#' add_github_action(name = "R-CMD-check")
#' }

add_github_action <- function(
  name,
  open = FALSE,
  overwrite = FALSE,
  quiet = FALSE
) {
  stop_if_not_project()
  stop_if_not_string(name)
  stop_if_not_logical(open, overwrite, quiet)

  assert_valid_gh_action_name(name)

  rel_path <- build_rel_path(".github", "workflows", paste0(name, ".yaml"))
  full_path <- build_full_path(rel_path)

  assert_file_not_exists_or_overwrite(rel_path, overwrite)

  meta <- resolve_project_meta()

  if (should_create_file(full_path, overwrite)) {
    ensure_dir_exists(dirname(full_path))

    create_template(paste0("actions/", basename(rel_path)), rel_path, meta)

    ui_file_written(rel_path, quiet)
    add_to_buildignore(".github", quiet = quiet)

    add_dependabot(overwrite = overwrite, quiet = quiet)
  }

  open_file_if_needed(full_path, open)

  invisible(NULL)
}
