#' Get current/default git branch name
#' @noRd
get_git_branch_name <- function() {
  if (should_init_git()) {
    return(NULL)
  }

  current_branch <- gert::git_branch()

  if (!is.null(current_branch)) {
    return(current_branch)
  }

  config <- as.data.frame(gert::git_config_global())

  get_default_branch <- function(config, default) {
    val <- config$value[
      config$name == "init.defaultbranch" & config$level == "global"
    ]
    if (length(val) == 1) {
      return(val)
    }

    val <- config$value[
      config$name == "init.defaultbranch" & config$level == "system"
    ]
    if (length(val) == 1) {
      return(val)
    }

    default
  }

  get_default_branch(config, default = "master")
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
