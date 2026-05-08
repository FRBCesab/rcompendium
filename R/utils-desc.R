#' Import DESCRIPTION content
#' @noRd
read_descr <- function() {
  path <- build_abs_path("DESCRIPTION")

  if (!file.exists(path)) {
    stop("The 'DESCRIPTION' file does not exist.", call. = FALSE)
  }

  raw <- tryCatch(
    read.dcf(path),
    error = function(e) {
      stop("The 'DESCRIPTION' file is not a valid DCF file.", call. = FALSE)
    }
  )

  col_names <- colnames(raw)

  descr <- read.dcf(path, keep.white = col_names)

  if (nrow(descr) != 1) {
    stop("Malformed 'DESCRIPTION' file.", call. = FALSE)
  }

  as.data.frame(descr, stringsAsFactors = FALSE)
}


#' Write DESCRIPTION (erase content)
#' @noRd
write_descr <- function(descr_file) {
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
