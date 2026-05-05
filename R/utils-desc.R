#' Import DESCRIPTION content
#' @noRd
read_descr <- function() {
  path <- build_abs_path("DESCRIPTION")

  if (!file.exists(path)) {
    stop("The file 'DESCRIPTION' does not exist.", call. = FALSE)
  }

  col_names <- colnames(read.dcf(path))
  descr <- read.dcf(path, keep.white = col_names)

  if (nrow(descr) != 1) {
    stop("Malformed 'DESCRIPTION' file")
  }

  as.data.frame(descr, stringsAsFactors = FALSE)
}


#' Write DESCRIPTION (erase content)
#' @noRd
write_descr <- function(descr_file) {
  stop_if_not_project()

  path <- build_abs_path("DESCRIPTION")

  write.dcf(
    descr_file,
    file = path,
    indent = 4,
    width = 80,
    keep.white = colnames(descr_file)
  )

  invisible(NULL)
}
