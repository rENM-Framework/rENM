# rENM 0.2.0.9000
- The coversheet is rendered with `render_ai_docx(narrative = FALSE)`, so
  runs with `ai = NULL` no longer log false prose-fault warnings.
- `rENM()` now sets the extent before thinning and clips occurrence
  records to it (`rENM.data::clip_occurrences()`). Thinning and the
  250-record cap previously ran first, on every record in a bin, and
  records outside the extent were dropped only later, when `sdm` found no
  predictor values for them. They therefore took places under the cap. For
  Grace's Warbler, whose eBird records extend well into Mexico, only 126 to
  181 of each bin's 250 records reached the models; Pinyon Jay and Cassin's
  Sparrow lost almost none. The step order changed in v0.2.0, when the
  default extent moved from the records themselves to the buffered GAP range.
- The warnings summary in `_log.txt` strips terminal colour codes. Run from
  RStudio, packages that format messages with cli added escape sequences
  such as `[38;5;232m` to the logged text.
- The default `ai` provider is now `"claude"` (was `"chatgpt"`). On the same
  CASP run both providers' narratives passed every check, but ChatGPT's read
  as a filled-in template ("In TX, hot spots cover..." four times) and
  called the GAP range the "GAP extent", while Claude's was better written
  and more specific. With `rENM.ai::submit_to_claude()` now on
  `claude-opus-5-5`, a Claude narrative cost $1.17 against $0.11 for
  ChatGPT. `ai = "chatgpt"` remains available.
- `rENM()` records every warning raised during a run, with the pipeline step
  that raised it, and writes a summary to `_log.txt` when the run ends:
  the total, the number of distinct warnings, and each with its count. A
  batch run under `Rscript` previously ended with "There were 22 warnings"
  and no record of what they were. Warnings still reach the console as
  before.
- When the GenAI step fails, the provider's document is now kept as
  `<CODE>-Suitability-Trend-Analysis-Rejected.docx` before the coversheet
  is written. The coversheet uses the same file name and previously
  overwrote the only local copy of the narrative.
- Added an `ai` argument to `rENM()`, one of `"chatgpt"` (default),
  `"claude"`, or `NULL`, selecting which provider writes the narrative
  interpretation page. `NULL` skips the AI call and substitutes a plain
  coversheet built by `rENM.ai::assemble_coversheet()`: species name,
  included-figures list, framework citation, timestamp, nothing else. The
  same coversheet now stands in whenever a requested provider's call
  fails, so the assembled report always has a title page in that slot,
  where a failed run previously left the page missing entirely. The
  returned list gains `ai`, the provider that was requested.
- `find_trend_percentages()` now runs twice, once on the suitability trend
  and once on the change trend, the second call placed after
  `create_suitability_change_map()` because that is what produces the
  raster it reads. Together the two CSVs supply every area and percentage
  the narrative reports, which previously the language model computed
  itself from the GeoTIFFs.
- The GenAI narrative block no longer aborts the run when it fails. It depends on an external service that can fail for reasons unrelated to the data — a timeout, a rate limit, an outage — and everything of scientific value is computed and written by the time it runs. A failure there previously propagated to the single `tryCatch()` wrapping the whole pipeline and took the entire report-generation block with it, so a flaky API call cost the assembled report even though every input to it already existed. The failure is now logged, the run continues, and the report assembles without that section; `assemble_final_report()` treats the narrative page as optional. The returned list gains `ai_narrative`, a logical recording whether the section was produced.
- Added `rENM.analysis::find_boundary_trend_statistics()` to the pipeline, after `create_hot_spot_map()`. It compares trend behavior inside the GAP range against the surrounding buffer ring, which a range-based statistic cannot show.
- The seed is threaded to `create_timeseries()` as well as `screen_by_convergence2()`. Reproducibility requires the corresponding `rENM.model` changes, since that package previously seeded its ensemble-model workers from the wall clock.
- Added a `seed` argument to `rENM()`, defaulting to `42`, making a run reproducible. Several pipeline stages draw on the random number generator — `limit_record_count()` subsamples occurrence records, `screen_by_convergence2()` screens variables, and `create_ensemble_model()` draws background points and replicate partitions — and none were previously seeded, so repeating a run on identical inputs produced different state-level results. Observed between two Pinyon Jay runs sharing the same extent and code: Idaho's positive-trend percentage moved from 98.4 to 11.3, and Oregon's hot spot percentage from 82.1 to 19.5. The seed is recorded in the run log and returned in the result. Passing `seed = NULL` restores the previous per-run random behavior. Note that a fixed seed makes a run repeatable rather than more reliable: it selects one realization from the distribution the pipeline would otherwise sample, and statistics computed over few raster cells stay sensitive to that choice.
- Changed default extent determination to `find_range_extent()`, superseding the `find_occurrence_extent()` default noted below (neither shipped in a release). GAP range exists for effectively every species, including low-occurrence-record "Data Needs" species, and gives state-level and cross-species comparisons a denominator that does not shift between runs as occurrence records accumulate. `find_range_extent()` now buffers the range polygon outward by 250 km before taking its bounding box, so the trend surface is not clipped at the historic range edge; see that function's help for the derivation of the buffer distance.
- Changed default extent determination to find_occurrence_extent().

# rENM 0.1.0
- Initial release.
- Added `rENM()`, the top-level pipeline orchestration function for the rENM framework.
- Added startup messaging via `.onAttach()` that checks for all required framework packages on load.
