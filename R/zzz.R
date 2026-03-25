
.onAttach <- function(libname, pkgname) {
  installed_ver <- as.character(utils::packageVersion("JeffsStatTools"))

  tryCatch({
    github_desc <- readLines(
      "https://raw.githubusercontent.com/JMA61/JeffsStatTools/main/DESCRIPTION",
      warn = FALSE
    )
    ver_line    <- github_desc[grepl("^Version:", github_desc)]
    github_ver  <- trimws(sub("^Version:", "", ver_line))

    if (package_version(github_ver) > package_version(installed_ver)) {
      packageStartupMessage(
        "=======================================================\n",
        " A new version of JeffsStatTools is available (", github_ver, ").\n",
        " You have version ", installed_ver, ".\n",
        " To update, run:\n",
        "   detach('package:JeffsStatTools', unload = TRUE)\n",
        "   remotes::install_github('JMA61/JeffsStatTools')\n",
        "======================================================="
      )
    } else {
      packageStartupMessage("JeffsStatTools v", installed_ver, " is up to date.")
    }
  }, error = function(e) {
    packageStartupMessage("JeffsStatTools v", installed_ver, " loaded.",
                          " (Could not check for updates - no internet connection?)")
  })
}
