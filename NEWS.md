# rENM 0.2.0.9000

- Changed default extent determination to `find_range_extent()`, superseding the `find_occurrence_extent()` default noted below (neither shipped in a release). GAP range exists for effectively every species, including low-occurrence-record "Data Needs" species, and gives state-level and cross-species comparisons a denominator that does not shift between runs as occurrence records accumulate. `find_range_extent()` now buffers the range polygon outward by 250 km before taking its bounding box, so the trend surface is not clipped at the historic range edge; see that function's help for the derivation of the buffer distance.
- Changed default extent determination to find_occurrence_extent().

# rENM 0.1.0

- Initial release.
- Added `rENM()`, the top-level pipeline orchestration function for the rENM framework.
- Added startup messaging via `.onAttach()` that checks for all required framework packages on load.
