# Contributing

This document outlines how to propose a change to `rcompendium`.



## Code of Conduct

Please note that the `rcompendium` project is released with a 
[Contributor Code of Conduct](https://frbcesab.github.io/rcompendium/CODE_OF_CONDUCT.html). 
By contributing to this project you agree to abide by its terms.



## Reporting Bugs

You've found a bug in the code. Please follow these two recommendations:

* Visit the [Issues page](https://github.com/frbcesab/rcompendium/issues) and 
check that no one else has encountered the same bug. If you're the first,
* Open an new issue and illustrate the bug with a minimal 
[reprex](https://www.tidyverse.org/help/#reprex). Do not forget to provide R 
session information (you can run: `devtools::session_info()`) so the maintainer 
can troubleshoot.



## Contributing to the code

Please feel free to contribute to `rcompendium` by fixing typos, solving bugs, 
or adding new features. Here is an overview of the contributing workflow:

* [Fork](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo) 
the project and 
[Clone](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository) 
onto your computer. You can use:  
`usethis::create_from_github("frbcesab/rcompendium", fork = TRUE)`.
* Install all dependencies with `remotes::install_deps()`.
* Make sure the package passes **R CMD check** by running `devtools::check()`. 
* Keep your copy up-to-date with the upstream (i.e. `frbcesab/rcompendium`).
  * Add the upstream remote with:
  `gert::git_remote_add(url = "https://github.com/frbcesab/rcompendium.git", name = "upstream")`.
  * Pull changes in from upstream by running `gert::git_pull(remote = "upstream")`.
* Create a new Git branch for your future 
[Pull request](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) 
(PR) with `usethis::pr_init("be-explicit")`.
* Make your changes, document your code (`roxygen2`), and add units tests (`testthat`).
* Do not forget to update documentation (`devtools::document()`) and to check 
(`devtools::check()`) and test (`devtools::test()`) the package.
* Commit changes.
* Create a PR by running `usethis::pr_push()`, and following the prompts in your 
browser. The title of your PR should briefly describe the change. The body of 
your PR should contain more details.
* Discuss your code with the maintainer in the PR thread.
* If everything looks good, the maintainer will merge your code into the project.


## Style

* Make sure code, documentation, and comments are no more than 80 characters in 
width;
* Format your code according to the 
[Tidyverse Style Guide](https://style.tidyverse.org).
* And use the `snake_case` syntax!



## Thanks for contributing!