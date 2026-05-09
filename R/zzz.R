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
      "rENM: the following framework packages are not installed and must be\n",
      "  present before rENM() can run:\n",
      paste0("  - ", missing, collapse = "\n")
    )
  } else {
    packageStartupMessage(
      "rENM: all framework packages found. Run rENM(\"ALPH\") to start."
    )
  }
}
