# List all available licenses

This function returns a list of all available licenses. This is
particularly useful to get the right spelling of the license to be
passed to
[`new_package()`](https://frbcesab.github.io/rcompendium/reference/new_package.md),
[`new_compendium()`](https://frbcesab.github.io/rcompendium/reference/new_compendium.md),
or
[`add_license()`](https://frbcesab.github.io/rcompendium/reference/add_license.md).

## Usage

``` r
get_licenses()
```

## Value

A `data.frame` with the following two variables:

- `tag`, the license name to be used with
  [`add_license()`](https://frbcesab.github.io/rcompendium/reference/add_license.md);

- `url`, the URL of the license description.

## See also

Other utilities functions:
[`get_all_dependencies()`](https://frbcesab.github.io/rcompendium/reference/get_all_dependencies.md),
[`get_all_functions()`](https://frbcesab.github.io/rcompendium/reference/get_all_functions.md),
[`get_available_gh_actions()`](https://frbcesab.github.io/rcompendium/reference/get_available_gh_actions.md),
[`get_minimal_r_version()`](https://frbcesab.github.io/rcompendium/reference/get_minimal_r_version.md)

## Examples

``` r
get_licenses()
#>                      tag                                             url
#> 1                    MIT        https://choosealicense.com/licenses/mit/
#> 2                    CC0    https://choosealicense.com/licenses/cc0-1.0/
#> 3              CC BY 4.0  https://choosealicense.com/licenses/cc-by-4.0/
#> 4                  GPL-2    https://choosealicense.com/licenses/gpl-2.0/
#> 5                  GPL-3    https://choosealicense.com/licenses/gpl-3.0/
#> 6             GPL (>= 2)    https://choosealicense.com/licenses/gpl-2.0/
#> 7             GPL (>= 3)    https://choosealicense.com/licenses/gpl-3.0/
#> 8               LGPL-2.1   https://choosealicense.com/licenses/lgpl-2.1/
#> 9                 LGPL-3   https://choosealicense.com/licenses/lgpl-3.0/
#> 10         LGPL (>= 2.1)   https://choosealicense.com/licenses/lgpl-2.1/
#> 11           LGPL (>= 3)   https://choosealicense.com/licenses/lgpl-3.0/
#> 12                AGPL-3   https://choosealicense.com/licenses/agpl-3.0/
#> 13           AGPL (>= 3)   https://choosealicense.com/licenses/agpl-3.0/
#> 14 Apache License (== 2) https://choosealicense.com/licenses/apache-2.0/
#> 15 Apache License (>= 2) https://choosealicense.com/licenses/apache-2.0/
```
