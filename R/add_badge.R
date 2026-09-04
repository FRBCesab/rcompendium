#' **Add a badge to the README.Rmd**
#'
#' @param badge a Markdown expression.
#' @param pattern a special tag (i.e. 'LifeCycle', 'Project Status',
#'   'CRAN status', 'License', 'R-CMD-check')
#'
#' @noRd

add_badge <- function(badge, pattern) {
  path <- build_abs_path()

  ## Checks ----

  if (missing(badge)) {
    stop("No badge to add in the 'README.Rmd'.")
  }
  if (missing(pattern)) {
    stop("Argument 'pattern' is missing.")
  }

  if (!file.exists(file.path(path, "README.Rmd"))) {
    stop("The file 'README.Rmd' cannot be found.")
  }

  ## Read README.Rmd ----

  read_me <- readLines(con = file.path(path, "README.Rmd"))

  ## Check if Badges Locations are present ----

  badge_start <- grep("<!-- badges: start -->", read_me)
  badge_end <- grep("<!-- badges: end -->", read_me)

  if (!length(badge_start) || !length(badge_end)) {
    stop(
      "Unable to parse badges location in 'README.Rmd' file.\n",
      "Did you remove the tag '<!-- badges: start -->' and/or ",
      "'<!-- badges: end -->'?"
    )
  }

  ## Extract existing badges (if exist) ----

  if ((badge_start + 1) == badge_end) {
    badges <- character(0)
  } else {
    badges <- paste0(
      read_me[(badge_start + 1):(badge_end - 1)],
      collapse = "\n"
    )
    badges <- unlist(strsplit(badges, "\n"))
    badges <- badges[badges != ""]
  }

  ## Replace/Add badge ----

  pos <- grep(paste0("^\\s{0,}\\[!\\[", pattern), badges)

  if (length(pos)) {
    badges[pos] <- badge
  } else {
    badges <- c(badges, badge)
  }

  read_me <- c(
    read_me[1:badge_start],
    badges,
    read_me[badge_end:length(read_me)]
  )

  ## Replace README.Rmd ----

  writeLines(read_me, con = file.path(path, "README.Rmd"))

  invisible(NULL)
}
