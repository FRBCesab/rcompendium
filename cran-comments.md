## Resubmit comments

* **New features**

  * `get_git_branch_name()` detects git branch name
  * `add_contributing()` adds a `CONTRIBUTING.md` file and issue templates
  * `add_code_of_conduct()` adds a `CODE_OF_CONDUCT.md` file
  * `add_github_actions_citation()` adds a new GitHub action to update the 
  `CITATION.cff` file
  * `add_github_actions_document()` adds a new GitHub action to update `Rd` files,
  the `NAMESPACE` and the `DESCRIPTION` files

* **Improvements**

  * `get_deps_*()` better detects project dependencies
  * `add_compendium()` allows now the user to choose its own compendium structure

* And other minor changes


## Test environments

* Local
  * Arch Linux 6.5.8-arch1-1 install, R 4.3.1
* GitHub Actions
  * macOS 12.7 21G816, R-release (R 4.3.1)
  * Windows Server 2022 10.0.20348, R-release (R 4.3.1)
  * Ubuntu 22.04.3 LTS, R-devel, R-release (R 4.3.1), R-oldrel
* WinBuilder
  * r-devel
  * r-release
  * r-oldrel


## R CMD check results

0 error | 0 warning | 0 note


## Downstream dependencies

There are currently no downstream dependencies for this package.
