#' Helper: if x is NULL then y
#' @noRd
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}
