#' Main function to extract, clean and return function names
#' (exported & internal)
#' @noRd
detect_r_function_names <- function() {
  funs <- list(
    "external" = NULL,
    "internal" = NULL
  )

  r_files <- get_r_file_paths()
  r_functions <- read_r_files(r_files)
  r_functions <- extract_r_function_names(r_functions)

  if (length(r_functions) > 0) {
    exported_r_functions <- extract_exported_r_function_names()

    if (length(exported_r_functions) > 0) {
      funs$"external" <- r_functions[(r_functions %in% exported_r_functions)]

      funs$"internal" <- r_functions[!(r_functions %in% exported_r_functions)]
    } else {
      funs$"internal" <- r_functions
    }
  }

  funs
}


#' Extract the name of the exported functions in the NAMESPACE
#' @noRd
extract_exported_r_function_names <- function() {
  path <- build_abs_path("NAMESPACE")

  if (file.exists(path)) {
    namespace <- readLines(
      con = path,
      warn = FALSE
    )

    exported_r_functions <- gsub(
      "export\\(|\\)",
      "",
      namespace[grep("^export", namespace)]
    )

    if (length(exported_r_functions) == 0) {
      return(NULL)
    }
  } else {
    exported_r_functions <- NULL
  }

  exported_r_functions
}


#' Error if the R/ directory does not exist
#' @noRd
stop_if_missing_r_dir <- function() {
  if (!dir.exists(build_abs_path("R"))) {
    stop("The directory 'R/' cannot be found.", call. = FALSE)
  }

  invisible(NULL)
}


#' List the path of all R files in R/
#' @noRd
get_r_file_paths <- function() {
  list.files(
    path = build_abs_path("R"),
    pattern = "\\.R$",
    full.names = TRUE,
    ignore.case = TRUE
  )
}


#' Error if the R/ directory is empty
#' @noRd
stop_if_missing_r_files <- function() {
  if (length(get_r_file_paths()) == 0) {
    stop("The 'R/' folder is empty.", call. = FALSE)
  }
}


#' Import the content of all R files in R/
#' @param path a vector of the R file paths
#' @noRd
read_r_files <- function(path) {
  lapply(path, function(x) readLines(con = x, warn = FALSE))
}


#' Extract (regex) and clean R function names
#' @param x a list of function definitions
#' @noRd
extract_r_function_names <- function(x) {
  x <- lapply(x, function(x) {
    x[grep("\\s{0,}(<-|=)\\s{0,}function\\s{0,}\\(", x)]
  })

  x <- lapply(x, function(x) gsub("\\s", "", x))
  x <- lapply(x, function(x) gsub("(<-|=)function.*", "", x))
  x <- unlist(x)

  pos <- grep("\\(|^error$", x)
  if (length(pos) > 0) {
    x <- x[-pos]
  }

  sort(unique(x))
}
