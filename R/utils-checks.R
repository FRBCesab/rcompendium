## Utilities functions - Inputs Checks ----



#' **Check if arguments are logical of length 1**
#' 
#' @param ... one or several arguments
#' 
#' @noRd

stop_if_not_logical <- function(...) {
  
  args_values <- list(...)
  names(args_values) <- as.list(match.call())[-1]
  
  if (length(args_values)) {
    
    is_logical <- unlist(lapply(args_values, length))
    
    if (any(is_logical != 1)) {
      stop("Argument '", names(is_logical[is_logical != 1])[1], 
           "' must be a logical of length 1.")
    }
    
    is_logical <- unlist(lapply(args_values, is.logical))
    
    if (any(!is_logical)) {
      stop("Argument '", names(is_logical[!is_logical])[1], 
           "' must be a logical of length 1.")
    }
  }
  
  invisible(NULL)
}



#' **Check if arguments are character of length 1**
#' 
#' @param ... one or several arguments
#' 
#' @noRd

stop_if_not_string <- function(...) {

  args_values <- list(...)
  names(args_values) <- as.list(match.call())[-1]
  
  if (length(args_values)) {
    
    is_string <- unlist(lapply(args_values, length))
    
    if (any(is_string != 1)) {
      stop("Argument '", names(is_string[is_string != 1])[1], 
           "' must be a character of length 1.")
    }
    
    is_string <- unlist(lapply(args_values, is.character))
    
    if (any(!is_string)) {
      stop("Argument '", names(is_string[!is_string])[1], 
           "' must be a character of length 1.")
    }
  }
  
  invisible(NULL)
}



#' **Check if arguments are numeric of length 1**
#' 
#' @param ... one or several arguments
#' 
#' @noRd

stop_if_not_numeric <- function(...) {
  
  args_values <- list(...)
  names(args_values) <- as.list(match.call())[-1]
  
  if (length(args_values)) {
    
    is_numeric <- unlist(lapply(args_values, length))
    
    if (any(is_numeric != 1)) {
      stop("Argument '", names(is_numeric[is_numeric != 1])[1], 
           "' must be a numeric of length 1.")
    }
    
    is_numeric <- unlist(lapply(args_values, is.numeric))
    
    if (any(!is_numeric)) {
      stop("Argument '", names(is_numeric[!is_numeric])[1], 
           "' must be a numeric of length 1.")
    }
  }
  
  invisible(NULL)
}
