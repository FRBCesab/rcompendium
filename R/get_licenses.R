#' List all available licenses
#' 
#' @description
#' This function returns a list of all available licenses. This is particularly
#' useful to get the right spelling of the license to be passed to 
#' [new_package()], [new_compendium()], or [add_license()].
#' 
#' @return 
#' A data frame with the following two variables: 
#' * `tag`, the license name to be used with [add_license()];
#' * `url`, the URL of the license description.
#' 
#' @export
#' 
#' @family utilities functions
#'
#' @examples
#' \dontrun{
#' get_licenses()
#' 
#' ##                      tag                                            url
#' ## 1                    MIT        https://choosealicense.com/licenses/mit
#' ## 2                    CC0    https://choosealicense.com/licenses/cc0-1.0
#' ## 3              CC BY 4.0  https://choosealicense.com/licenses/cc-by-4.0
#' ## 4                  GPL-2    https://choosealicense.com/licenses/gpl-2.0
#' ## 5                  GPL-3    https://choosealicense.com/licenses/gpl-3.0
#' ## 6             GPL (>= 2)    https://choosealicense.com/licenses/gpl-2.0
#' ## 7             GPL (>= 3)    https://choosealicense.com/licenses/gpl-3.0
#' ## 8               LGPL-2.1   https://choosealicense.com/licenses/lgpl-2.1
#' ## 9                 LGPL-3   https://choosealicense.com/licenses/lgpl-3.0
#' ## 10         LGPL (>= 2.1)   https://choosealicense.com/licenses/lgpl-2.1
#' ## 11           LGPL (>= 3)   https://choosealicense.com/licenses/lgpl-3.0
#' ## 12                AGPL-3   https://choosealicense.com/licenses/agpl-3.0
#' ## 13           AGPL (>= 3)   https://choosealicense.com/licenses/agpl-3.0
#' ## 14 Apache License (== 2) https://choosealicense.com/licenses/apache-2.0
#' ## 15 Apache License (>= 2) https://choosealicense.com/licenses/apache-2.0
#' }

get_licenses <- function() licenses[ , c("tag", "url")]
