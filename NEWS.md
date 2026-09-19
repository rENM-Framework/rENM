# rENM 0.2.0.9000

- Added a `seed` argument to `rENM()`, defaulting to `42`, making a run reproducible. Several pipeline stages draw on the random number generator — `limit_record_count()` subsamples occurrence records, `screen_by_convergence2()` screens variables, and `create_ensemble_model()` draws background points and replicate partitions — and none were previously seeded, so repeating a run on identical inputs produced different state-level results. Observed between two Pinyon Jay runs sharing the same extent and code: Idaho's positive-trend percentage moved from 98.4 to 11.3, and Oregon's hot spot percentage from 82.1 to 19.5. The seed is recorded in the run log and returned in the result. Passing `seed = NULL` restores the previous per-run random behavior. Note that a fixed seed makes a run repeatable rather than more reliable: it selects one realization from the distribution the pipeline would otherwise sample, and statistics computed over few raster cells stay sensitive to that choice.

- Changed default extent determination to `find_range_extent()`, superseding the `find_occurrence_extent()` default noted below (neither shipped in a release). GAP range exists for effectively every species, including low-occurrence-record "Data Needs" species, and gives state-level and cross-species comparisons a denominator that does not shift between runs as occurrence records accumulate. `find_range_extent()` now buffers the range polygon outward by 250 km before taking its bounding box, so the trend surface is not clipped at the historic range edge; see that function's help for the derivation of the buffer distance.
- Changed default extent determination to find_occurrence_extent().

# rENM 0.1.0

- Initial release.
- Added `rENM()`, the top-level pipeline orchestration function for the rENM framework.
- Added startup messaging via `.onAttach()` that checks for all required framework packages on load.
