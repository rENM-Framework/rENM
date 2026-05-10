.onAttach <- function(libname, pkgname) {

  pkgs <- c(
    "rENM.core",
    "rENM.data",
    "rENM.model",
    "rENM.analysis",
    "rENM.ai",
    "rENM.reports"
  )

  missing <- pkgs[!vapply(pkgs, requireNamespace, logical(1L), quietly = TRUE)]

  if (length(missing) > 0L) {
    packageStartupMessage(
      "rENM: The following rENM Framework packages are not\n",
      "installed and must be present before rENM() can run:\n",
      paste0("- ", missing, collapse = "\n")
    )
  } else {
    packageStartupMessage(
      "rENM: Welcome to the rENM Framework!\n",
      "      All framework packages are present.\n",
      "      Run rENM(\"alpha_code\") to start ...\n"
    )
  }
}
