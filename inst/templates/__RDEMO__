#' Print a message
#' 
#' @description
#' This function prints a simple message. This is a demo function to show good
#' practices in writing and documenting R function. If you delete this function
#' do not forget to delete the corresponding test file 
#' `tests/testthat/test-demo.R` if you used `new_package(test = TRUE)`.
#' 
#' @param x a character of length 1. Default is `'Hello world'`.
#'
#' @return The value of `x` (only if the result is assigned to a variable).
#' 
#' @export
#'
#' @examples
#' print_msg()
#' print_msg("Bonjour le monde")
#' 
#' x <- print_msg("Bonjour le monde")
#' x

print_msg <- function(x = "Hello world") {
  
  if (!is.character(x) || length(x) != 1)
    stop("Argument 'x' must be a character of length 1.")
  
  cat(x, "\n")
  
  invisible(x)
}
