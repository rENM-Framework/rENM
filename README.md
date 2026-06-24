# rENM

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.20785160.svg)](https://doi.org/10.5281/zenodo.20785160)

**Orchestration package for the rENM Framework**

## Overview

`rENM` is the top-level orchestration package for the rENM Framework — a modular system for reconstructing and analyzing long-term ecological niche dynamics using time-indexed environmental data and species occurrence records.

It provides a single exported function, `rENM()`, which runs the complete modeling pipeline for a target species by calling the installed rENM Framework packages in sequence.

## Framework packages

| Package | Role |
|------------------------------------|------------------------------------|
| `rENM.core` | Shared infrastructure: paths, config, logging |
| `rENM.data` | eBird and MERRA data acquisition and preparation |
| `rENM.model` | Occurrence staging, variable screening, time-series construction |
| `rENM.analysis` | Suitability trends, centroids, velocity, hotspot analysis |
| `rENM.ai` | AI package assembly, submission, and document rendering |
| `rENM.reports` | Report tables, summary pages, and final report assembly |

## System requirements

### R

R ≥ 4.1.0. All R package dependencies are installed automatically when you install the Framework packages from GitHub (see below). Two packages pull in notably heavy dependencies:

- **`rENM.model`** — depends on `sdm`, which in turn requires `randomForest`, `gbm`, and `earth` as modeling back-ends. These are listed under `Suggests` and installed on first use.
- **`rENM.analysis`** — depends on `rstanarm` for Bayesian trend estimation. `rstanarm` is large and may take several minutes to compile on first install.

### LibreOffice

Required by `rENM.ai` to convert AI-generated DOCX reports to PDF. 

Download from <https://www.libreoffice.org> and install normally. On macOS, LibreOffice installs to `/Applications` and its `soffice` binary is **not** added to `PATH` automatically. Run this once in Terminal after installing:

``` bash
sudo ln -s /Applications/LibreOffice.app/Contents/MacOS/soffice /usr/local/bin/soffice
```

On Linux, install via your package manager (`apt install libreoffice` or equivalent); `soffice` is placed on `PATH` automatically.

### Chrome or Chromium

Required by `rENM.reports` to render summary tables as PNG and PDF files. The R packages `webshot2`, `pagedown`, and `chromote` (all under `Suggests` in `rENM.reports`) drive a headless Chrome browser for this rendering step.

Install the R packages first:

``` r
install.packages(c("chromote", "webshot2", "pagedown"))
```

Then verify Chrome is found:

``` r
chromote::find_chrome()
```

If that throws an error, install Google Chrome from <https://www.google.com/chrome/> and re-run `chromote::find_chrome()` to confirm. PNG and PDF outputs are silently skipped (with a console note) if Chrome is unavailable; the Excel output is always written regardless.

## Installation

Install all Framework packages from GitHub, then install `rENM`:

``` r
# install.packages("remotes")

remotes::install_github("rENM-Framework/rENM.core")
remotes::install_github("rENM-Framework/rENM.data")
remotes::install_github("rENM-Framework/rENM.model")
remotes::install_github("rENM-Framework/rENM.analysis")
remotes::install_github("rENM-Framework/rENM.ai")
remotes::install_github("rENM-Framework/rENM.reports")
remotes::install_github("rENM-Framework/rENM")
```

## Usage

``` r
library(rENM)

rENM("CASP")
```

The function accepts any four-letter bird banding code. The project directory is resolved automatically via `rENM.core::rENM_project_dir()`, which reads from the `rENM.project_dir` option or the `RENM_PROJECT_DIR` environment variable.

## Pipeline stages

`rENM()` executes the following stages in sequence:

1.  eBird occurrence extraction and preparation
2.  Spatial thinning and record limiting
3.  Range-based extent determination
4.  MERRA environmental variable extraction
5.  Stochastic variable screening
6.  5-year-binned time-series construction
7.  Climatic suitability trend analysis
8.  Centroid, velocity, and hotspot analysis
9.  Report table and summary page compilation
10. AI-ready package assembly and submission
11. AI document rendering
12. Final report assembly

Progress and timing are logged to:

```         
<project-dir>/runs/<alpha_code>/_log.txt
```

## License

See `LICENSE` for details.
