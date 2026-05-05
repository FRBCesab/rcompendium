#' Get current/default git branch name
#' @noRd
get_git_branch_name <- function() {
  if (should_init_git()) {
    stop("The project is not versioned by git.", call. = FALSE)
  }

  current_branch <- gert::git_branch()

  if (is.null(current_branch)) {
    config <- as.data.frame(gert::git_config_global())

    default_global <- config[
      which(
        config$"name" == "init.defaultbranch" &
          config$"level" == "global"
      ),
      "value"
    ]

    if (length(default_global) == 1) {
      current_branch <- default_global
    } else {
      default_system <- config[
        which(
          config$"name" == "init.defaultbranch" &
            config$"level" == "system"
        ),
        "value"
      ]

      if (length(default_system) == 0) {
        current_branch <- "master"
      } else {
        current_branch <- default_system
      }
    }
  }

  current_branch
}


#' Assert git protocol
#' @param meta a list of the user information.
#' @noRd
stop_if_invalid_git_protocol <- function(meta) {
  if (!is.null(meta$protocol)) {
    if (!(meta$protocol %in% c("https", "ssh"))) {
      stop(
        "Argument 'protocol' must be equal to 'https' or 'ssh'",
        call. = FALSE
      )
    }
  }

  invisible(NULL)
}


#' Check if project is versioned
#' @noRd
should_init_git <- function() {
  !dir.exists(build_abs_path(".git"))
}

#' Initialize git if required
#' @noRd
initialize_git <- function() {
  if (should_init_git()) {
    gert::git_init(build_abs_path())
    ui_done("Initialize {ui_value('git')} versioning") # TODO: change ui
  }

  invisible(NULL)
}


#' Set default git protocol to https and/or rename to 'usethis.protocol'
#' @param meta a list of the user information.
#' @noRd
set_default_git_protocol <- function(meta) {
  if (!("protocol" %in% names(meta))) {
    meta[["usethis.protocol"]] <- "https"
  } else {
    meta[["usethis.protocol"]] <- meta[["protocol"]]
    meta <- meta[!(names(meta) %in% "protocol")]
  }

  meta
}
