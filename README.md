# rENM

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental) [![R-CMD-check](https://github.com/rENM-Framework/rENM/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rENM-Framework/rENM/actions/workflows/R-CMD-check.yaml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Orchestration package for the rENM Framework**

## Overview

`rENM` is the top-level orchestration package for the rENM Framework — a modular system for reconstructing and analyzing long-term ecological niche dynamics using time-indexed environmental data and species occurrence records.

It provides a single exported function, `rENM()`, which runs the complete modeling pipeline for a target species by calling the installed rENM framework packages in sequence.

## Framework packages

| Package | Role |
|----|----|
| `rENM.core` | Shared infrastructure: paths, config, logging |
| `rENM.data` | eBird and MERRA data acquisition and preparation |
| `rENM.model` | Occurrence staging, variable screening, time-series construction |
| `rENM.analysis` | Suitability trends, centroids, velocity, hotspot analysis |
| `rENM.ai` | AI package assembly, submission, and document rendering |
| `rENM.reports` | Report tables, summary pages, and final report assembly |

\## Installation

Install all framework packages from GitHub, then install `rENM`:

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

The function accepts any four-letter bird banding code. The project directory is resolved automatically via `rENM.core::rENM_project_dir()`, or can be supplied explicitly:

``` r
rENM("CASP", project_dir = "/path/to/project")
```

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

MIT © John L. Schnase
