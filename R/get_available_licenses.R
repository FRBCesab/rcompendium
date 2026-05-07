#' List all available licenses
#'
#' @description
#' This function returns a list of all available licenses. This is particularly
#' useful to get the right spelling of the license to be passed to
#' [create_new_package()], [create_new_compendium()], or [add_license()].
#'
#' @return A `data.frame` with the following two variables:
#' * `tag`, the license name to be used with [add_license()];
#' * `url`, the URL of the license description.
#'
#' @export
#'
#' @family utilities functions
#'
#' @examples
#' get_available_licenses()

get_available_licenses <- function() licenses[, c("tag", "url")]
