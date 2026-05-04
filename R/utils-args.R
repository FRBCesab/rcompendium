#' Check if an argument is a logical of length 1
#' @param x a logical of length 1. Otherwise, an error is returned.
#' @noRd
stop_if_not_logical <- function(x) {
  expr <- substitute(x)
  arg_name <- get_arg_name(expr)

  if (is.null(x)) {
    stop(
      sprintf("The argument '%s' cannot be NULL.", arg_name),
      call. = FALSE
    )
  }

  if (!is.logical(x)) {
    stop(
      sprintf("The argument '%s' must be a logical of length 1.", arg_name),
      call. = FALSE
    )
  }

  if (length(x) != 1) {
    stop(
      sprintf("The argument '%s' must be a logical of length 1.", arg_name),
      call. = FALSE
    )
  }

  if (is.na(x)) {
    stop(
      sprintf("The argument '%s' cannot be NA.", arg_name),
      call. = FALSE
    )
  }

  invisible(TRUE)
}


#' Check if an argument is a character of length 1
#' @param x a character of length 1. Otherwise, an error is returned.
#' @noRd
stop_if_not_string <- function(x) {
  expr <- substitute(x)
  arg_name <- get_arg_name(expr)

  if (is.null(x)) {
    stop(
      sprintf("The argument '%s' cannot be NULL.", arg_name),
      call. = FALSE
    )
  }

  if (!is.character(x)) {
    stop(
      sprintf("The argument '%s' must be a character of length 1.", arg_name),
      call. = FALSE
    )
  }

  if (length(x) != 1) {
    stop(
      sprintf("The argument '%s' must be a character of length 1.", arg_name),
      call. = FALSE
    )
  }

  if (is.na(x)) {
    stop(
      sprintf("The argument '%s' cannot be NA.", arg_name),
      call. = FALSE
    )
  }

  if (identical(x, "")) {
    stop(
      sprintf("The argument '%s' cannot be empty.", arg_name),
      call. = FALSE
    )
  }

  invisible(TRUE)
}


#' Get the name of an argument (works w/ list)
#' @param x a named object.
#' @noRd
get_arg_name <- function(expr) {
  if (is.symbol(expr)) {
    return(as.character(expr))
  }

  if (is.call(expr)) {
    return(as.character(expr[[length(expr)]]))
  }

  deparse(expr)
}
